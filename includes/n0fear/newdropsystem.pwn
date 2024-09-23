////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// Beta for now           /////
////////////////////////////////////////////


#include <YSI\y_hooks>

#define MAX_OBJ 50

new GunNames[49][] =
{
	"Nothink", "Brass Knuckles", "Golf Club", "Nitestick", "Knife", "Baseball Bat",
	"Showel", "Pool Cue", "Katana", "Chainsaw", "Purple Dildo", "Small White Dildo",
	"Long White Dildo", "Vibrator", "Flowers", "Cane", "Grenade", "Tear Gas", "Molotov",
	"Vehicle Missile", "Hydra Flare", "Jetpack", "Glock", "Silenced Colt", "Desert Eagle",
	"Shotgun", "Sawn Off", "Combat Shotgun", "Micro UZI", "MP5", "AK47", "M4", "Tec9",
	"Rifle", "Sniper Rifle", "Rocket Launcher", "HS Rocket Launcher", "Flamethrower", "Minigun",
	"Satchel Charge", "Detonator", "Spraycan", "Fire Extinguisher", "Camera", "Nightvision",
	"Infrared Vision", "Parachute", "Fake Pistol", "Weed"
};
//----------------------------------------------------------
new GunobjectIds[200] =
{
   1575,  331, 333, 334, 335, 336, 337, 338, 339, 341, 321, // 0 - 10
   322, 323, 324, 325, 326, 342, 343, 344, -1,  -1 , -1 , // 11 - 21
   346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, // 22 - 32
   357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, // 33 - 43
   368, 369, 1575 , 1575 , 1575 , 1575 , 1575 , 1575 , 1575 , 1575 , 1575 , // 54 - 64
   1578
};
enum dGunEnum
{
	Float:ObjPos[3],
	ObjID,
	ObjData[2],
	ObjInt,
	ObjWorld,
	ObjType,
    Text3D: ObjText
};
new dGunData[MAX_OBJ][dGunEnum];

hook OnGameModeInit()
{
	for(new n = 0; n < MAX_OBJ; n++) dGunData[n][ObjID] = -1;
	LoadDrop();
	return 1;
}
CMD:pickupitem(playerid, params[])
{
    // Check if player is dead (uncomment if needed)
    // if(PlayerInfo[playerid][pDead] > 0) return SendClientMessage(playerid, COLOR_WHITE, "Cannot use this command while dead.");

    new interior = GetPlayerInterior(playerid);
    new world = GetPlayerVirtualWorld(playerid);
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, COLOR_WHITE, "You must be on foot to use this command.");

    new f = -1;

    // Log initial player information
    printf("pickupitem called by player %d in interior %d and world %d", playerid, interior, world);

    // First pass: find the closest object
    for (new a = 0; a < MAX_OBJ; a++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, dGunData[a][ObjPos][0], dGunData[a][ObjPos][1], dGunData[a][ObjPos][2]))
        {
            if(interior == dGunData[a][ObjInt] && world == dGunData[a][ObjWorld])
            {
                f = a;
                break;
            }
        }
    }

    // Check if a valid object was found
    if(f == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "There is no weapon on the ground here.");

    // Log found object information
    printf("Found object %d at index %d for player %d", dGunData[f][ObjID], f, playerid);

    // Process the found object
   	switch(dGunData[f][ObjType])
   	{
    	case 1:
     	{
      		GivePlayerValidWeapon(playerid, dGunData[f][ObjData][0], dGunData[f][ObjData][1]);

		}
  		case 2:
    	{
     		PlayerInfo[playerid][pDrugs][0] += dGunData[f][ObjData][1];
       }
       default:
       {
       	// Handle unexpected object type
        	printf("Unexpected ObjType %d for object %d", dGunData[f][ObjType], f);
         	return SendClientMessage(playerid, COLOR_LIGHTRED, "Unexpected object type.");
        }
    }

    // Apply the pickup animation
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb

    // Destroy the object and its label
    DestroyDynamicObject(dGunData[f][ObjID]);
    DestroyDynamic3DTextLabel(dGunData[f][ObjText]);

    // Reset the object's data
    dGunData[f][ObjPos][0] = 0.0;
    dGunData[f][ObjPos][1] = 0.0;
    dGunData[f][ObjPos][2] = 0.0;
    dGunData[f][ObjID] = -1;
    dGunData[f][ObjData][0] = 0;
    dGunData[f][ObjData][1] = 0;
    dGunData[f][ObjInt] = 0;
    dGunData[f][ObjWorld] = 0;

    // Save the state of dropped guns
    SaveDroppedGuns();

    // Notify the player
    new buffer[50];
    format(buffer, sizeof(buffer), "You picked up a %s.", GunNames[dGunData[f][ObjData][0]]);
    SendClientMessage(playerid, -1, buffer);

    // Log completion of command
    printf("Player %d successfully picked up item %d", playerid, f);

    return 1;

}

/*CMD:pickupitem(playerid, params[])
{
    //if(PlayerInfo[playerid][pDead] > 0) return SendClientMessage(playerid, COLOR_WHITE, "Cannot use this command while dead.");
	new interior = GetPlayerInterior(playerid), world = GetPlayerVirtualWorld(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
	new f = MAX_OBJ+1;
	for (new a = 0; a < MAX_OBJ; a++)
    {
        //if (dGunData[a][ObjType] == 2) // Ensure it's a drug item
		switch(dGunData[a][ObjType])
        {
            case 1:GivePlayerValidWeapon(playerid, dGunData[f][ObjData][0], dGunData[f][ObjData][1]);
	 		case 2:PlayerInfo[playerid][pDrugs][0] +=dGunData[a][ObjData][1];
	 	}
	}
	for(new a = 0; a < MAX_OBJ; a++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, dGunData[a][ObjPos][0], dGunData[a][ObjPos][1], dGunData[a][ObjPos][2]))
		{
			if(interior == dGunData[a][ObjInt] && world == dGunData[a][ObjWorld])
			{
				f = a;
				break;
			}
		}
	}
	if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_LIGHTRED, "There is no weapon on the ground here.");
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
	DestroyDynamicObject(dGunData[f][ObjID]);
	DestroyDynamic3DTextLabel(dGunData[f][ObjText]);
	dGunData[f][ObjPos][0] = 0.0;
	dGunData[f][ObjPos][1] = 0.0;
	dGunData[f][ObjPos][2] = 0.0;
	dGunData[f][ObjID] = -1;
	dGunData[f][ObjData][0] = 0;
	dGunData[f][ObjData][1] = 0;
	dGunData[f][ObjInt] = 0;
	dGunData[f][ObjWorld] = 0;
	SaveDroppedGuns();
	new buffer[50];
	format(buffer, sizeof(buffer), "You picked up a %s.", GunNames[dGunData[f][ObjData][0]]);
	SendClientMessage(playerid, -1, buffer);
	// -------------------------------------------------------
	return 1;
}*/
CMD:newdrop(playerid, params[])
{
    new type[128], amount, world = GetPlayerVirtualWorld(playerid), interior = GetPlayerInterior(playerid);
    if(gPlayerLogged[playerid] == 0) return SendErrorMessage(playerid, "You must be logged in to use this.");
    if(GetPVarInt(playerid, "Injured") > 0) return SendErrorMessage(playerid, "You are not able to use this !");
    if(GetPVarInt(playerid, "PlayerCuffed") != 0) return SendErrorMessage(playerid, "You are not able to use this !");
    if(sscanf(params, "s[128]I(-1)", type, amount)) SendClientMessage(playerid, COLOR_GREEN, "USAGE: /newdrop [gun/weed]");
    else
    {
        if(strcmp(type, "gun", true) == 0)
        {
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_LIGHTRED, "You can't be in a vehicle while you use this !");
            new GunID = GetPlayerWeapon(playerid);
            new GunAmmo = GetPlayerAmmo(playerid);
            if(GunID > 0 && GunAmmo != 0)
            {
                new f = MAX_OBJ+1;
                for(new a = 0; a < MAX_OBJ; a++)
                {
                    if(dGunData[a][ObjPos][0] == 0.0)
                    {
                        f = a;
                        break;
                    }
                }
                if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_LIGHTRED, "You can not drop your gun at the moment. (max limit exceeded)");
                ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
                RemovePlayerWeapon(playerid, GunID);
                dGunData[f][ObjData][0] = GunID;
                dGunData[f][ObjData][1] = GunAmmo;
                SaveDroppedGuns();
                dGunData[f][ObjInt] = interior;
                dGunData[f][ObjWorld] = world;

                dGunData[f][ObjType] = 1;

                GetPlayerPos(playerid, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]);
                dGunData[f][ObjID] = CreateDynamicObject(GunobjectIds[GunID], dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 93.7, 120.0, 120.0, world, interior, -1, 200.0, 0.0);
                dGunData[f][ObjText] = CreateDynamic3DTextLabel("{339900}Item\n(/pickupitem)",0xFFFFFFFF, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior, -1, 90);
                new buffer[50];
                format(buffer, sizeof(buffer), "You threw your %s on the ground.", GunNames[dGunData[f][ObjData][0]]);
                SendClientMessage(playerid, -1, buffer);
            }
        }
        else if(strcmp(type, "weed", true) == 0)
        {
            if (PlayerInfo[playerid][pDrugs][0] == 0) return SendErrorMessage(playerid, "You don't have any weed on you.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");
            new f = MAX_OBJ+1;
            for(new a = 0; a < MAX_OBJ; a++)
            {
                if(dGunData[a][ObjPos][0] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot drop your weed at the moment. (max limit exceeded)");
            ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
            dGunData[f][ObjInt] = interior;
            dGunData[f][ObjWorld] = world;
            dGunData[f][ObjData][0] = 48; // Setting the item type to "Weed"
            dGunData[f][ObjData][1] = PlayerInfo[playerid][pDrugs][0];
            PlayerInfo[playerid][pDrugs][0] = 0;
            dGunData[f][ObjType] = 2;
            GetPlayerPos(playerid, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]);
            SaveDroppedGuns();
            //dGunData[f][ObjID] = CreateDynamicObject(1578, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 0.0, 0.0, 0.0, world, interior, -1, 200.0, 0.0);
            CreateDynamicObject(1578, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 0.0, 0.0, 0.0, world, interior, -1, 200.0, 0.0);
            dGunData[f][ObjText] = CreateDynamic3DTextLabel("{339900}Item\n(/pickupitem)",0xFFFFFFFF, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior, -1, 90);
            new buffer[50];
            format(buffer, sizeof(buffer), "You threw your weed on the ground.");
            SendClientMessage(playerid, -1, buffer);
        }
    }
    return 1;
}


/*CMD:newdrop(playerid, params[])
{
	new type[128], amount, world = GetPlayerVirtualWorld(playerid), interior = GetPlayerInterior(playerid);
	if(gPlayerLogged[playerid] == 0) return SendErrorMessage(playerid, "You must be logged in to use this.");
	if(GetPVarInt(playerid, "Injured") > 0) return SendErrorMessage(playerid, "You are not able to use this !");
	if(GetPVarInt(playerid, "PlayerCuffed") != 0) return SendErrorMessage(playerid, "You are not able to use this !");
	if(sscanf(params, "s[128]I(-1)", type, amount)) SendClientMessage(playerid, COLOR_GREEN, "USAGE: /newdrop [gun/weed]");
	else
	{
    	if(strcmp(type, "gun", true) == 0)
	    {
            if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_LIGHTRED, "You can't be in a vehicle while you use this !");
            new GunID = GetPlayerWeapon(playerid);
		  	new GunAmmo = GetPlayerAmmo(playerid);
		   	if(GunID > 0 && GunAmmo != 0)
		    {
		    	new f = MAX_OBJ+1;
		     	for(new a = 0; a < MAX_OBJ; a++)
		      	{
		       		if(dGunData[a][ObjPos][0] == 0.0)
		         	{
		          		f = a;
		            	break;
		            }
				}
		  		if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_LIGHTRED, "You can not drop your gun at the moment. (max limit exceeded)");
		  		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
				RemovePlayerWeapon(playerid, GunID);
				dGunData[f][ObjData][0] = GunID;
				dGunData[f][ObjData][1] = GunAmmo;
                SaveDroppedGuns();
				dGunData[f][ObjInt] = interior;
				dGunData[f][ObjWorld] = world;

				dGunData[f][ObjType] = 1;

				GetPlayerPos(playerid, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]);
				dGunData[f][ObjID] = CreateDynamicObject(GunobjectIds[GunID], dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 93.7, 120.0, 120.0, world, interior, -1, 200.0, 0.0);
				dGunData[f][ObjText] = CreateDynamic3DTextLabel("{339900}Item\n(/pickupitem)",0xFFFFFFFF, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior, -1, 90);
				new buffer[50];
				format(buffer, sizeof(buffer), "You threw your %s on the ground.", GunNames[dGunData[f][ObjData][0]]);
				SendClientMessage(playerid, -1, buffer);
			}
		}
		else if(strcmp(type, "weed", true) == 0)
	    {
            if (PlayerInfo[playerid][pDrugs][0] == 0) return SendErrorMessage(playerid, "You don't have any weed on you.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");
    		new f = MAX_OBJ+1;
	    	for(new a = 0; a < MAX_OBJ; a++)
    		{
   				if(dGunData[a][ObjPos][0] == 0.0)
    			{
    				f = a;
     				break;
         		}
			}
			if(f > MAX_OBJ) return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot drop your weed at the moment. (max limit exceeded)");
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0); // Place Bomb
			dGunData[f][ObjInt] = interior;
			dGunData[f][ObjWorld] = world;
			dGunData[f][ObjData][1] = PlayerInfo[playerid][pDrugs][0];
			PlayerInfo[playerid][pDrugs][0] = 0;
			dGunData[f][ObjType] = 2;
			GetPlayerPos(playerid, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]);
			SaveDroppedGuns();
			dGunData[f][ObjID] = CreateDynamicObject(1578, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 0.0, 0.0, 0.0, world, interior, -1, 200.0, 0.0);
			dGunData[f][ObjText] = CreateDynamic3DTextLabel("{339900}Item\n(/pickupitem)",0xFFFFFFFF, dGunData[f][ObjPos][0], dGunData[f][ObjPos][1], dGunData[f][ObjPos][2]-1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world, interior, -1, 90);
			new buffer[50];
			format(buffer, sizeof(buffer), "You threw your %s on the ground.", GunNames[dGunData[f][ObjData][0]]);
			SendClientMessage(playerid, -1, buffer);
    	}
	}
	return 1;
}*/
stock SaveDroppedGuns()
{
	new File:file = fopen("DroppedGuns.ini", io_append);
    if(file)
    {
        fclose(file);
		for(new g = 0, buffer[50]; g < MAX_OBJ; g++)
		{
			format(buffer, sizeof(buffer), "%f,%f,%f,%d,%d,%d,%d,%d\n",
			dGunData[g][ObjPos][0],
			dGunData[g][ObjPos][1],
			dGunData[g][ObjPos][2],
			dGunData[g][ObjData][0],
			dGunData[g][ObjData][1],
			dGunData[g][ObjInt],
			dGunData[g][ObjWorld],
			dGunData[g][ObjType]);
			if(g == 0) file = fopen("DroppedGuns.ini", io_write);
			else file = fopen("DroppedGuns.ini", io_append);
			fwrite(file, buffer);
			fclose(file);
			if(dGunData[g][ObjData][0] > 0 && dGunData[g][ObjPos][1] != 0)
			{
				dGunData[g][ObjID] = CreateDynamicObject(GunobjectIds[dGunData[g][ObjData][0]], dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1, 93.7, 120.0, 120.0, dGunData[g][ObjWorld], dGunData[g][ObjInt], -1, 200.0, 0.0);
				dGunData[g][ObjText] = CreateDynamic3DTextLabel("{339900}Item\n(/pickupitem)",0xFFFFFFFF, dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, dGunData[g][ObjWorld], dGunData[g][ObjInt], -1, 90);
				printf("* %s Saved: %f,%f,%f,", GunNames[dGunData[g][ObjData][0]], dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1);
			}
		}
    }
    return 1;
}
stock LoadDrop()
{
	new File:file = fopen("DroppedGuns.ini", io_read);
    if(file)
    {
        new buffer[256], FileCoords[8][20];
        for(new g = 0; g < MAX_OBJ; g++)
        {
            fread(file, buffer);
            split(buffer, FileCoords, ',');
            dGunData[g][ObjPos][0] = floatstr(FileCoords[0]);
			dGunData[g][ObjPos][1] = floatstr(FileCoords[1]);
			dGunData[g][ObjPos][2] = floatstr(FileCoords[2]);
			dGunData[g][ObjData][0] = strval(FileCoords[3]);
			dGunData[g][ObjData][1] = strval(FileCoords[4]);
			dGunData[g][ObjInt] = strval(FileCoords[5]);
			dGunData[g][ObjWorld] = strval(FileCoords[6]);
			dGunData[g][ObjType] = strval(FileCoords[6]);
			if(dGunData[g][ObjData][0] > 0 && dGunData[g][ObjPos][1] != 0)
			{
				dGunData[g][ObjID] = CreateDynamicObject(GunobjectIds[dGunData[g][ObjData][0]], dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1, 93.7, 120.0, 120.0, dGunData[g][ObjWorld], dGunData[g][ObjInt], -1, 200.0, 0.0);
				dGunData[g][ObjText] = CreateDynamic3DTextLabel("{339900}Item\n(/pickupitem)",0xFFFFFFFF, dGunData[g][ObjPos][0], dGunData[g][ObjPos][1], dGunData[g][ObjPos][2]-1, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, dGunData[g][ObjWorld], dGunData[g][ObjInt], -1, 90);
   			}
		}
 	}
  	return 1;
}
