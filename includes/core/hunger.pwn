CMD:togglehunger(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] > 1)
		return 1;

	if (_hungerTextVisible[playerid] == 1)
	{
		PlayerTextDrawHide(playerid, _hungerText[playerid]);
		_hungerTextVisible[playerid] = 0;
		PlayerInfo[playerid][pToggledChats][6] = 1;
	}
	else
	{
		PlayerTextDrawShow(playerid, _hungerText[playerid]);
		_hungerTextVisible[playerid] = 1;
		PlayerInfo[playerid][pToggledChats][6] = 0;
	}

	SendClientMessage(playerid, COLOR_WHITE, "You have toggled the hunger meter (it will reset upon next login).");

	return 1;
}

CMD:buyhotdog(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 10.0, -2450.6028, 161.1246, 35.1210) && !IsPlayerInRangeOfPoint(playerid, 4.0, 2958.0425, -1393.6724, 5.5500) && 
	!IsPlayerInRangeOfPoint(playerid, 4.0, 300.4977, 200.2298, 1104.3500) && !IsPlayerInRangeOfPoint(playerid, 4.0, 1973.0710, -1298.6427, 25.0172))
		return SendClientMessage(playerid, COLOR_GREY, "You are not at a hot dog stand.");
	if(GetPlayerCash(playerid) < 2000) return SendClientMessage(playerid, COLOR_GREY, "You need $2000 to buy a hot dog.");
	SendClientMessageEx(playerid, COLOR_GRAD4, "You have purchased a 'Hot Dog' for $2000.");
	GivePlayerCash(playerid, -2000);
	new Float:health;
	if (PlayerInfo[playerid][pFitness] >= 5) {
		PlayerInfo[playerid][pFitness] -= 5;
	}
	else {
		PlayerInfo[playerid][pFitness] = 0;
	}
	GetHealth(playerid, health);
	if(health < 100) 
	{
		if(health > 90) 
		{
			SetHealth(playerid, 100);
		}
		else 
		{
			SetHealth(playerid, health + 10.0);
		}
	}
	return 1;
}
