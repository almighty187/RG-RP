////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// Beta for now           /////
////////////////////////////////////////////


#include <YSI\y_hooks>

#define MAX_DROP_DRUGS (1000)//Change it to set the max drugs that can be dropped.

enum ddData
{
	dOwner[30],
	dType,
    dWeapon,
    dAmmo,
    dWorld,
    dObject,
	Float:ddX,
	Float:ddY,
	Float:ddZ,
	dPrint[MAX_PLAYER_NAME],
	dText,
}
new DropDrug[MAX_DROP_DRUGS][ddData];

hook OnGameModeInit()
{
    LoadDrop();
	//for(new n = 0; n < MAX_DROP_DRUGS; n++) DropDrug[n][dObject] = -1;
	return 1;
}
CreateDrop(idx)
{
    switch(DropDrug[idx][dType])
    {
    	case 2:
		{
			DropDrug[idx][dObject] = CreateDynamicObject(1578, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ]-1, 0.0, 0.0, 0.0, DropDrug[idx][dWorld]);
            DropDrug[idx][dText] = CreateDynamic3DTextLabel("[WEED]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[idx][dWorld], -1, -1);
		}
        case 3:
		{
			DropDrug[idx][dObject] = CreateDynamicObject(1580, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ]-1, 0.0, 0.0, 0.0, DropDrug[idx][dWorld]);
            DropDrug[idx][dText] = CreateDynamic3DTextLabel("[CRACK]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[idx][dWorld], -1, -1);
		}
        case 4:
		{
			DropDrug[idx][dObject] = CreateDynamicObject(1575, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ]-1, 0.0, 0.0, 0.0, DropDrug[idx][dWorld]);
            DropDrug[idx][dText] = CreateDynamic3DTextLabel("[METH]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[idx][dWorld], -1, -1);
		}
        case 5:
		{
			DropDrug[idx][dObject] = CreateDynamicObject(1576, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ]-1, 0.0, 0.0, 0.0, DropDrug[idx][dWorld]);
            DropDrug[idx][dText] = CreateDynamic3DTextLabel("[ECSTASY]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[idx][dWorld], -1, -1);
  		}
        case 6:
		{
  			DropDrug[idx][dObject] = CreateDynamicObject(1579, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ]-1, 0.0, 0.0, 0.0, DropDrug[idx][dWorld]);
            DropDrug[idx][dText] = CreateDynamic3DTextLabel("[HEROIN]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[idx][ddX], DropDrug[idx][ddY], DropDrug[idx][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[idx][dWorld], -1, -1);
		}
	}
}
LoadDrop()
{
	new File:file = fopen("DroppedDrugs.ini", io_read);
    if(file)
    {
        new buffer[256], FileCoords[8][20];
        for(new g = 0; g < MAX_DROP_DRUGS; g++)
        {
            fread(file, buffer);
            split(buffer, FileCoords, ',');
            DropDrug[g][dType] = strval(FileCoords[0]);
			DropDrug[g][dWeapon] = strval(FileCoords[1]);
			DropDrug[g][dAmmo] = strval(FileCoords[2]);
			DropDrug[g][dWorld] = strval(FileCoords[3]);
   			DropDrug[g][ddX] = floatstr(FileCoords[4]);
			DropDrug[g][ddY] = floatstr(FileCoords[5]);
			DropDrug[g][ddZ] = floatstr(FileCoords[6]);
			CreateDrop(g);
			printf("Loaded drop %d: Type %d, Weapon %d, Ammo %d, World %d, X %.2f, Y %.2f, Z %.2f\n", g, DropDrug[g][dType], DropDrug[g][dWeapon], DropDrug[g][dAmmo], DropDrug[g][dWorld], DropDrug[g][ddX], DropDrug[g][ddY], DropDrug[g][ddZ]);
			if(DropDrug[g][dWeapon] > 0 && DropDrug[g][ddX] != 0)
			{
				CreateDrop(g);
			}
		}
	}
}
SaveDrop()
{
    new File:file = fopen("DroppedDrugs.ini", io_write); // Open the file for writing

    if(file)
    {
        new buffer[256]; // Declare buffer variable

        for(new g = 0; g < MAX_DROP_DRUGS; g++)
        {
            format(buffer, sizeof(buffer), "%d,%d,%d,%d,%f,%f,%f\n",
                   DropDrug[g][dType],
                   DropDrug[g][dWeapon],
                   DropDrug[g][dAmmo],
                   DropDrug[g][dWorld],
                   DropDrug[g][ddX],
                   DropDrug[g][ddY],
                   DropDrug[g][ddZ]);
      		//fwrite(file, buffer, strlen(buffer)); // Write data to the file
      		fwrite(file, buffer);
        }

        fclose(file); // Close the file
        return 1; // Return success
    }
    else
    {
        return 0; // Return failure
    }
}
CMD:pickitem(playerid, params[])
{
    new string[128],sendername[MAX_PLAYER_NAME],gunname[128];
    if (gPlayerLogged{playerid} == 0) return SendClientMessage(playerid, COLOR_WHITE, "You must be logged in to use this.");
    if (GetPVarInt(playerid, "Injured") > 0) return SendClientMessage(playerid, COLOR_WHITE, "You are not able to use this !");
    if (GetPVarInt(playerid, "PlayerCuffed") != 0) return SendClientMessage(playerid, COLOR_WHITE, "You are not able to use this !");
	format(sendername, sizeof(sendername), "%s", GetPlayerNameEx(playerid));
    for(new i = 0; i < sizeof(DropDrug); i++)
    {
 		if(IsPlayerInRangeOfPoint(playerid,1.0,DropDrug[i][ddX],DropDrug[i][ddY],DropDrug[i][ddZ]))
  		{
    		if(GetPlayerVirtualWorld(playerid) == DropDrug[i][dWorld])
			{
				switch(DropDrug[i][dType])
	  			{
					case 1:
    				{
			  			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 1);
	                  	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	//GivePlayerWeaponEx(playerid,DropDrug[i][dWeapon],DropDrug[i][dAmmo]);
	                  	GetWeaponName(DropDrug[i][dWeapon], gunname, sizeof(gunname));
        	          	format(string, sizeof(string), "*** %s takes the %s off the ground.", sendername,gunname);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);


			      	}
			      	case 2:
			      	{
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 1);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
		    	      	DestroyDynamic3DTextLabel(DropDrug[i][dText]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][0] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][0]; // Weed
        	          	SendClientMessage(playerid, COLOR_WHITE, "Weed taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the weed on the ground as %s picks it up.", sendername, CheckSex(playerid));
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			      	}
			      	case 3:
			      	{
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 1);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
		    	      	DestroyDynamic3DTextLabel(DropDrug[i][dText]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][1] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][1]; // Crack
        	          	SendClientMessage(playerid, COLOR_WHITE, "Crack taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the crack on the ground as %s picks it up.", sendername, CheckSex(playerid));
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
     				case 4:
			      	{
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 1);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
		    	      	DestroyDynamic3DTextLabel(DropDrug[i][dText]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][2] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][2]; // Meth
        	          	SendClientMessage(playerid, COLOR_WHITE, "Meth taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the meth on the ground as %s picks it up.", sendername, CheckSex(playerid));
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
     				case 5:
			      	{
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 1);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
		    	      	DestroyDynamic3DTextLabel(DropDrug[i][dText]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][3] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][3]; // Ecstasy
        	          	SendClientMessage(playerid, COLOR_WHITE, "Meth taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the ecstasy on the ground as %s picks it up.", sendername, CheckSex(playerid));
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
     				case 6:
			      	{
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 1);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
		    	      	DestroyDynamic3DTextLabel(DropDrug[i][dText]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][4] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][4]; // Heroin
        	          	SendClientMessage(playerid, COLOR_WHITE, "Meth taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the heroin on the ground as %s picks it up.", sendername, CheckSex(playerid));
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
			  	}
        	  	return 1;
   			}
	   	}
	}
	return 1;
}
CMD:dropdrug(playerid, params[])
{
	new type[128], dropamount, sendername[MAX_PLAYER_NAME], Float:X, Float:Y, Float:Z, string[128];
	if (sscanf(params, "s[128]i", type, dropamount)) {
	    SendSyntaxMessage(playerid, "/dropdrug [weed/crack/meth/ecstasy/heroin] [amount]");
	} else {
	    if (gPlayerLogged[playerid] == 0) return SendErrorMessage(playerid, "You must be logged in to use this.");
	    if (GetPVarInt(playerid, "Injured") > 0) return SendErrorMessage(playerid, "You are not able to use this !");
	    if (GetPVarInt(playerid, "PlayerCuffed") != 0) return SendErrorMessage(playerid, "You are not able to use this !");
	    format(sendername, sizeof(sendername), "%s", GetPlayerNameEx(playerid));

	    // Ensure dropamount is positive
	    if (dropamount <= 0) return SendErrorMessage(playerid, "The amount to drop must be a positive number.");
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
		if (strcmp(type, "weed", true) == 0)
        {
            if (PlayerInfo[playerid][pDrugs][0] < dropamount) return SendErrorMessage(playerid, "You don't have enough weed to drop that amount.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");

            SendServerMessage(playerid, "You dropped your weed onto the ground.");
            format(string, sizeof(string), "*** %s reaches for %s pocket, withdraws a bag of weed, and drops it.", sendername, CheckSex(playerid));
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            GetPlayerPos(playerid, X, Y, Z);
            PlayerInfo[playerid][pDrugs][0] -= dropamount;
            new f = -1;
            for(new a = 0; a < MAX_DROP_DRUGS; a++)
            {
                if (DropDrug[a][ddX] == 0.0 && DropDrug[a][ddY] == 0.0 && DropDrug[a][ddZ] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot drop your weed at the moment. (max limit exceeded)");

            //strmid(DropDrug[f][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), sizeof(DropDrug[f][dOwner]) - 1);
            DropDrug[f][dAmmo] = dropamount;
            DropDrug[f][ddX] = X;
            DropDrug[f][ddY] = Y;
            DropDrug[f][ddZ] = Z;
            DropDrug[f][dWorld] = GetPlayerVirtualWorld(playerid);
            DropDrug[f][dType] = 2;
            SaveDrop();
            DropDrug[f][dObject] = CreateDynamicObject(1578, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
            DropDrug[f][dText] = CreateDynamic3DTextLabel("[WEED]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[f][ddX], DropDrug[f][ddY], DropDrug[f][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[f][dWorld], -1, -1);
            return 1;
	    }
	    else if(strcmp(type, "crack", true) == 0)
	    {
	        if (PlayerInfo[playerid][pDrugs][1] < dropamount) return SendErrorMessage(playerid, "You don't have enough crack to drop that amount.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");

            SendServerMessage(playerid, "You dropped your weed onto the ground.");
            format(string, sizeof(string), "*** %s reaches for %s pocket, withdraws a bag of weed, and drops it.", sendername, CheckSex(playerid));
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            GetPlayerPos(playerid, X, Y, Z);
            PlayerInfo[playerid][pDrugs][1] -= dropamount;
            new f = -1;
            for(new a = 0; a < MAX_DROP_DRUGS; a++)
            {
                if (DropDrug[a][ddX] == 0.0 && DropDrug[a][ddY] == 0.0 && DropDrug[a][ddZ] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot drop your weed at the moment. (max limit exceeded)");

            //strmid(DropDrug[f][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), sizeof(DropDrug[f][dOwner]) - 1);
            DropDrug[f][dAmmo] = dropamount;
            DropDrug[f][ddX] = X;
            DropDrug[f][ddY] = Y;
            DropDrug[f][ddZ] = Z;
            DropDrug[f][dWorld] = GetPlayerVirtualWorld(playerid);
            DropDrug[f][dType] = 3;
            SaveDrop();
            DropDrug[f][dObject] = CreateDynamicObject(1580, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
            DropDrug[f][dText] = CreateDynamic3DTextLabel("[CRACK]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[f][ddX], DropDrug[f][ddY], DropDrug[f][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[f][dWorld], -1, -1);
      	}
		else if(strcmp(type, "meth", true) == 0)
	    {
	        if (PlayerInfo[playerid][pDrugs][2] < dropamount) return SendErrorMessage(playerid, "You don't have enough meth to drop that amount.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");

            SendServerMessage(playerid, "You dropped your weed onto the ground.");
            format(string, sizeof(string), "*** %s reaches for %s pocket, withdraws a bag of weed, and drops it.", sendername, CheckSex(playerid));
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            GetPlayerPos(playerid, X, Y, Z);
            PlayerInfo[playerid][pDrugs][2] -= dropamount;
            new f = -1;
            for(new a = 0; a < MAX_DROP_DRUGS; a++)
            {
                if (DropDrug[a][ddX] == 0.0 && DropDrug[a][ddY] == 0.0 && DropDrug[a][ddZ] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot drop your weed at the moment. (max limit exceeded)");

            //strmid(DropDrug[f][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), sizeof(DropDrug[f][dOwner]) - 1);
            DropDrug[f][dAmmo] = dropamount;
            DropDrug[f][ddX] = X;
            DropDrug[f][ddY] = Y;
            DropDrug[f][ddZ] = Z;
            DropDrug[f][dWorld] = GetPlayerVirtualWorld(playerid);
            DropDrug[f][dType] = 4;
            SaveDrop();
            DropDrug[f][dObject] = CreateDynamicObject(1575, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
            DropDrug[f][dText] = CreateDynamic3DTextLabel("[METH]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[f][ddX], DropDrug[f][ddY], DropDrug[f][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[f][dWorld], -1, -1);
      	}
		else if(strcmp(type, "ecstasy", true) == 0)
	    {
	        if (PlayerInfo[playerid][pDrugs][3] < dropamount) return SendErrorMessage(playerid, "You don't have enough ecstasy to drop that amount.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");

            SendServerMessage(playerid, "You dropped your weed onto the ground.");
            format(string, sizeof(string), "*** %s reaches for %s pocket, withdraws a bag of weed, and drops it.", sendername, CheckSex(playerid));
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            GetPlayerPos(playerid, X, Y, Z);
            PlayerInfo[playerid][pDrugs][3] -= dropamount;
            new f = -1;
            for(new a = 0; a < MAX_DROP_DRUGS; a++)
            {
                if (DropDrug[a][ddX] == 0.0 && DropDrug[a][ddY] == 0.0 && DropDrug[a][ddZ] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot drop your weed at the moment. (max limit exceeded)");

            //strmid(DropDrug[f][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), sizeof(DropDrug[f][dOwner]) - 1);
            DropDrug[f][dAmmo] = dropamount;
            DropDrug[f][ddX] = X;
            DropDrug[f][ddY] = Y;
            DropDrug[f][ddZ] = Z;
            DropDrug[f][dWorld] = GetPlayerVirtualWorld(playerid);
            DropDrug[f][dType] = 5;
            SaveDrop();
            DropDrug[f][dObject] = CreateDynamicObject(1576, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
            DropDrug[f][dText] = CreateDynamic3DTextLabel("[ECSTASY]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[f][ddX], DropDrug[f][ddY], DropDrug[f][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[f][dWorld], -1, -1);
      	}
		else if(strcmp(type, "heroin", true) == 0)
	    {
	        if (PlayerInfo[playerid][pDrugs][4] < dropamount) return SendErrorMessage(playerid, "You don't have enough heroin to drop that amount.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");

            SendServerMessage(playerid, "You dropped your weed onto the ground.");
            format(string, sizeof(string), "*** %s reaches for %s pocket, withdraws a bag of weed, and drops it.", sendername, CheckSex(playerid));
            ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            GetPlayerPos(playerid, X, Y, Z);
            PlayerInfo[playerid][pDrugs][4] -= dropamount;
            new f = -1;
            for(new a = 0; a < MAX_DROP_DRUGS; a++)
            {
                if (DropDrug[a][ddX] == 0.0 && DropDrug[a][ddY] == 0.0 && DropDrug[a][ddZ] == 0.0)
                {
                    f = a;
                    break;
                }
            }
            if(f == -1) return SendClientMessage(playerid, COLOR_LIGHTRED, "You cannot drop your weed at the moment. (max limit exceeded)");

            //strmid(DropDrug[f][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), sizeof(DropDrug[f][dOwner]) - 1);
            DropDrug[f][dAmmo] = dropamount;
            DropDrug[f][ddX] = X;
            DropDrug[f][ddY] = Y;
            DropDrug[f][ddZ] = Z;
            DropDrug[f][dWorld] = GetPlayerVirtualWorld(playerid);
            DropDrug[f][dType] = 6;
            SaveDrop();
            DropDrug[f][dObject] = CreateDynamicObject(1579, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
            DropDrug[f][dText] = CreateDynamic3DTextLabel("[HEROIN]\nType /pickitem to pick up package", COLOR_TWGREEN, DropDrug[f][ddX], DropDrug[f][ddY], DropDrug[f][ddZ] - 0.7, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, DropDrug[f][dWorld], -1, -1);
		}
	}
	return 1;
}
