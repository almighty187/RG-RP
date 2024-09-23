CMD:service(playerid, params[])
{
	new string[128], choice[32];
	if(sscanf(params, "s[32]", choice))
	{
		SendSyntaxMessage(playerid, "/service [name]");
		SendClientMessageEx(playerid, COLOR_GREY, "Available names: Taxi, Bus, Medic, Mechanic, EMS");
		return 1;
	}

	if(PlayerInfo[playerid][pJailTime] > 0)
	{
		SendClientMessageEx(playerid, COLOR_WHITE, "You cannot use this in jail/prison.");
		return 1;
	}
	if(gettime() < PlayerInfo[playerid][pServiceTime]) return SendClientMessage(playerid, COLOR_WHITE, "You must wait 30 seconds before using this command again. " );

	if(strcmp(choice,"ems",true) == 0)
	{
		if(GetPVarInt(playerid, "Injured") == 0)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "   You are not injured, you can't call for EMS now!");
			return 1;
		}
		new zone[MAX_ZONE_NAME];
		GetPlayer2DZone(playerid, zone, MAX_ZONE_NAME);
		SetPVarInt(playerid, "EMSAttempt", 1);
		SendClientMessageEx(playerid, COLOR_WHITE, "The EMS has been informed of your current location and is on its way.");
		format(string, sizeof(string), "Emergency Dispatch has reported (%d) %s at %s. They require immediate emergency transport (/emslist).",playerid, GetPlayerNameEx(playerid), zone);
		SendMedicMessage(TEAM_MED_COLOR, string);
		PlayerInfo[playerid][pServiceTime] = gettime()+30;
		return 1;
	}
	else if(strcmp(choice,"taxi",true) == 0)
	{
		if(TaxiDrivers < 1) return SendClientMessageEx(playerid, COLOR_GREY, "   There are no taxi drivers on duty at the moment, try again later!");
		if(TransportDuty[playerid] > 0) return SendClientMessageEx(playerid, COLOR_GREY, "   You can't call for a taxi now!");

		if(GetPVarInt(playerid, "TaxiCall")) return SendClientMessage(playerid, COLOR_GREY, "	You already have a pending taxi request (/cancel taxi).");

		new szZoneName[MAX_ZONE_NAME];
		GetPlayer2DZone(playerid, szZoneName, MAX_ZONE_NAME);
		format(string, sizeof(string), "** %s (%d) is in need of a taxi driver at %s - use /ataxi to accept the call.", GetPlayerNameEx(playerid), playerid, szZoneName );
		SendTaxiMessage(TEAM_AZTECAS_COLOR, string);
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have called for a taxi driver, wait for a reply.");
		SetPVarInt(playerid, "TaxiCall", 1);
		PlayerInfo[playerid][pServiceTime] = gettime()+30;
		return 1;
	}
	else if(strcmp(choice,"bus",true) == 0)
	{
		if(BusDrivers < 1) return SendClientMessageEx(playerid, COLOR_GREY, "   There are no bus drivers at the moment, try again later!");
		if(TransportDuty[playerid] > 0) SendClientMessageEx(playerid, COLOR_GREY, "   You can't call for a bus now!");
		
		new szZoneName[MAX_ZONE_NAME];
		GetPlayer2DZone(playerid, szZoneName, sizeof(szZoneName));
		format(string, sizeof(string), "** %s(%d) is in need of a bus driver at %s - use /abus to accept the call.", GetPlayerNameEx(playerid), playerid, szZoneName );
		SendTaxiMessage(TEAM_AZTECAS_COLOR, string);
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have called for a bus driver, wait for a reply.");
		SetPVarInt(playerid, "BusCall", 1);
		PlayerInfo[playerid][pServiceTime] = gettime()+30;
		return 1;
	}
	else if(strcmp(choice,"medic",true) == 0)
	{
		new OnDutyMedics;
		foreach(new i: Player)
		{
			if(IsAMedic(i) || IsFirstAid(i) && PlayerInfo[i][pDuty] == 1)
			{
				OnDutyMedics++;
			}
		}	
		if(OnDutyMedics < 1)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "   There are no medics on duty at the moment, try again later!");
			return 1;
		}
		else
		{
			format(string, sizeof(string), "** %s is in need of a Medic - use /accept medic to accept the call.", GetPlayerNameEx(playerid));
			SendDivisionMessage(12, 2, TEAM_AZTECAS_COLOR, string);
			SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have called for a medic, wait for a reply.");
			MedicCall = playerid;
			PlayerInfo[playerid][pServiceTime] = gettime()+30;
			OnDutyMedics = 0;
			return 1;
		}
	}
	else if(strcmp(choice,"mechanic",true) == 0)
	{
		if(Mechanics < 1)
		{
			SendClientMessageEx(playerid, COLOR_GREY, "   There are no car mechanics on duty at the moment, try again later!");
			return 1;
		}
		format(string, sizeof(string), "** %s is in need of a car mechanic - use /accept mechanic to accept the call.", GetPlayerNameEx(playerid));
		SendJobMessage(7, TEAM_AZTECAS_COLOR, string);
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have called for a car mechanic, wait for a reply.");
		MechanicCall = playerid;
		PlayerInfo[playerid][pServiceTime] = gettime()+30;
		return 1;
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "   Unknown service name!");
		return 1;
	}
}
