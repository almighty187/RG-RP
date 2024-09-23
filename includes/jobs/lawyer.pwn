CMD:lawyerduty(playerid, params[])
{
	if(!IsALawyer(playerid)) return SendClientMessageEx(playerid, COLOR_GREY, "   You are not a Lawyer!");
	if(GetPVarInt(playerid, "LawyerDuty") == 1)
	{
        SendServerMessage(playerid, "* You are now off duty on your lawyer job and will not receive calls anymore.");
		SetPVarInt(playerid, "LawyerDuty", 0);
        Lawyers -= 1;
    }
    else if(GetPVarInt(playerid, "LawyerDuty") == 0)
	{
        SendServerMessage(playerid, "* You are now on duty on your lawyer job and will receive calls from people in need.");
		SetPVarInt(playerid, "LawyerDuty", 1);
        Lawyers += 1;
    }
    return 1;
}
CMD:defendtime(playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][pDefendTime] < 1)
	{
		SendServerMessage(playerid, "You're able to receive defense now.");
	}
	else {	
		format(string, sizeof(string), "You will be able to receive a defense in %d minutes.", PlayerInfo[playerid][pDefendTime]);
		SendClientMessageEx(playerid, COLOR_YELLOW, string);
	}	
	return 1;
}

CMD:offerappeal(playerid, params[])
{
  	if(!IsALawyer(playerid)) return SendErrorMessage(playerid, "You are not a Lawyer!");
    new string[128], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendSyntaxMessage(playerid, "/offerappeal [player]");
	if(giveplayerid == playerid) return SendErrorMessage(playerid, "You can't use this command on yourself!");
	if(IsPlayerConnected(giveplayerid))
	{
	    if(PlayerInfo[giveplayerid][pBeingSentenced] == 0) return SendErrorMessage(playerid, "That person isn't pending a sentence!");
	    if(AppealOfferAccepted[giveplayerid] == 1) return SendErrorMessage(playerid, "That person has already accepted a lawyer to appeal for him!");
		AppealOffer[giveplayerid] = playerid;
	    format(string, sizeof(string), "You have offered your lawyer services to %s.",GetPlayerNameEx(giveplayerid));
	    SendClientMessageEx(playerid, COLOR_WHITE, string);
	    format(string, sizeof(string), "%s has offered their lawyer services (use /accept appeal to accept them).", GetPlayerNameEx(playerid));
	    SendClientMessageEx(giveplayerid, COLOR_WHITE, string);
	}
	return 1;
}

CMD:free(playerid, params[])
{

	if(!IsALawyer(playerid)) return SendErrorMessage(playerid, "You are not a Lawyer!");

	if(PlayerInfo[playerid][pLawSkill] >= 401)
	{
		ApprovedLawyer[playerid] = 1;
	}

	new
		giveplayerid;

	if(sscanf(params, "u", giveplayerid)) {
		SendSyntaxMessage(playerid, "/free [player]");
	}
	else if(!IsPlayerConnected(giveplayerid)) {
		SendErrorMessage(playerid, "Invalid player specified.");
	}
	else if(giveplayerid == playerid) {
		SendErrorMessage(playerid, "You cannot free yourself.");
	}
	else if(PlayerInfo[giveplayerid][pJailTime] > 0 && ApprovedLawyer[playerid] == 1 && WantLawyer[giveplayerid] >= 1) {

		new
			string[128];

		format(string, sizeof(string), "* You freed %s from jail.", GetPlayerNameEx(giveplayerid));
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "* You were freed from jail, by Lawyer %s.", GetPlayerNameEx(playerid));
		SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
		ApprovedLawyer[playerid] = 0;
		WantLawyer[giveplayerid] = 0;
		CallLawyer[giveplayerid] = 0;
		PlayerInfo[giveplayerid][pBailPrice] = 0;
		PlayerInfo[giveplayerid][pJailTime] = 1;

		if(PlayerInfo[playerid][pDoubleEXP] > 0)
		{
			format(string, sizeof(string), "You have gained 2 lawyer skill points instead of 1. You have %d hours left on the Double EXP token.", PlayerInfo[playerid][pDoubleEXP]);
			SendClientMessageEx(playerid, COLOR_YELLOW, string);
			PlayerInfo[playerid][pLawSkill] += 2;
		}
		else ++PlayerInfo[playerid][pLawSkill];

		switch(PlayerInfo[playerid][pLawSkill]) {
			case 50: SendClientMessageEx(playerid, COLOR_YELLOW, "* Your lawyer skill is now Level 2, you will earn more money and now have a shorter reload time.");
			case 100: SendClientMessageEx(playerid, COLOR_YELLOW, "* Your lawyer skill is now Level 3, you will earn more money and now have a shorter reload time.");
			case 200: SendClientMessageEx(playerid, COLOR_YELLOW, "* Your lawyer skill is now Level 4, you will earn more money and now have a shorter reload time.");
			case 400: SendClientMessageEx(playerid, COLOR_YELLOW, "* Your lawyer skill is now Level 5, you will earn more money and now have a shorter reload time.");
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "That person doesn't need a laywer.");
	return 1;
}
CMD:finishappeal(playerid, params[])
{
	if(!IsALawyer(playerid)) return SendErrorMessage(playerid, "You are not a Lawyer!");
    new string[128], giveplayerid;
	if(sscanf(params, "u", giveplayerid)) return SendSyntaxMessage(playerid, "/finishappeal [player]");
	if(giveplayerid == playerid) return SendErrorMessage(playerid, "You can't use this command on yourself!");
	if(IsPlayerConnected(giveplayerid))
	{
	    if(AppealOffer[giveplayerid] != playerid) return SendErrorMessage(playerid, "You are not offering your services to this player!");
	    format(string, sizeof(string), "You have finished your Lawyer services to %s.",GetPlayerNameEx(giveplayerid));
	    SendClientMessageEx(playerid, COLOR_WHITE, string);
	    format(string, sizeof(string), "%s has finished offering their Lawyer services.", GetPlayerNameEx(playerid));
	    SendClientMessageEx(giveplayerid, COLOR_WHITE, string);
	    AppealOffer[giveplayerid] = INVALID_PLAYER_ID;
		AppealOfferAccepted[giveplayerid] = 0;
	}
	return 1;
}

CMD:defend(playerid, params[])
{
	if(!IsALawyer(playerid)) return SendErrorMessage(playerid, "You are not a Lawyer!");

	new string[128];
	if(gettime() < PlayerInfo[playerid][pLawyerTime])
	{
		format(string, sizeof(string), "You must wait %d seconds!", PlayerInfo[playerid][pLawyerTime]-gettime());
		SendClientMessageEx(playerid, COLOR_GRAD1,string);
		return 1;
	}

	new giveplayerid, money;
	if(sscanf(params, "ud", giveplayerid, money)) return SendSyntaxMessage(playerid, "/defend [player] [price]");
	if(money < 15000 || money > 1000000) { SendErrorMessage(playerid, "Price not lower then $15,000 or above $1,000,000!"); return 1; }
	if(IsPlayerConnected(giveplayerid))
	{
		if(ProxDetectorS(8.0, playerid, giveplayerid))
		{
			if(giveplayerid == playerid)
			{
				SendErrorMessage(playerid, "Cant offer protection to yourself!");
				return 1;
			}
			if(PlayerInfo[giveplayerid][pDefendTime] > 0) {
			    return SendErrorMessage(playerid, "You need wait 1 hour before defending this player.");
			}
			if(PlayerInfo[giveplayerid][pWantedLevel] > 0)
			{
				format(string, sizeof(string), "* You offered to defend %s for $%d.", GetPlayerNameEx(giveplayerid), money);
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Lawyer %s wants to defend you for $%d, (type /accept defense) to accept.", GetPlayerNameEx(playerid), money);
				SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
				PlayerInfo[playerid][pLawyerTime] = gettime()+60;
				DefendOffer[giveplayerid] = playerid;
				DefendPrice[giveplayerid] = money;
			}
			else SendErrorMessage(playerid, "That person is not wanted!");
		}
		else SendErrorMessage(playerid, "That person isn't near you.");
	}
	else SendErrorMessage(playerid, "Invalid player specified.");
	return 1;
}

