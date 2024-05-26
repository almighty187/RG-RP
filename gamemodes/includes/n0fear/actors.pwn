////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////

#include <a_actor>
#include <YSI\y_ini>
#include <YSI\y_hooks>

#define MAX_DYNAMIC_ACTORS (20) //You can define max actor here
#define DIALOG_ACANIM 5306
#define COLOR_WHITE 0xFFFFFFAA
#define MAX_STRING 255

// Made by N0FeaR

enum aInfo
{
	aId,
	Text3D: aTId,
	aSkin,
	aAnim,
	Float:aPosX,
	Float:aPosY,
	Float:aPosZ,
	Float:aPosR,
	aName[80],
	aVW,
	aInt
}

new ActorsInfo[MAX_DYNAMIC_ACTORS][aInfo];


CreateActors(actorid)
{
	new string[128];
	printf("[LoadActors] Has been loaded from the database...");
	format(string, sizeof(string), "{00BFFF}[Actor: %d]\n{FFFFFF}%s",actorid, ActorsInfo[actorid][aName]);

	ActorsInfo[actorid][aId] = CreateActor(ActorsInfo[actorid][aSkin], ActorsInfo[actorid][aPosX], ActorsInfo[actorid][aPosY], ActorsInfo[actorid][aPosZ], ActorsInfo[actorid][aPosR]);
	SetActorVirtualWorld(ActorsInfo[actorid][aId], ActorsInfo[actorid][aVW]);
	ActorsInfo[actorid][aTId] = CreateDynamic3DTextLabel(string, COLOR_WHITE, ActorsInfo[actorid][aPosX], ActorsInfo[actorid][aPosY], ActorsInfo[actorid][aPosZ]+1,10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ActorsInfo[actorid][aVW], ActorsInfo[actorid][aInt], -1);
	switch(ActorsInfo[actorid][aAnim])
	{
		case 1: {ApplyActorAnimation(actorid,"ped", "SEAT_down", 4.0, 0, 0, 0, 1, 0);}
		case 2: {ApplyActorAnimation(actorid,"ped","Idlestance_fat",4.0,0,0,0,1,0);}
		case 3: {ApplyActorAnimation(actorid,"PED", "idlestance_old", 4.1, 1, 0, 0, 0, 0);}
		case 4: {ApplyActorAnimation(actorid,"POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 0);}
		case 5: {ApplyActorAnimation(actorid,"PED", "woman_idlestance", 4.1, 1, 0, 0, 0, 0);}
		case 6: {ApplyActorAnimation(actorid,"ped","IDLE_stance",4.0,0,0,0,1,0);}
		case 7: {ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_in",4.0,0,0,0,1,0);}
		case 8: {ApplyActorAnimation(actorid,"COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0);}
		case 9: {ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_nod",4.0,0,0,0,1,0);}
		case 10: {ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_out",4.0,0,0,0,1,0);}
		case 11: {ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_shake",4.0,0,0,0,1,0);}
		case 12: {ApplyActorAnimation(actorid,"COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, 0);}
		case 13: {ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_loop",4.0,0,0,0,1,0);}
		case 14: {ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_nod",4.0,0,0,0,1,0);}
		case 15: {ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_out",4.0,0,0,0,1,0);}
		case 16: {ApplyActorAnimation(actorid,"COP_AMBIENT", "Coplook_shake", 4.1, 1, 0, 0, 0, 0);}
		case 17: {ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_think",4.1,1,0,0,0,0);}
		case 18: {ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_watch",4.1,1,0,0,0,0);}
	}
}

LoadActors()
{
	new arrCoords[25][64];
	new strFromFile2[256];
	new File: file = fopen("actors.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(ActorsInfo))
		{
			fread(file, strFromFile2);
			splits(strFromFile2, arrCoords, '|');
	  		ActorsInfo[idx][aId] = strval(arrCoords[0]);
	  		ActorsInfo[idx][aSkin] = strval(arrCoords[1]);
	  		ActorsInfo[idx][aAnim] = strval(arrCoords[2]);
	  		ActorsInfo[idx][aPosX] = floatstr(arrCoords[3]);
	  		ActorsInfo[idx][aPosY] = floatstr(arrCoords[4]);
	  		ActorsInfo[idx][aPosZ] = floatstr(arrCoords[5]);
	  		ActorsInfo[idx][aPosR] = floatstr(arrCoords[6]);
	  		strmid(ActorsInfo[idx][aName], arrCoords[7], 0, strlen(arrCoords[7]), 80);
	  		ActorsInfo[idx][aVW] = strval(arrCoords[8]);
	  		ActorsInfo[idx][aInt] = strval(arrCoords[9]);

	  		if(ActorsInfo[idx][aPosX])
	  		{
		  		//if(!IsNull(ActorsInfo[idx][aName]))
		  		if(strlen(ActorsInfo[idx][aName]) > 0)
		  		{
		  		    printf("[LoadActors] Loading data from database...");
		  		    CreateActors(idx);
				}
			}

			idx++;
		}
		fclose(file);
	}
	return 1;
}

SaveActors() {

	new
		szFileStr[512],
		File: fHandle = fopen("actors.cfg", io_write);

	for(new iIndex; iIndex < MAX_DYNAMIC_ACTORS; iIndex++) {
		format(szFileStr, sizeof(szFileStr), "%d|%d|%d|%f|%f|%f|%f|%s|%d|%d\r\n",
			ActorsInfo[iIndex][aId],
			ActorsInfo[iIndex][aSkin],
			ActorsInfo[iIndex][aAnim],
			ActorsInfo[iIndex][aPosX],
			ActorsInfo[iIndex][aPosY],
			ActorsInfo[iIndex][aPosZ],
			ActorsInfo[iIndex][aPosR],
			ActorsInfo[iIndex][aName],
			ActorsInfo[iIndex][aVW],
			ActorsInfo[iIndex][aInt]
		);
		fwrite(fHandle, szFileStr);
	}
	return fclose(fHandle);
}

//here is the command
CMD:createactor(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		new string[128], skin, name[80];
		if(sscanf(params, "is[80]", skin, name)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: '/createactor' [skinid] [name]");
		new Float:X,Float:Y,Float:Z;
		for(new idx=0; idx<MAX_DYNAMIC_ACTORS; idx++)
		{
		    if(!ActorsInfo[idx][aSkin])
		    {
		        GetPlayerPos(playerid, ActorsInfo[idx][aPosX], ActorsInfo[idx][aPosY], ActorsInfo[idx][aPosZ]);
				GetPlayerFacingAngle(playerid, ActorsInfo[idx][aPosR]);
				GetPlayerPos(playerid, X,Y,Z);
				SetPlayerPos(playerid, X,Y,Z+5);
				ActorsInfo[idx][aVW] = GetPlayerVirtualWorld(playerid);
				ActorsInfo[idx][aInt] = GetPlayerInterior(playerid);
	  			ActorsInfo[idx][aSkin] = skin;
				format(ActorsInfo[idx][aName], 80, "%s", name);
				CreateActors(idx);
				// Text
				format(string, sizeof(string), "AdmCmd: %s Created Actors ID %d. (Skin: %d ; Name: %s)", GetPlayerNameEx(playerid), idx, skin, name);
			    ABroadCast(COLOR_LIGHTRED, string, 2);
				Log("logs/actors.log", string);
				idx = MAX_DYNAMIC_ACTORS;
				SaveActors();
			}
		}
	}
    else {
        SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    return 1;
}

CMD:aused(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		new string[128];
		SendClientMessage(playerid, COLOR_YELLOW, "[Used Actors]:");
		for(new idx=0; idx<MAX_DYNAMIC_ACTORS; idx++)
		{
		    if(ActorsInfo[idx][aId])
		    {
				format(string, sizeof(string), "ID: %d | Skin: %d | VW: %d | Int: %d", idx, ActorsInfo[idx][aSkin], ActorsInfo[idx][aVW], ActorsInfo[idx][aInt]);
				SendClientMessage(playerid, COLOR_WHITE, string);
			}
		}
	}
    else {
        SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    return 1;
}

CMD:gotoactor(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
	    new idx, string[128];
		if(sscanf(params, "i", idx)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: '/gotoactor' [actorid]");
		if(!ActorsInfo[idx][aId]) return SendClientMessage(playerid, COLOR_GREY, "ERROR: Invalid actors id.");
		SetPlayerPos(playerid, ActorsInfo[idx][aPosX], ActorsInfo[idx][aPosY], ActorsInfo[idx][aPosZ]);
  		SetPlayerInterior(playerid,ActorsInfo[idx][aInt]);
		SetPlayerVirtualWorld(playerid,ActorsInfo[idx][aVW]);
		format(string, sizeof(string), "{B0C4DE}TELE: {FFFFFF}You have teleported to actors ID %d.", idx);
		SendClientMessage(playerid, COLOR_WHITE, string);
	}
    else {
        SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    return 1;
}


CMD:acname(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		new string[128], actorid, actorname[128];
		if(sscanf(params, "ds[128]", actorid, actorname)) return SendClientMessage(playerid, COLOR_WHITE, "USAGE: '/acname' [actorid] [name]");
		format(ActorsInfo[actorid][aName], 80, "%s", actorname);
		SendClientMessage(playerid, COLOR_WHITE, "ACTORSINFO: You have changed the name of the actors!");
		if(IsValidActor(ActorsInfo[actorid][aId])) DestroyActor(ActorsInfo[actorid][aId]);
		if(IsValidDynamic3DTextLabel(ActorsInfo[actorid][aTId])) DestroyDynamic3DTextLabel(ActorsInfo[actorid][aTId]);
		CreateActors(actorid);
		SaveActors();
		format(string, sizeof(string), "ACTORSINFO: %s has edited actors [ID:%d]'s Name to %s.", GetPlayerNameEx(playerid), actorid, actorname);
		Log("logs/adit.log", string);
	}
    else {
        SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    return 1;
}

CMD:anear(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		SendClientMessage(playerid, COLOR_WHITE, "NOTE: Listing all Actors within 30 meters of you");
		//new Float:X, Float:Y, Float:Z;
  		//GetPlayerPos(playerid, X, Y, Z);
		for(new i;i<MAX_DYNAMIC_ACTORS;i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 30, ActorsInfo[i][aPosX], ActorsInfo[i][aPosY], ActorsInfo[i][aPosZ]))
			{
			    new string[128];
			   	format(string, sizeof(string), "[ID:%d] | Coordinat: %f ", i, GetPlayerDistanceFromPoint(playerid,ActorsInfo[i][aPosX], ActorsInfo[i][aPosY], ActorsInfo[i][aPosZ]));
			   	SendClientMessage(playerid, COLOR_WHITE, string);
   			}
		}
	}
    else {
        SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    return 1;
}

CMD:acanim(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{

		new actorid;
		if(sscanf(params, "d", actorid))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: '/acanim' [actorid]");
			return 1;
		}

		SetPVarInt(playerid, "aPlayAnim", actorid);
		if(actorid >= MAX_DYNAMIC_ACTORS)
		{
			SendClientMessage( playerid, COLOR_WHITE, "{A9A9A9}ERROR: Invalid Actors ID!");
			return 1;
		}
		ShowPlayerDialog(playerid, DIALOG_ACANIM, DIALOG_STYLE_LIST, "Actor Anim", "Seat down\nIdlestance Fat\nIdlestance Old\nPool Idle Stance\nWoman Idlestance\nIdle Stance\nCopbrowse In\nCopbrowse Loop\nCopbrowse Nod\nCopbrowse Out\nCopbrowse shake\nCoplook In\nCoplook Loop\nCoplook Nod\nCoplook Out\nCoplook Shake\nCoplook Think\nCoplook Watch", "Choose", "Close");
	}
    else {
        SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    return 1;
}

CMD:aedit(playerid, params[])
{
 	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		new string[128], choice[32], actorid, amount;
		if(sscanf(params, "s[32]dD", choice, actorid, amount))
		{
			SendClientMessage(playerid, COLOR_WHITE, "USAGE: '/aedit' [name] [actorid] [amount]");
			SendClientMessage(playerid, COLOR_GREY, "NAME: '/acname', '/acanim', Exterior, Skin, Delete, Refresh, Clearanim");
			return 1;
		}

		if(actorid >= MAX_DYNAMIC_ACTORS)
		{
			SendClientMessage( playerid, COLOR_WHITE, "{A9A9A9}ERROR: Invalid Actors ID!");
			return 1;
		}

		if(strcmp(choice, "exterior", true) == 0)
		{
	  		if(ActorsInfo[actorid][aPosX])
	  		{
		  		//if(!IsNull(ActorsInfo[actorid][aName]))
		  		if(strlen(ActorsInfo[actorid][aName]) > 0)
		  		{
					GetPlayerPos(playerid, ActorsInfo[actorid][aPosX], ActorsInfo[actorid][aPosY], ActorsInfo[actorid][aPosZ]);
					GetPlayerFacingAngle(playerid, ActorsInfo[actorid][aPosR]);
					ActorsInfo[actorid][aVW] = GetPlayerVirtualWorld(playerid);
					ActorsInfo[actorid][aInt] = GetPlayerInterior(playerid);
					SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed the exterior!");
					if(IsValidActor(ActorsInfo[actorid][aId])) DestroyActor(ActorsInfo[actorid][aId]);
					if(IsValidDynamic3DTextLabel(ActorsInfo[actorid][aTId])) DestroyDynamic3DTextLabel(ActorsInfo[actorid][aTId]);
					CreateActors(actorid);
					SaveActors();
					format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Exterior.", GetPlayerNameEx(playerid), actorid);
					Log("logs/aedit.log", string);
				}
				else
				{
					SendClientMessage( playerid, COLOR_WHITE, "{A9A9A9}ERROR: The Actors not created.");
				}
			}
		}
		else if(strcmp(choice, "skin", true) == 0)
		{
			ActorsInfo[actorid][aSkin] = amount;

			format(string, sizeof(string), "{B0C4DE}ACTORS: {FFFFFF}You have changed skin {FFFF00}%d..", amount);
			SendClientMessage(playerid, COLOR_WHITE, string);

			if(IsValidActor(ActorsInfo[actorid][aId])) DestroyActor(ActorsInfo[actorid][aId]);
			if(IsValidDynamic3DTextLabel(ActorsInfo[actorid][aTId])) DestroyDynamic3DTextLabel(ActorsInfo[actorid][aTId]);
			CreateActors(actorid);

			SaveActors();
			format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Skin.", GetPlayerNameEx(playerid), actorid);
			Log("logs/aedit.log", string);
			return 1;
		}
		else if(strcmp(choice, "clearanim", true) == 0)
		{
			ActorsInfo[actorid][aAnim] = 0;
			ClearActorAnimations(actorid);

			format(string, sizeof(string), "{B0C4DE}ACTORS: {FFFFFF}You have clear animation actorid {FFFF00}%d..", actorid);
			SendClientMessage(playerid, COLOR_WHITE, string);

			SaveActors();
			format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has clear animation actorid {FFFF00}%d.", GetPlayerNameEx(playerid), actorid);
			Log("logs/aedit.log", string);
			return 1;
		}
		else if(strcmp(choice, "refresh", true) == 0)
		{
			format(string, sizeof(string), "{B0C4DE}ACTORS: {FFFFFF}You have refresh actorid {FFFF00}%d..", actorid);
			SendClientMessage(playerid, COLOR_WHITE, string);

			if(IsValidActor(ActorsInfo[actorid][aId])) DestroyActor(ActorsInfo[actorid][aId]);
			if(IsValidDynamic3DTextLabel(ActorsInfo[actorid][aTId])) DestroyDynamic3DTextLabel(ActorsInfo[actorid][aTId]);
			CreateActors(actorid);

			SaveActors();
			format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has refresh actorid {FFFF00}%d.", GetPlayerNameEx(playerid), actorid);
			Log("logs/aedit.log", string);
			return 1;
		}
		else if(strcmp(choice, "delete", true) == 0)
		{
	    	if(IsValidActor(ActorsInfo[actorid][aId])) DestroyActor(ActorsInfo[actorid][aId]);
		    DestroyDynamic3DTextLabel(ActorsInfo[actorid][aTId]);
			ActorsInfo[actorid][aName] = 0;
			ActorsInfo[actorid][aVW] = 0;
			ActorsInfo[actorid][aInt] = 0;
			ActorsInfo[actorid][aPosX] = 0;
			ActorsInfo[actorid][aPosY] = 0;
			ActorsInfo[actorid][aPosZ] = 0;
			ActorsInfo[actorid][aPosR] = 0;
			ActorsInfo[actorid][aSkin] = 0;
			SaveActors();
			format(string, sizeof(string), "{B0C4DE}ACTORS: {FFFFFF}You have delete actor id {FFFF00}%d.", actorid);
			SendClientMessage(playerid, COLOR_WHITE, string);
			format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has delete actors{FFFF00}%d", GetPlayerNameEx(playerid), actorid);
			Log("logs/aedit.log", string);
			return 1;
		}
	}
    else {
        SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    }
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_ACANIM)
	{
	    if(!response) return -1;
        new actorid = GetPVarInt(playerid, "aPlayAnim"), string[128];
	    if(response)
	    {
	        if(listitem == 0)
	        {
				ApplyActorAnimation(actorid,"ped", "SEAT_down", 4.0, 0, 0, 0, 1, 0);
				
				ActorsInfo[actorid][aAnim] = 1;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 1)
	        {
				ApplyActorAnimation(actorid,"ped","Idlestance_fat",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 2;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 2)
	        {
				ApplyActorAnimation(actorid,"PED", "idlestance_old", 4.1, 1, 0, 0, 0, 0);
				ActorsInfo[actorid][aAnim] = 3;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 3)
	        {
				ApplyActorAnimation(actorid,"POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 0);
				ActorsInfo[actorid][aAnim] = 4;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 4)
	        {
				ApplyActorAnimation(actorid,"PED", "woman_idlestance", 4.1, 1, 0, 0, 0, 0);
				ActorsInfo[actorid][aAnim] = 5;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 5)
	        {
				ApplyActorAnimation(actorid,"POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 0);
				ActorsInfo[actorid][aAnim] = 6;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 6)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_in",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 7;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 7)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0);
				ActorsInfo[actorid][aAnim] = 8;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 8)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_nod",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 9;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 9)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_out",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 10;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 10)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Copbrowse_shake",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 11;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 11)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_in",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 12;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 12)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, 0);
				ActorsInfo[actorid][aAnim] = 13;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 13)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_nod",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 14;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 14)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_out",4.0,0,0,0,1,0);
				ActorsInfo[actorid][aAnim] = 15;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 15)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT", "Coplook_shake", 4.1, 1, 0, 0, 0, 0);
				ActorsInfo[actorid][aAnim] = 16;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 16)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT", "Coplook_think", 4.1, 1, 0, 0, 0, 0);
				ActorsInfo[actorid][aAnim] = 17;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
	        if(listitem == 17)
	        {
				ApplyActorAnimation(actorid,"COP_AMBIENT","Coplook_watch", 4.0, 0, 0, 0, 0, 0);
				ActorsInfo[actorid][aAnim] = 18;
				SaveActors();

				SendClientMessage(playerid, COLOR_WHITE, "{B0C4DE}ACTORS: {FFFFFF}You have changed animation.");
				format(string, sizeof(string), "{B0C4DE}ACTORS: Admin {FF0000}%s {FFFFFF}has edited actorid {FFFF00}%d{FFFFFF}'s Animation.", GetPlayerNameEx(playerid), actorid);
				Log("logs/acedit.log", string);
			}
		}
	}
	return 1;
}
