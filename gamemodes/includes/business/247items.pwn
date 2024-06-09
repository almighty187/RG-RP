CMD:tie(playerid, params[])
{
	if(PlayerInfo[playerid][pRope] > 0)
	{
		new id;
		if(sscanf(params, "u", id)) return SendSyntaxMessage(playerid, "/tie [playerid/PartOfName]");

		if(IsPlayerConnected(id))
		{
			if(PlayerTied[id] > 0) return  SendErrorMessage(playerid, "That player is already tied.");
			if(GetPVarInt(playerid, "Injured") || PlayerCuffed[playerid] > 0 || GetPVarInt(playerid, "IsInArena") || GetPVarInt(playerid, "EventToken") != 0 || PlayerInfo[playerid][pHospital] > 0) return  SendErrorMessage(playerid,"You cannot do this right now!");
			if(PlayerCuffed[id] != 0) return  SendErrorMessage(playerid, "You cannot do this to them right now.");

			if(ProxDetectorS(8.0, playerid, id))
			{
				szMiscArray[0] = 0;

				if(id == playerid) return  SendErrorMessage(playerid,"You cannot tie yourself!");
				if(GetPVarInt(id, "Injured") == 1) return SendClientMessageEx(playerid, COLOR_GREY, "You cannot tie someone in a injured state.");
				if(GetPlayerSpecialAction(id) != SPECIAL_ACTION_HANDSUP) return SendClientMessage(playerid, -1, "This player is not restrained.");

				format(szMiscArray, sizeof(szMiscArray), "* %s has used some rope to tie %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(id));
				ProxDetector(30.0, playerid, szMiscArray, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

				ClearAnimationsEx(id);
				SetPlayerSpecialAction(id,SPECIAL_ACTION_NONE);
				SetPlayerSpecialAction(id,SPECIAL_ACTION_CUFFED);

				PlayerTied[id] = 1;
				PlayerInfo[playerid][pRope]--;
			}
			else return  SendErrorMessage(playerid,"That person isn't near you.");
		}
		else return  SendErrorMessage(playerid,"That player is not connected.");
	}
	else  SendErrorMessage(playerid,"You do not have any rope!");
	return 1;
}

CMD:untie(playerid, params[])
{
	new id;
	if(sscanf(params, "u", id)) return SendSyntaxMessage(playerid, "/untie [playerid/PartOfName]");

	if(IsPlayerConnected(id))
	{
		if(PlayerTied[id] == 0) return  SendErrorMessage(playerid,"That player isn't tied.");
		if(GetPVarInt(playerid, "Injured") || PlayerCuffed[playerid] > 0 || GetPVarInt(playerid, "IsInArena") || GetPVarInt(playerid, "EventToken") != 0 || PlayerInfo[playerid][pHospital] > 0) return  SendErrorMessage(playerid,"You cannot do this right now!");

		if(ProxDetectorS(8.0, playerid, id))
		{
			szMiscArray[0] = 0;

			if(id == playerid) return  SendErrorMessage(playerid,"You cannot untie yourself!");

			format(szMiscArray, sizeof(szMiscArray), "* %s has untied %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(id));
			ProxDetector(30.0, playerid, szMiscArray, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

			SetPlayerSpecialAction(id,SPECIAL_ACTION_NONE);
			PlayerTied[id] = 0;
		}
		else return  SendErrorMessage(playerid,"That person isn't near you.");
	}
	else  SendErrorMessage(playerid,"That player is not connected.");
	return 1;
}

CMD:blindfold(playerid, params[])
{
	if(PlayerInfo[playerid][pRags] > 0)
	{
		new id;
		if(sscanf(params, "u", id)) return SendClientMessage(playerid, COLOR_WHITE, "SYNTAX: /blindfold [playerid/PartOfName]");

		if(IsPlayerConnected(id))
		{
			if(PlayerTied[id] == 0) return  SendErrorMessage(playerid,"The person you are trying to blindfold must be tied.");
			if(GetPVarInt(playerid, "Injured") || PlayerCuffed[playerid] > 0 || GetPVarInt(playerid, "IsInArena") || GetPVarInt(playerid, "EventToken") != 0 || PlayerInfo[playerid][pHospital] > 0) return  SendErrorMessage(playerid,"You cannot do this right now!");

			if(ProxDetectorS(8.0, playerid, id))
			{
				switch(GetPVarInt(id, "Blindfolded"))
				{
					case 0:
					{
						szMiscArray[0] = 0;

						if(id == playerid) return  SendErrorMessage(playerid,"You cannot blindfold yourself!");

						format(szMiscArray, sizeof(szMiscArray), "* %s has placed a rag around %s's head, blinding them.", GetPlayerNameEx(playerid), GetPlayerNameEx(id));
						ProxDetector(30.0, playerid, szMiscArray, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						TextDrawShowForPlayer(id, BFText);
				        SetPVarInt(id, "Blindfolded", 1);
				        PlayerInfo[playerid][pRags]--;
					}
					default:
					{
						szMiscArray[0] = 0;

						if(id == playerid) return  SendErrorMessage(playerid,"You cannot unblindfold yourself!");

						format(szMiscArray, sizeof(szMiscArray), "* %s has removed the rag around %s's head.", GetPlayerNameEx(playerid), GetPlayerNameEx(id));
						ProxDetector(30.0, playerid, szMiscArray, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						TextDrawHideForPlayer(id, BFText);
				        DeletePVar(id, "Blindfolded");
					}
				}
			}
			else return  SendErrorMessage(playerid,"That person isn't near you.");
		}
		else return  SendErrorMessage(playerid,"That player is not connected.");
	}
	else  SendErrorMessage(playerid,"You do not have any rags!");
	return 1;
}

CMD:usesprunk(playerid, params[])
{
	if(GetPVarType(playerid, "IsInArena")) return SendErrorMessage(playerid, "You can't do this while being in an arena!");
	if(HungerPlayerInfo[playerid][hgInEvent] != 0) return SendErrorMessage(playerid, "You cannot do this while being in the Hunger Games Event!");
    #if defined zombiemode
	if(zombieevent == 1 && GetPVarType(playerid, "pIsZombie")) return SendErrorMessage(playerid, "Zombies can't use this.");
	#endif
	if(PlayerInfo[playerid][pSprunk] > 0)
	{
		if(GetPVarInt(playerid, "UsingSprunk") == 1) return SendErrorMessage(playerid, "You're already drinking a sprunk can.");
		if( PlayerCuffed[playerid] >= 1 || GetPVarInt(playerid, "Injured") == 1 || PlayerInfo[playerid][pHospital] > 0)
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "You can't do this right now.");
			return 1;
		}

		if(IsPlayerInAnyVehicle(playerid))
		{
			if(IsABike(GetPlayerVehicleID(playerid)))
			{
				SendClientMessageEx(playerid, COLOR_WHITE, "You can't do this on a bike.");
				return 1;
			}
		}
		new string[128];
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DRINK_SPRUNK);
		format(string, sizeof(string), "* %s opens a can of sprunk.", GetPlayerNameEx(playerid));
		ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		SetPVarInt(playerid, "UsingSprunk", 1);
		SetPVarInt(playerid, "DrinkCooledDown", 1);
		PlayerInfo[playerid][pSprunk]--;
		return 1;
	}
	SendErrorMessage(playerid, "You don't have any sprunk, buy some from the 24/7!");
	return 1;
}

CMD:usecigar(playerid, params[])
{
	if(PlayerInfo[playerid][pCigar] > 0)
	{
		if( PlayerCuffed[playerid] >= 1 || GetPVarInt(playerid, "Injured") == 1 || PlayerInfo[playerid][pHospital] > 0)
		{
			SendErrorMessage(playerid, "You can't do this right now.");
			return 1;
		}
		new string[128];
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_SMOKE_CIGGY);
		format(string, sizeof(string), "* %s takes out a cigar and lights it.", GetPlayerNameEx(playerid));
		ProxDetector(15.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		PlayerInfo[playerid][pCigar]--;
		return 1;
	}
	else SendErrorMessage(playerid, "You don't have any cigars, buy some from the 24/7!");
	return 1;
}

CMD:paintcar(playerid, params[])
{
	new iPaintID;
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "You're not in a vehicle.");
	if(PlayerInfo[playerid][pSpraycan] == 0) return SendErrorMessage(playerid, "Your spraycan is empty.");
	if(sscanf(params, "i", iPaintID)) return SendSyntaxMessage(playerid, "/paintcar [0-6] (3 to remove a paintjob)");
	if(!(0 <= iPaintID <= 6)) return SendErrorMessage(playerid, "The specified paint job ID must be between 0 and 6.");
	
	for(new i = 0; i < MAX_PLAYERVEHICLES; i++)
	{
		if(IsPlayerInVehicle(playerid, PlayerVehicleInfo[playerid][i][pvId]))
		{
			PlayerVehicleInfo[playerid][i][pvPaintJob] = iPaintID;
			ChangeVehiclePaintjob(PlayerVehicleInfo[playerid][i][pvId], iPaintID);
			PlayerInfo[playerid][pSpraycan]--;
			g_mysql_SaveVehicle(playerid, i);
			return SendServerMessage(playerid, "You have successfully applied a paint job to your vehicle.");
		}
	}
	for(new i = 0; i < sizeof(VIPVehicles); i++)
	{
		if(IsPlayerInVehicle(playerid, VIPVehicles[i]))
		{
			ChangeVehiclePaintjob(VIPVehicles[i], iPaintID);
			PlayerInfo[playerid][pSpraycan]--;
			return SendServerMessage(playerid, "You have successfully applied a paint job to this vehicle.");
		}
	}
	for(new i = 0; i < sizeof(FamedVehicles); i++)
	{
		if(IsPlayerInVehicle(playerid, FamedVehicles[i]))
		{
			ChangeVehiclePaintjob(FamedVehicles[i], iPaintID);
			PlayerInfo[playerid][pSpraycan]--;
			return SendServerMessage(playerid, "You have successfully applied a paint job to this vehicle.");
		}
	}	
	SendErrorMessage(playerid, "You can't spray other people's vehicles.");
	return 1;
}

/*CMD:buylock(playerid, params[])
{
    if(IsAt247(playerid))
	{
	    ShowPlayerDialogEx(playerid, DIALOG_CDLOCKBUY, DIALOG_STYLE_LIST, "24/7", "Alarm Lock		$10000\nElectric Lock		$500000\nIndustrial Lock		$50000", "Buy", "Cancel");
		return 1;
	}
	else
	{
	    SendClientMessageEx(playerid, COLOR_GRAD2, "   You are not in a 24-7 !");
	}
	return 1;
}*/
