CMD:viewflags(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new string[128];

		SendClientMessageEx(playerid, COLOR_YELLOW, "Player Flag Count List (/viewflag [playerid/PartOfName] to view):");
		new fCounter;
		foreach(new i: Player)
		{
			if(PlayerInfo[i][pFlagged] > 0)
			{
				format(string, sizeof(string), "%s(%d) Flag Count: %d.",GetPlayerNameEx(i),i,PlayerInfo[i][pFlagged]);
				SendClientMessageEx(playerid, COLOR_GRAD1, string);
				fCounter += 1;
			}
		}	
		if(fCounter <= 0)
		{
			SendClientMessageEx(playerid, COLOR_GRAD1, "None.");
		}
	}
	else
	{
		SendErrorMessage(playerid, "You are not authorized to use this CMD.");
	}
	return 1;
}

CMD:viewflag(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new giveplayerid;
	    if(sscanf(params, "u", giveplayerid)) return SendSyntaxMessage(playerid, "/viewflag [playerid/PartOfName]");
	    if(IsPlayerConnected(giveplayerid))
	    {
			DisplayFlags(playerid, giveplayerid);
		}
	}
	else
	{
		SendErrorMessage(playerid, "You are not authorized to use this CMD.");
	}
	return 1;
}

CMD:oflag(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 2)
	{
		new string[128], query[256], name[MAX_PLAYER_NAME], reason[64], month, day, year;
		if(sscanf(params, "s[24]s[64]", name, reason)) return SendSyntaxMessage(playerid, "/oflag [player name] [reason]");
		getdate(year,month,day);

    	new giveplayerid = ReturnUser(name);
        if(IsPlayerConnected(giveplayerid))
		{
			AddFlag(giveplayerid, playerid, reason);
			SendClientMessage(playerid, COLOR_WHITE, "The person is online and has been flagged!");
			format(string, sizeof(string), "AdmCmd: %s was flagged by %s, reason: %s.", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
			ABroadCast(COLOR_LIGHTRED, string, 2);

			format(string, sizeof(string), "%s was flagged by %s (%s).", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
			Log("logs/flags.log", string);
		}
		else
		{
			new tmpReason[64], tmpName[24];
			mysql_escape_string(reason, tmpReason);
			mysql_escape_string(name, tmpName);
			SetPVarString(playerid, "OnAddFlag", tmpName);
			SetPVarString(playerid, "OnAddFlagReason", tmpReason);

			mysql_format(MainPipeline, query, sizeof(query), "SELECT id FROM `accounts` WHERE `Username`='%s'", tmpName);
			mysql_tquery(MainPipeline, query, "FlagQueryFinish", "iii", playerid, INVALID_PLAYER_ID, Flag_Query_Offline);

			format(string, sizeof(string), "Attempting to append %s's flag...", tmpName);
			SendClientMessageEx(playerid, COLOR_YELLOW, string);
		}
		return 1;
	}
	return 1;
}



CMD:flag(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 2)
	{
		new string[128], giveplayerid, reason[64];
		if(sscanf(params, "us[64]", giveplayerid, reason)) return SendSyntaxMessage(playerid, "/flag [playerid/PartOfName] [reason]");

		if(IsPlayerConnected(giveplayerid))
		{
			AddFlag(giveplayerid, playerid, reason);
			format(string, sizeof(string), "AdmCmd: %s was flagged by %s, reason: %s.", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
			ABroadCast(COLOR_LIGHTRED, string, 2);

			format(string, sizeof(string), "%s was flagged by %s (%s).", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
			Log("logs/flags.log", string);
			return 1;
		}
	}
	else SendErrorMessage(playerid, "Invalid player specified.");
	return 1;
}

CMD:transferflag(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return 1;
	new to, from, flagid;
	if(sscanf(params, "iuu", flagid, to, from)) return SendSyntaxMessage(playerid, "/transferflag [flag] [to] [from]");
	if(!IsPlayerConnected(to)) return SendClientMessageEx(playerid, COLOR_GRAD2, "ERROR: That player is not connected (to)");
	if(!IsPlayerConnected(from)) return SendClientMessageEx(playerid, COLOR_GRAD2, "ERROR: That player is not connected (from)");
	if(to == from) return SendClientMessageEx(playerid, COLOR_GRAD2, "ERROR: You cannot transfer to the same person");
	new query[128];
	mysql_format(MainPipeline, query, sizeof(query), "SELECT id, flag, issuer, time, type FROM `flags` WHERE `fid` = %i", flagid);
	mysql_tquery(MainPipeline, query, "OnRequestTransferFlag", "iiii", playerid, flagid, to, from);
	return 1;
}

CMD:aviewflag(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendErrorMessage(playerid, "You are not authorized to use this CMD.");
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendSyntaxMessage(playerid, "/aviewflag [playerid/PartOfName]");
	if(!IsPlayerConnected(giveplayerid)) return SendErrorMessage(playerid, "Player is not connected!");
	return DisplayFlags(playerid, giveplayerid, 2);
}

CMD:aflag(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendErrorMessage(playerid, "You are not authorized to use this CMD.");
	new giveplayerid, reason[64];
	if(sscanf(params, "us[64]", giveplayerid, reason)) return SendSyntaxMessage(playerid, "/aflag [playerid/PartOfName] [reason]");
	if(!IsPlayerConnected(giveplayerid)) return SendClientMessageEx(playerid, COLOR_GRAD1, "Invalid player specified.");
	AddFlag(giveplayerid, playerid, reason, 2);
	new string[128];
	format(string, sizeof(string), "AdmCmd: %s was admin flagged by %s, reason: %s.", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
	ABroadCast(COLOR_LIGHTRED, string, 2);
	format(string, sizeof(string), "[AFLAG] %s was admin flagged by %s (%s).", GetPlayerNameEx(giveplayerid), GetPlayerNameEx(playerid), reason);
	Log("logs/flags.log", string);
	return 1;
}

CMD:deleteflag(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2) return SendErrorMessage(playerid, "You are not authorized to use this CMD.");
	return ShowPlayerDialogEx(playerid, FLAG_DELETE, DIALOG_STYLE_INPUT, "FLAG DELETION", "Which flag would you like to delete?", "Delete Flag", "Close");
}
