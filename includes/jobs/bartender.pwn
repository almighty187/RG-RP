CMD:selldrink(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == 19 || PlayerInfo[playerid][pJob2] == 19 || PlayerInfo[playerid][pJob3] == 19)
	{
		if(IsAtBar(playerid))
		{
			new string[128], giveplayerid;
			if(sscanf(params, "u", giveplayerid)) return SendSyntaxMessage(playerid, "/selldrink [player]");

			if(IsPlayerConnected(giveplayerid))
			{
				if(playerid == giveplayerid)
				{
					return SendErrorMessage(playerid, "You can't sell drinks to yourself.");
				}
				if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
					DrinkOffer[giveplayerid] = playerid;
					format(string, sizeof(string), "* Bartender %s has offered has offered to pour you a drink. /accept drink to select a drink.", GetPlayerNameEx(playerid));
					SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* You have offered %s a drink.",GetPlayerNameEx(giveplayerid));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
				}
				else
				{
					return SendErrorMessage(playerid, "That person is not near you!");
				}
			}
			else
			{
				return SendErrorMessage(playerid, "That person is not connected!");
			}
		}
		else
		{
			SendErrorMessage(playerid, "You are not at a Bar!");
			return 1;
		}
	}
	else
	{
		SendErrorMessage(playerid, "You are not a bartender!");
		return 1;
	}
	return 1;
}
