////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#define		MAX_LOCATIONS			100
enum locEnum
{
	locID,
	locName[32],
	bool:locExists,
	Float:locPosX,
	Float:locPosY,
	Float:locPosZ
};
new LocationInfo[MAX_LOCATIONS][locEnum];
forward OnAdminCreateLocation(playerid, location, name[], Float:x, Float:y, Float:z);
public OnAdminCreateLocation(playerid, location, name[], Float:x, Float:y, Float:z)
{
	LocationInfo[location][locID] = cache_insert_id();
	LocationInfo[location][locExists] = true;
	strcpy(LocationInfo[location][locName], name, 32);
    LocationInfo[location][locPosX] = x;
    LocationInfo[location][locPosY] = y;
    LocationInfo[location][locPosZ] = z;

    SendClientMessageEx(playerid, COLOR_GREEN, "** Location [%i] %s created at %.1f, %.1f, %.1f.", location, name, x, y, z);
}
stock LoadDynamicLocations()
{
	printf("[LoadDynamicLocations] Loading data from database...");
	mysql_tquery(MainPipeline, "SELECT * FROM `locations`", "OnLoadDynamicLocations", "");
}
forward OnLoadDynamicLocations();
public OnLoadDynamicLocations()
{
	new i, rows, tmp[128];
	cache_get_row_count(rows);
	for(i = 0; i < rows && i < MAX_LOCATIONS; i ++)
	{
		cache_get_value_name(i, "id", tmp);  LocationInfo[i][locID] = strval(tmp);
		cache_get_value_name(i, "name", LocationInfo[i][locName] , 64);
		cache_get_value_name(i, "pos_x", tmp); LocationInfo[i][locPosX] = floatstr(tmp);
		cache_get_value_name(i, "pos_y", tmp); LocationInfo[i][locPosY] = floatstr(tmp);
		cache_get_value_name(i, "pos_z", tmp); LocationInfo[i][locPosZ] = floatstr(tmp);
		LocationInfo[i][locExists] = true;

	}
	if(i > 0) printf("[LoadDynamicLocations] %d locations rehashed/loaded.", i);
	else printf("[LoadDynamicLocations] Failed to load any locations.");
	return 1;
}
CMD:createlocation(playerid, params[])
{
    new name[32], Float:x, Float:y, Float:z, query[128];
    if(PlayerInfo[playerid][pAdmin] < 4)
    {
        return SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    if(sscanf(params, "s[32]", name))
	{
	    SendClientMessage(playerid, COLOR_GREY, "USAGE: /createlocation [name]");
		SendClientMessage(playerid, COLOR_GREY, "** NOTE: The location will be created at the coordinates you are standing on.");
		return 1;
	}
	if(GetPlayerInterior(playerid) != 0 || GetPlayerVirtualWorld(playerid) != 0)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "Your virtual world & interior must be 0!");
	}
    GetPlayerPos(playerid, x, y, z);
    for(new i = 0; i < MAX_LOCATIONS; i ++)
	{
		if(!LocationInfo[i][locExists])
		{
		    mysql_format(MainPipeline, query, sizeof(query), "INSERT INTO locations VALUES(null, '%e', '%f', '%f', '%f')", name, x, y, z);
		    mysql_tquery(MainPipeline, query, "OnAdminCreateLocation", "iisfff", playerid, i, name, x, y, z);
		    return 1;
		}
	}

	SendClientMessage(playerid, COLOR_GREY, "Location slots are currently full.");
	return 1;
}
CMD:removelocation(playerid, params[])
{
	new loc, query[128];

	if(PlayerInfo[playerid][pAdmin] < 4)
	{
	    return SendErrorMessage(playerid,"You are not authorized to use this CMD.");
	}
	if(sscanf(params, "i", loc))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "USAGE: /removelocation [locationid]");
	}
	if(!(0 <= loc < MAX_LOCATIONS) || !LocationInfo[loc][locExists])
	{
	    return SendClientMessage(playerid, COLOR_GREY, "Invalid location.");
	}

	mysql_format(MainPipeline, query, sizeof(query), "DELETE FROM locations WHERE id = %i", LocationInfo[loc][locID]);
	mysql_tquery(MainPipeline, query, "OnQueryFinish", "i", SENDDATA_THREAD);
	LocationInfo[loc][locName][0] = EOS;
	LocationInfo[loc][locExists] = false;
	LocationInfo[loc][locID] = 0;

	SendClientMessageEx(playerid, COLOR_WHITE, "** You have removed location %i.", loc);
	return 1;
}
CMD:locnear(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		SendClientMessageEx(playerid, COLOR_RED, "* Listing all dynamic locations within 30 meters of you...");
		for(new i, szMessage[128]; i < MAX_LOCATIONS; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 30, LocationInfo[i][locPosX], LocationInfo[i][locPosY], LocationInfo[i][locPosZ]))
			{
				format(szMessage, sizeof(szMessage), "Location ID %d | %f from you", i, GetPlayerDistanceFromPoint(playerid, LocationInfo[i][locPosX], LocationInfo[i][locPosY], LocationInfo[i][locPosZ]));
				SendClientMessageEx(playerid, COLOR_WHITE, szMessage);
			}
		}
	}
	else
	{
	    SendErrorMessage(playerid,"You are not authorized to use this CMD.");
	}
	return 1;
}
