////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by HTM    /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
enum houseInt
{
	intClass[16],
	intID,
	Float:intX,
	Float:intY,
	Float:intZ,
	Float:intA
};

new const houseInteriors[][houseInt] =
{
    {"Apartment",    1,  244.1997, 305.0676, 999.1484, 270.2194}, //ok
	{"Apartment",	 4,  299.7807, 309.7425, 1003.3047, 267.8639}, //ok
	{"Apartment", 	 10, 2259.7649, -1135.8751, 1050.6328, 270.0000}, //ok
	{"Apartment", 	 1,  223.1123, 1287.0787, 1082.1406, 356.7259}, //ok
	{"Apartment", 	 5,  2233.6501, -1114.7767, 1050.8828, 0.0000}, //ok
	{"Apartment", 	 1,  2217.9814, -1076.2471, 1050.4844, 90.0000}, //ok
	{"Apartment", 	 50, 1542.1735, -1889.4218, 801.1019, 357.5531}, //Custom Interior
	{"Apartment", 	 100, 78.0497, 2508.8940, 16.5412, 358.4431}, //Custom Interior
	
	{"Low Class", 	 4,  261.0436, 1284.4060, 1080.2578, 359.3296}, //ok
	{"Low Class", 	 3,  2495.8130, -1692.4081, 1014.7422, 176.8667}, //ok
	{"Low Class", 	 8,  2365.2061, -1135.4470, 1050.8826, 359.9821}, //ok
	{"Low Class", 	 52, 669.3445, -1691.2446, -25.7441, 182.0814}, //Custom Interior
	
	{"Medium Class", 2,  2468.5125, -1698.1383, 1013.5078, 90.6993}, //ok
	{"Medium Class", 9,  260.7876, 1237.2328, 1084.2578, 2.0856}, //ok
	{"Medium Class", 2,  447.0784, 1397.0935, 1084.3047, 0.1994}, //ok
	{"Medium Class", 53, 421.7890, 495.9678, 1001.5299, 93.4107}, //Custom Interior
	
	
	{"Upper Class",  10, 24.0001, 1340.2637, 1084.3750, 359.5273}, //ok
	{"Upper Class",  9,  83.0614, 1322.3866, 1083.8662, 356.8905}, //ok
	{"Upper Class",  12, 2324.3862, -1148.8784, 1050.7101, 0.0000}, //ok
	{"Upper Class",  5,  226.3026, 1114.2562, 1080.9929, 270.32810}, //ok
	{"Upper Class", 54,  1237.2312, -667.7290, 1085.6919, 181.7447}, //Custom Interior
	
	
	{"Mansion", 	 6,  234.1191, 1063.9872, 1084.2119, 0.7466}, //ok
	{"Mansion", 	 7,  225.6954, 1021.5493, 1084.0175, 357.5153}, //ok
	{"Mansion",      5,  1298.8682, -796.2053, 1084.0078, 0.0000}, //ok
	{"Mansion",      55,  324.4900, -1579.4270, 10.1469, 181.1414}, //Custom Interior
	{"Mansion",      56,  1676.7893, -1459.5099, 3002.8413, 92.3970} //Custom Interior
};

forward OnAdminCreateHouse(playerid, houseid, type, Float:x, Float:y, Float:z, Float:angle);
public OnAdminCreateHouse(playerid, houseid, type, Float:x, Float:y, Float:z, Float:angle)
{
	strcpy(HouseInfo[houseid][hOwnerName], "Nobody", MAX_PLAYER_NAME);
	strcpy(HouseInfo[houseid][hDescription], houseInteriors[type][intClass], 16);
	//HouseInfo[houseid][hExists] = 1;
	HouseInfo[houseid][hSQLId] = cache_insert_id();
	HouseInfo[houseid][hSQLId] = houseid;
	HouseInfo[houseid][hOwnerID] = -1;
	//HouseInfo[houseid][hValue] = houseInteriors[type][intPrice];
	HouseInfo[houseid][hLevel] = 1;
	HouseInfo[houseid][hLock] = 0;
	HouseInfo[houseid][hExteriorX] = x;
	HouseInfo[houseid][hExteriorY] = y;
	HouseInfo[houseid][hExteriorZ] = z;
	HouseInfo[houseid][hExteriorA] = angle;
	HouseInfo[houseid][hInteriorX] = houseInteriors[type][intX];
	HouseInfo[houseid][hInteriorY] = houseInteriors[type][intY];
	HouseInfo[houseid][hInteriorZ] = houseInteriors[type][intZ];
	HouseInfo[houseid][hInteriorA] = houseInteriors[type][intA];
	HouseInfo[houseid][hIntVW] = houseid + 1000000;
	HouseInfo[houseid][hIntIW] = houseInteriors[type][intID];
	HouseInfo[houseid][hExtIW] = GetPlayerInterior(playerid);
	HouseInfo[houseid][hExtVW] = GetPlayerVirtualWorld(playerid);
	HouseInfo[houseid][hSafeMoney] = 0;
	HouseInfo[houseid][hMaterials] = 0;
	SaveHouse(houseid);
	ReloadHousePickup(houseid);
	ReloadHousePickup2(houseid);
	SendClientMessageEx(playerid, COLOR_GREEN, "** House %i created successfully.", houseid);
}
CMD:createhouse(playerid, params[])
{
    new price, type, Float:x, Float:y, Float:z, Float:a;

    if(PlayerInfo[playerid][pAdmin] < 4)
    {
        return SendErrorMessage(playerid, "You are not authorized to use this CMD.");
    }

    if(sscanf(params, "ii", type, price))
    {
        SendClientMessageEx(playerid, COLOR_GREY, "/createhouse [type (1-%i)] [price]", sizeof(houseInteriors));
        SendClientMessageEx(playerid, COLOR_GREY, "(1-8) Apartments / (9-12) Low Class / (13-16) Medium Class / (17-21) Upper Class / (22-%i) Mansion", sizeof(houseInteriors));
        return 1;
    }

    if(!(1 <= type <= sizeof(houseInteriors)))
    {
        return SendErrorMessage(playerid, "Invalid type.");
    }

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    type--;
    

    // Find the first available house ID starting from 0
    new houseID = -1;
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(HouseInfo[i][hExteriorX] == 0.0) // If the house is at blueberry!
        {
            houseID = i;
            HouseInfo[i][hValue] = price;
            break;
        }
    }

    if(houseID != -1)
    {
        // Call the function to handle house creation
        OnAdminCreateHouse(playerid, houseID, type, x, y, z, a);

        // Insert house information into MySQL
        new query[256];
        format(query, sizeof(query), "INSERT INTO `houses` (ID, ExteriorX, ExteriorY, ExteriorZ, ExteriorA, ExtIW, ExtVW) VALUES ('%d', '%f', '%f', '%f', '%f', '%d', '%d')",
        houseID, x, y, z, a, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
        mysql_query(MainPipeline, query);

        return 1;
    }
    else
    {
        SendErrorMessage(playerid, "House slots are currently full.");
        return 1;
    }
}
CMD:removehouse(playerid, params[])
{
	new houseid, string[64];
	szMiscArray[0] = 0;
	
	if(PlayerInfo[playerid][pAdmin] < 4)
	{
	    return SendErrorMessage(playerid, "You are not authorized to use this CMD.");
	}
	if(sscanf(params, "i", houseid))
	{
	    return SendSyntaxMessage(playerid, "/removehouse [houseid]");
	}
	
	/*DestroyDynamicPickup(HouseInfo[houseid][hPickupID]);
	DestroyDynamic3DTextLabel(HouseInfo[houseid][hTextID]);

	mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "DELETE FROM houses WHERE id = %i", HouseInfo[houseid][hSQLId]);
	mysql_tquery(MainPipeline, szMiscArray, "OnQueryFinish", "i", SENDDATA_THREAD);
	
	HouseInfo[houseid][hExists] = 0;
	HouseInfo[houseid][hSQLId] = 0;
	HouseInfo[houseid][hOwnerID] = -1;
	HouseInfo[houseid][hExteriorX] = 0;
	HouseInfo[houseid][hExteriorY] = 0;
	HouseInfo[houseid][hExteriorZ] = 0;
	SendClientMessageEx(playerid, COLOR_WHITE, "** You have deleted house %i.", houseid);

	format(string, sizeof(string), "%s has deleted HouseID %d.", GetPlayerNameEx(playerid), houseid);
	Log("logs/hedit.log", string);*/
	if(!IsValidHouseID(houseid)) return SendClientMessageEx(playerid, COLOR_GREY, "Invalid house ID");

	// Do not reset the SQL ID as the house still exists but is not owned by any player and it isn't spawned
	HouseInfo[houseid][hOwned] = 0;
	HouseInfo[houseid][hLevel] = 0;
	HouseInfo[houseid][hCustomInterior] = 0;
	HouseInfo[houseid][hOwnerID] = -1;
	format(HouseInfo[houseid][hOwnerName], 128, "Nobody");
	HouseInfo[houseid][hExteriorX] = 0.0;
	HouseInfo[houseid][hExteriorY] = 0.0;
	HouseInfo[houseid][hExteriorZ] = 0.0;
	HouseInfo[houseid][hExteriorR] = 0.0;
	HouseInfo[houseid][hExteriorA] = 0.0;
	HouseInfo[houseid][hInteriorX] = 0.0;
	HouseInfo[houseid][hInteriorY] = 0.0;
	HouseInfo[houseid][hInteriorZ] = 0.0;
	HouseInfo[houseid][hInteriorR] = 0.0;
	HouseInfo[houseid][hInteriorA] = 0.0;
	HouseInfo[houseid][hExtIW] = 0;
	HouseInfo[houseid][hExtVW] = 0;
	HouseInfo[houseid][hIntIW] = 0;
	HouseInfo[houseid][hIntVW] = 0;
	HouseInfo[houseid][hLock] = 0;
	HouseInfo[houseid][hRentable] = 0;
	HouseInfo[houseid][hRentFee] = 0;
	HouseInfo[houseid][hValue] = 0;
	HouseInfo[houseid][hSafeMoney] = 0;
	HouseInfo[houseid][hPot] = 0;
	HouseInfo[houseid][hCrack] = 0;
	HouseInfo[houseid][hMaterials] = 0;
	HouseInfo[houseid][hHeroin] = 0;
	HouseInfo[houseid][hEcstasy] = 0;
	HouseInfo[houseid][hMeth] = 0;
	HouseInfo[houseid][hWeapons][0] = 0;
	HouseInfo[houseid][hWeapons][1] = 0;
	HouseInfo[houseid][hWeapons][2] = 0;
	HouseInfo[houseid][hWeapons][3] = 0;
	HouseInfo[houseid][hWeapons][4] = 0;
	HouseInfo[houseid][hGLUpgrade] = 0;
	if(IsValidDynamicPickup(HouseInfo[houseid][hPickupID])) DestroyDynamicPickup(HouseInfo[houseid][hPickupID]);
	if(IsValidDynamic3DTextLabel(HouseInfo[houseid][hTextID])) DestroyDynamic3DTextLabel(HouseInfo[houseid][hTextID]);
	HouseInfo[houseid][hCustomExterior] = 0;
	HouseInfo[houseid][hMailX] = 0.0;
	HouseInfo[houseid][hMailY] = 0.0;
	HouseInfo[houseid][hMailZ] = 0.0;
	HouseInfo[houseid][hMailA] = 0.0;
	HouseInfo[houseid][hMailType] = 0;
	if(IsValidDynamicObject(HouseInfo[houseid][hMailObjectId])) DestroyDynamicObject(HouseInfo[houseid][hMailObjectId]);
	if(IsValidDynamic3DTextLabel(HouseInfo[houseid][hMailTextID])) DestroyDynamic3DTextLabel(HouseInfo[houseid][hMailTextID]);
	HouseInfo[houseid][hClosetX] = 0.0;
	HouseInfo[houseid][hClosetY] = 0.0;
	HouseInfo[houseid][hClosetZ] = 0.0;
	if(IsValidDynamic3DTextLabel(HouseInfo[houseid][hClosetTextID])) DestroyDynamic3DTextLabel(HouseInfo[houseid][hClosetTextID]);
	SaveHouse(houseid);
	ReloadHousePickup(houseid);
	ReloadHousePickup2(houseid);
	format(string, sizeof(string), "You have deleted house id %d.", houseid);
	SendClientMessageEx(playerid, COLOR_WHITE, string);
	format(string, sizeof(string), "%s has deleted house id %d", GetPlayerNameEx(playerid), houseid);
	Log("logs/hedit.log", string);
	return 1;
}
