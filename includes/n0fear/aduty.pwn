CMD:aduty(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SendClientMessageEx(playerid, COLOR_GREY, "You are not authorized to use this command.");
	}
	if(!PlayerInfo[playerid][pAdminDuty])
	{
	    if(PlayerInfo[playerid][pUndercover][0])
		{
            OnUndercover(playerid, 0, "", 0, 0.0, 0.0);
		}
		SetPlayerSpecialTag(playerid, TAG_ADMIN);

	    SavePlayerVariables(playerid);
	    ResetPlayerWeapons(playerid);

		SetPlayerHealth(playerid, 32767);
		SetScriptArmour(playerid, 0.0);

		SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s is now on admin duty.", GetPlayerRPName(playerid));
	    SendClientMessageEx(playerid, COLOR_WHITE, "You are now on admin duty. Your stats will not be saved until you're off duty.");

        PlayerInfo[playerid][pAdminDuty] = 1;
        PlayerInfo[playerid][pTogglePhone] = 1;
        if(strcmp(PlayerInfo[playerid][pAdminName], "None", true) != 0)
        {
	        SetPlayerName(playerid, PlayerInfo[playerid][pAdminName]);
		}
	}
	else
	{
		new savecheck = 0;
		if(PlayerInfo[playerid][pPaycheck] > 1)
		{
		    savecheck = PlayerInfo[playerid][pPaycheck];
		}
		ClearDeathList(playerid);
		mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "SELECT * FROM users WHERE uid = %i", PlayerInfo[playerid][pID]);
    	mysql_tquery(connectionID, queryBuffer, "OnQueryFinished", "ii", THREAD_PROCESS_LOGIN, playerid);
		PlayerInfo[playerid][pPaycheck] = savecheck;
	}

	return 1;
}

CMD:adminname(playerid, params[])
{
	new name[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pAdmin] < 2)
	{
	    return SendClientMessage(playerid, COLOR_GREY, "You are not authorized to use this command.");
	}
	if(sscanf(params, "s[24]", name))
	{
	    return SendClientMessage(playerid, COLOR_SYNTAX, "USAGE: /adminname [name ('none' to reset)]");
	}
	if(!IsValidName(name))
	{
	    return SendClientMessage(playerid, COLOR_GREY, "The name specified is not supported by the SA-MP client.");
	}

	strcpy(PlayerInfo[playerid][pAdminName], name, MAX_PLAYER_NAME);

	if(PlayerInfo[playerid][pAdminDuty])
	{
	    SetPlayerName(playerid, name);
	}

	mysql_format(connectionID, queryBuffer, sizeof(queryBuffer), "UPDATE users SET adminname = '%e' WHERE uid = %i", name, PlayerInfo[playerid][pID]);
	mysql_tquery(connectionID, queryBuffer);

	SendAdminMessage(COLOR_LIGHTRED, "AdmCmd: %s changed their administrator name to %s.", PlayerInfo[playerid][pUsername], name);
	return 1;
}