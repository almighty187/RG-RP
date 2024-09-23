CMD:sex(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == 3 || PlayerInfo[playerid][pJob2] == 3 || PlayerInfo[playerid][pJob3] == 3)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "   You can only have Sex in a Car!");
			return 1;
		}
		new Car = GetPlayerVehicleID(playerid);

		new string[128], giveplayerid, money;
		if(sscanf(params, "ud", giveplayerid, money)) return SendSyntaxMessage(playerid, "/sex [player] [price]");

		if(money < 1 || money > 10000) { SendErrorMessage(playerid, "Price not lower then $1 or above $10,000!"); return 1; }
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
					if(giveplayerid == playerid) { SendErrorMessage(playerid, "You cannot have Sex with yourself!"); return 1; }
					if(IsPlayerInAnyVehicle(playerid) && IsPlayerInVehicle(giveplayerid, Car))
					{
						if(gettime() >= PlayerInfo[playerid][pSexTime])
						{
							format(string, sizeof(string), "* You offered %s to have sex with you, for $%s.", GetPlayerNameEx(giveplayerid), number_format(money));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Whore %s has offered you to have sex with them, for $%s (type /accept sex) to accept.", GetPlayerNameEx(playerid), number_format(money));
							SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
							SetPVarInt(playerid, "SexOfferTo", giveplayerid);
							SexOffer[giveplayerid] = playerid;
							SexPrice[giveplayerid] = money;
							PlayerInfo[playerid][pSexTime] = gettime()+60;
						}
						else
						{
							SendErrorMessage(playerid, "You have already had sex, wait for your reload time to finish!");
							return 1;
						}
					}
					else
					{
						SendErrorMessage(playerid, "You or the other person must be in a Car together!");
						return 1;
					}
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_GREY, "That person isn't near you.");
					return 1;
				}
			}
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
			return 1;
		}
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "   You are not a Whore!");
	}
	return 1;
}
