////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>

#define MAX_DROP_ITEMS 1000//Change it to set the max weapons that can be dropped.

enum dData
{
    DropGunModelID,
    DropGunAmmo,
    Float:DropGunPosX,
    Float:DropGunPosY,
    Float:DropGunPosZ,
    DropGunVWorld,
    DropGunInterior,
    IsUsed, // Additional flag to mark if the slot is used
}

new DropInfo[MAX_DROP_ITEMS][dData];
new DropObject[MAX_DROP_ITEMS]; // Define DropObject array
new GunObjectIDs[200] = {
    1575, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324, 325, 326, 342, 343, 344, -1, -1, -1,
    346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367,
    368, 369, 1575
};

new WeaponNames[][32] = {
    "", "Brass Knuckles", "Golf Club", "Nightstick", "Knife", "Baseball Bat", "Shovel", "Pool Cue",
    "Katana", "Chainsaw", "Purple Dildo", "Dildo", "Vibrator", "Silver Vibrator", "Flowers",
    "Cane", "Grenade", "Tear Gas", "Molotov", "Rocket", "Rocket HS", "Freefall Bomb", "Pistol",
    "Pistol Silenced", "Desert Eagle", "Shotgun", "Sawed-Off Shotgun", "Combat Shotgun", "Uzi",
    "MP5", "AK47", "M4", "Tec9", "Rifle", "Sniper Rifle", "Rocket Launcher", "Heat-Seeking RPG",
    "Flamethrower", "Minigun", "Satchel Charge", "Detonator", "Spray Can", "Fire Extinguisher",
    "Camera", "Night Vision Goggles", "Thermal Goggles", "Parachute"
};


stock GetGunObjectID(WeaponID)
{
    if (WeaponID < 0 || WeaponID > 64)
    {
        return 1575;
    }
    return GunObjectIDs[WeaponID];
}

stock DropGun(playerid, GunID, GunAmmo, Float:X, Float:Y, Float:Z, world, interior)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    if (GunID != 0 && GunAmmo != 0)
    {
        for (new i = 0; i < sizeof(DropInfo); i++)
        {
            if (!DropInfo[i][IsUsed])
            {
                DropInfo[i][DropGunModelID] = GunID;
                DropInfo[i][DropGunAmmo] = GunAmmo;
                DropInfo[i][DropGunPosX] = X;
                DropInfo[i][DropGunPosY] = Y;
                DropInfo[i][DropGunPosZ] = Z;
                DropInfo[i][DropGunVWorld] = world;
                DropInfo[i][DropGunInterior] = interior;
                DropInfo[i][IsUsed] = true;
                DropObject[i] = CreateDynamicObject(GetGunObjectID(GunID), X, Y, Z-1, 80.0, 0.0, 0.0, world);
                return 1;
            }
        }
        return 1;
    }
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    new Float:X, Float:Y, Float:Z;
    GetPlayerPos(playerid, X, Y, Z);
    DropGun(playerid, GetPlayerWeapon(playerid), GetPlayerAmmo(playerid), X, Y, Z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

	if(newkeys & KEY_YES)
	{
	    for (new i = 0; i < sizeof(DropInfo); i++)
    	{
			if (DropInfo[i][IsUsed] && IsPlayerInRangeOfPoint(playerid, 2.0, DropInfo[i][DropGunPosX], DropInfo[i][DropGunPosY], DropInfo[i][DropGunPosZ]))
	        {
	            if (GetPlayerVirtualWorld(playerid) == DropInfo[i][DropGunVWorld] && GetPlayerInterior(playerid) == DropInfo[i][DropGunInterior])
	            {
	                new sendername[MAX_PLAYER_NAME], string[128]; // Adjust size as needed
	                GetPlayerName(playerid, sendername, sizeof(sendername));
	                DestroyDynamicObject(DropObject[i]);
	                DropInfo[i][IsUsed] = false;
	                GivePlayerValidWeapon(playerid, DropInfo[i][DropGunModelID]);
	                format(string, sizeof(string), "* %s picks up a weapon from the pavement.", sendername);
                 	SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 4000);
					ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	                PlayAnimEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
   					SetTimerEx("ClearAnims", 2000, false, "d", playerid);
	                return 1;
	            }
	        }
	    }
	}
	return 1;
}

CMD:dropgun(playerid, params[])
{
    new Float:X, Float:Y, Float:Z;
    new GunID = GetPlayerWeapon(playerid);
    new GunAmmo = GetPlayerAmmo(playerid);
    new sendername[MAX_PLAYER_NAME];
    new string[128]; // Adjust size as needed
    GetPlayerName(playerid, sendername, sizeof(sendername));
    GetPlayerPos(playerid, X, Y, Z);
    RemovePlayerWeapon(playerid, GunID);
    DropGun(playerid, GunID, GunAmmo, X, Y, Z, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    format(string, sizeof(string), "* %s drops %s %s to the pavement.", sendername, CheckSex(playerid), WeaponNames);
    SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 4000);
	ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    PlayAnimEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
    SetTimerEx("ClearAnims", 2000, false, "d", playerid);
    return 1;
}

CMD:pickupgun(playerid, params[])
{
    new sendername[MAX_PLAYER_NAME];
    new string[128]; // Adjust size as needed
    for (new i = 0; i < sizeof(DropInfo); i++)
    {
        if (DropInfo[i][IsUsed] && IsPlayerInRangeOfPoint(playerid, 2.0, DropInfo[i][DropGunPosX], DropInfo[i][DropGunPosY], DropInfo[i][DropGunPosZ]))
        {
            if (GetPlayerVirtualWorld(playerid) == DropInfo[i][DropGunVWorld] && GetPlayerInterior(playerid) == DropInfo[i][DropGunInterior])
            {
                GetPlayerName(playerid, sendername, sizeof(sendername));
                DestroyDynamicObject(DropObject[i]);
                DropInfo[i][IsUsed] = false;
                GivePlayerValidWeapon(playerid, DropInfo[i][DropGunModelID]);
                format(string, sizeof(string), "* %s picks up a weapon from the pavement.", sendername);
                SetPlayerChatBubble(playerid, string, COLOR_PURPLE, 30.0, 4000);
				ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                PlayAnimEx(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
               	SetTimerEx("ClearAnims", 2000, false, "d", playerid);
                return 1;
            }    									
        }
    }
    return 1;
}
