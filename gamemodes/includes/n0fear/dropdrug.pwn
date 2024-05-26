////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// Beta for now           /////
////////////////////////////////////////////


#include <YSI\y_hooks>

#define MAX_DROP_DRUGS 1000//Change it to set the max weapons that can be dropped.

enum ddInfo
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
}
new DropDrug[MAX_DROP_DRUGS][ddInfo];

hook OnGameModeInit()
{
	for(new f =0; f < sizeof(DropDrug);f++)
	{
	    strmid(DropDrug[f][dOwner], "None", 0, strlen("None"), 255);
	    strmid(DropDrug[f][dPrint], "None", 0, strlen("None"), 255);
	}
	return 1;
}

COMMAND:pickitem(playerid, params[])
{
    new string[128],sendername[MAX_PLAYER_NAME],gunname[128];
    if (gPlayerLogged{playerid} == 0) return SendClientMessage(playerid, COLOR_WHITE, "You must be logged in to use this.");
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
			  			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
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
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][0] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][0]; // Weed
        	          	SendClientMessage(playerid, COLOR_WHITE, "Weed taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the weed on the ground as he picks it up.", sendername);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			      	}
			      	case 3:
			      	{
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][1] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][1]; // Crack
        	          	SendClientMessage(playerid, COLOR_WHITE, "Crack taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the crack on the ground as he picks it up.", sendername);
						ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					}
     				case 4:
			      	{
		    	      	ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);
		    	      	if(DropDrug[i][dObject] > 0) DestroyDynamicObject(DropDrug[i][dObject]);
	                  	DropDrug[i][dObject]=0;
                      	DropDrug[i][ddX] = 0.0;
    		          	DropDrug[i][ddY] = 0.0;
    		          	DropDrug[i][ddZ] = 0.0;
    		          	DropDrug[i][dType] = 0;
    		          	strmid(DropDrug[i][dOwner], "None", 0, strlen("None"), 255);
    		          	PlayerInfo[playerid][pDrugs][2] = DropDrug[i][dAmmo]+PlayerInfo[playerid][pDrugs][2]; // Meth
        	          	SendClientMessage(playerid, COLOR_WHITE, "Meth taken from the ground.");
        	          	format(string, sizeof(string), "*** %s reaches for the meth on the ground as he picks it up.", sendername);
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
	new type[128],amount,sendername[MAX_PLAYER_NAME],Float:X,Float:Y,Float:Z,string[128];
	if(sscanf(params, "s[128]I(-1)", type,amount)) SendClientMessage(playerid, COLOR_GREEN, "/dropdrug [weed/crack]");
	else
	{
	    if(gPlayerLogged{playerid} == 0) return SendClientMessage(playerid, COLOR_WHITE, "You must be logged in to use this.");
	    format(sendername, sizeof(sendername), "%s", GetPlayerNameEx(playerid));
        if(strcmp(type, "weed", true) == 0)
	    {
	        if (gPlayerLogged{playerid} == 0) return SendErrorMessage(playerid, "You must be logged in to use this.");
	        if (PlayerInfo[playerid][pDrugs][0] == 0) return SendErrorMessage(playerid, "You don't have any weed on you.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");
            SendServerMessage(playerid, "You dropped your weed onto the ground.");
            GetPlayerPos(playerid,X,Y,Z);
            new amount2 = 0, amounto = PlayerInfo[playerid][pDrugs][0];
            PlayerInfo[playerid][pDrugs][0] = 0;
            for(new i = 0; i < sizeof(DropDrug); i++)
  	        {
  	            if(strcmp(GetPlayerNameEx(playerid), DropDrug[i][dOwner], true) == 0)
  	            {
  	                amount2++;
  	            }
  	        }
			if(amount2 <= 2)
           	{
               	for(new i = 0; i < sizeof(DropDrug); i++)
  	           	{
  	               	if(DropDrug[i][ddX] == 0.0 && DropDrug[i][ddY] == 0.0 && DropDrug[i][ddZ] == 0.0)
                   	{
                   		strmid(DropDrug[i][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), 255);
  	                   	DropDrug[i][dAmmo] = amounto;
  	                   	DropDrug[i][ddX] = X;
  	                   	DropDrug[i][ddY] = Y;
  	                   	DropDrug[i][ddZ] = Z;
  	                   	DropDrug[i][dWorld] = GetPlayerVirtualWorld(playerid);
  	                   	DropDrug[i][dType] = 2;
  	                   	DropDrug[i][dObject] = CreateDynamicObject(1578, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
	                   	return 1;
             		}
	           	}
           	}
	    }
	    else if(strcmp(type, "crack", true) == 0)
	    {
	        if (gPlayerLogged{playerid} == 0) return SendErrorMessage(playerid, "You must be logged in to use this.");
	        if (PlayerInfo[playerid][pDrugs][1] == 0) return SendErrorMessage(playerid, "You don't have any crack on you.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");
            SendServerMessage(playerid, "You dropped your crack onto the ground.");
            GetPlayerPos(playerid,X,Y,Z);
            new amount2 = 0, amounto = PlayerInfo[playerid][pDrugs][1];
            PlayerInfo[playerid][pDrugs][1] = 0;
            for(new i = 0; i < sizeof(DropDrug); i++)
  	        {
  	            if(strcmp(GetPlayerNameEx(playerid), DropDrug[i][dOwner], true) == 0)
  	            {
  	                amount2++;
  	            }
     		}
           	if(amount2 <= 2)
           	{
           		for(new i = 0; i < sizeof(DropDrug); i++)
  	           	{
               		if(DropDrug[i][ddX] == 0.0 && DropDrug[i][ddY] == 0.0 && DropDrug[i][ddZ] == 0.0)
                 	{
                  		strmid(DropDrug[i][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), 255);
	                   	DropDrug[i][dAmmo] = amounto;
 	                   	DropDrug[i][ddX] = X;
  	                   	DropDrug[i][ddY] = Y;
  	                   	DropDrug[i][ddZ] = Z;
  	                   	DropDrug[i][dWorld] = GetPlayerVirtualWorld(playerid);
  	                   	DropDrug[i][dType] = 4;
  	                   	DropDrug[i][dObject] = CreateDynamicObject(1576, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
                   	}
           		}
      		}
      	}
		else if(strcmp(type, "meth", true) == 0)
	    {
	        if (gPlayerLogged{playerid} == 0) return SendErrorMessage(playerid, "You must be logged in to use this.");
	        if (PlayerInfo[playerid][pDrugs][2] == 0) return SendErrorMessage(playerid, "You don't have any crack on you.");
            if (IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You can't be in a vehicle while you use this !");
            SendServerMessage(playerid, "You dropped your meth onto the ground.");
            GetPlayerPos(playerid,X,Y,Z);
            new amount2 = 0, amounto = PlayerInfo[playerid][pDrugs][2];
            PlayerInfo[playerid][pDrugs][2] = 0;
            for(new i = 0; i < sizeof(DropDrug); i++)
  	        {
  	            if(strcmp(GetPlayerNameEx(playerid), DropDrug[i][dOwner], true) == 0)
  	            {
  	                amount2++;
  	            }
     		}
           	if(amount2 <= 2)
           	{
           		for(new i = 0; i < sizeof(DropDrug); i++)
  	           	{
               		if(DropDrug[i][ddX] == 0.0 && DropDrug[i][ddY] == 0.0 && DropDrug[i][ddZ] == 0.0)
                 	{
                  		strmid(DropDrug[i][dOwner], GetPlayerNameEx(playerid), 0, strlen(GetPlayerNameEx(playerid)), 255);
	                   	DropDrug[i][dAmmo] = amounto;
 	                   	DropDrug[i][ddX] = X;
  	                   	DropDrug[i][ddY] = Y;
  	                   	DropDrug[i][ddZ] = Z;
  	                   	DropDrug[i][dWorld] = GetPlayerVirtualWorld(playerid);
  	                   	DropDrug[i][dType] = 4;
  	                   	DropDrug[i][dObject] = CreateDynamicObject(1576, X, Y, Z-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid));
    				}
				}
			}
		    else SendClientMessage(playerid, COLOR_GREEN, "/drop [weed/crack]");
		}
	}
	return 1;
}
