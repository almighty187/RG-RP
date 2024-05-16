CMD:hm(playerid, params[]) return cmd_helmet(playerid, params);
CMD:helmet(playerid, params[])
{
    if(!IsABike(GetPlayerVehicleID(playerid)))
	{
        SendErrorMessage(playerid, "You are not on a bike!");
        return 1;
    }
	new string[60 + MAX_PLAYER_NAME];
    if(Seatbelt[playerid] == 0)
	{
		new icount = GetPlayerToySlots(playerid), helmetlist[8], helmetcount;
		for(new x = 0; x < icount; x++)
		{
			if(PlayerToyInfo[playerid][x][ptModelID] != 0 && PlayerToyInfo[playerid][x][ptSpecial] == 2)
			{
				helmetlist[helmetcount] = PlayerToyInfo[playerid][x][ptModelID];
				gCustomExtraList[playerid][helmetcount] =  x;
				helmetcount++;
			}
		}
		if(helmetcount != 0)
			ShowModelSelectionMenuEx(playerid, helmetlist, helmetcount, "Helmet Selector", 2000, 0.0, 0.0, 120.0);
		else
			SendErrorMessage(playerid, "You do not own any helmets! Get one at any 24/7 in order to use /helmet");
    }
    else if(Seatbelt[playerid] == 2)
	{
        Seatbelt[playerid] = 0;
		for(new i; i < 10; i++) {
			if(PlayerHoldingObject[playerid][i] == GetPVarInt(playerid, "HelmetOn")) {
				PlayerHoldingObject[playerid][i] = 0;
				RemovePlayerAttachedObject(playerid, i);
				DeletePVar(playerid, "HelmetOn");
				break;
			}
		}
		format(string, sizeof(string), "{FF8000}** {C2A2DA}%s reaches for their helmet and takes it off.", GetPlayerNameEx(playerid));
		SendClientMessageEx(playerid, COLOR_WHITE, "You have taken off your helmet.");
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    }
    return 1;
}

CMD:chm(playerid, params[]) return cmd_checkhelmet(playerid, params);
CMD:checkhelmet(playerid, params[])
{
	new giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /checkhelmet [player]");

    if(GetPlayerState(giveplayerid) == PLAYER_STATE_ONFOOT)
	{
        SendErrorMessage(playerid, "That person is not in any vehicle!");
        return 1;
    }
    if (ProxDetectorS(9.0, playerid, giveplayerid))
	{
		new string[128];
        new stext[4];
        if(Seatbelt[giveplayerid] == 0) { stext = "off"; }
        else { stext = "on"; }
        if(IsABike(GetPlayerVehicleID(playerid)))
		{
            format(string, sizeof(string), "%s's helmet is currently %s." , GetPlayerNameEx(giveplayerid) , stext);
            SendClientMessageEx(playerid,COLOR_WHITE,string);

            format(string, sizeof(string), "* %s looks at %s, checking to see if they are wearing a helmet.", GetPlayerNameEx(playerid),GetPlayerNameEx(giveplayerid));
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        }
    }
    else { SendErrorMessage(playerid, "You are not around that player!"); }
    return 1;
}
