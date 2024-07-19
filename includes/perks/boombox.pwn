CMD:setboombox(playerid, params[])
{
	if(GetPVarType(playerid, "pBoomBox"))
	{
		ShowSetStation(playerid);
    }
	else
	{
	    SendErrorMessage(playerid, "You don't have a boombox out!");
	}
	return 1;
}

CMD:shopboombox(playerid, params[])
{
	if (PlayerInfo[playerid][pShopTech] < 1)
	{
		SendErrorMessage(playerid, "You are not allowed to use this CMD.");
		return 1;
	}

	new giveplayerid, invoice;
	if(sscanf(params, "ui", giveplayerid, invoice)) return SendSyntaxMessage(playerid, "/shopboombox [player] [invoice #]");
	new string[128];

	if(PlayerInfo[giveplayerid][pBoombox] == 1)
	{
	    PlayerInfo[giveplayerid][pBoombox] = 0;
    	format(string, sizeof(string), "Your boombox has been taken by Shop Tech %s. ", GetPlayerNameEx(playerid));
		SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "[SHOPBOOMBOX] %s has taken %s(%d) boombox - Invoice %d", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid), GetPlayerSQLId(giveplayerid), invoice);
		SendClientMessageEx(playerid, COLOR_GRAD1, string);
		Log("logs/shoplog.log", string);
	}
	else
	{
		PlayerInfo[giveplayerid][pBoombox] = 1;
    	format(string, sizeof(string), "You have been given a boombox from Shop Tech %s. ", GetPlayerNameEx(playerid));
		SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "[SHOPBOOMBOX] %s has given %s(%d) a boombox - Invoice %d", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid), GetPlayerSQLId(giveplayerid), invoice);
		SendClientMessageEx(playerid, COLOR_GRAD1, string);
		Log("logs/shoplog.log", string);
	}
	return 1;
}

CMD:placeboombox(playerid, params[])
{
	if(PlayerInfo[playerid][pBoombox] == 1 || PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1)
	{
	    if(GetPVarType(playerid, "IsInArena")) return SendErrorMessage(playerid, "You can't do this while being in an arena!");
		if(GetPVarInt(playerid, "WatchingTV")) return SendErrorMessage(playerid, "You can not do this while watching TV!");
		if(GetPVarInt(playerid, "Injured") == 1 || PlayerInfo[playerid][pJailTime] > 0 || PlayerInfo[playerid][pHospital] > 0 || IsPlayerInAnyVehicle(playerid)) return SendClientMessageEx(playerid, COLOR_WHITE, "You can't do this right now.");
		//if(PlayerInfo[playerid][pVW] == 0 || PlayerInfo[playerid][pInt] == 0) return SendClientMessageEx(playerid, COLOR_WHITE, "You can only place boomboxes inside interiors.");
		if(GetPVarType(playerid, "pBoomBox")) return SendErrorMessage(playerid, "You already have a boombox out, use /destroyboombox.");

		foreach(new i: Player)
		{
			if(GetPVarType(i, "pBoomBox"))
			{
				if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "pBoomBoxX"), GetPVarFloat(i, "pBoomBoxY"), GetPVarFloat(i, "pBoomBoxZ")) && GetPVarInt(i, "pBoomBoxVW") == GetPlayerVirtualWorld(playerid))
				{
					SendErrorMessage(playerid, "You are in range of another boombox, you can't place one here!");
					return 1;
				}
			}
		}	

		new string[128];
		format(string, sizeof(string), "%s has placed a boombox!", GetPlayerNameEx(playerid));
	    ProxDetector(30.0, playerid, string, COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);

	    new Float:x, Float:y, Float:z, Float:a;
	    GetPlayerPos(playerid, x, y, z);
	    GetPlayerFacingAngle(playerid, a);
	    ApplyAnimation(playerid,"BOMBER","BOM_Plant_Crouch_In", 4.0, 0, 0, 0, 0, 0, 1);
	    x += (2 * floatsin(-a, degrees));
    	y += (2 * floatcos(-a, degrees));
    	z -= 1.0;

	    SetPVarInt(playerid, "pBoomBox", CreateDynamicObject(2103, x, y, z, 0.0, 0.0, a, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
	    SetPVarFloat(playerid, "pBoomBoxX", x); SetPVarFloat(playerid, "pBoomBoxY", y); SetPVarFloat(playerid, "pBoomBoxZ", z);
		format(string, sizeof(string), "%s's boombox\n{FF0000}/setboombox {FFFF00}or\n{FF0000}/destroyboombox", GetPlayerNameEx(playerid));
	    SetPVarInt(playerid, "pBoomBoxLabel", _:CreateDynamic3DTextLabel(string, COLOR_YELLOW, x, y, z+0.6, 5.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
		SetPVarInt(playerid, "pBoomBoxArea", CreateDynamicSphere(x, y, z, 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
		SetPVarInt(playerid, "pBoomBoxInt", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "pBoomBoxVW", GetPlayerVirtualWorld(playerid));
	}
	else
	{
		SendErrorMessage(playerid, "You don't have a boom box! Buy from one forum.rg-rp.org");
	}
	return 1;
}

CMD:destroyboombox(playerid, params[])
{
	if(GetPVarType(playerid, "pBoomBox"))
	{
	    DestroyDynamicObject(GetPVarInt(playerid, "pBoomBox"));
	    DestroyDynamic3DTextLabel(Text3D:GetPVarInt(playerid, "pBoomBoxLabel"));
	    DeletePVar(playerid, "pBoomBox"); DeletePVar(playerid, "pBoomBoxStation"); DeletePVar(playerid, "pBoomBoxLabel");
	    DeletePVar(playerid, "pBoomBoxX"); DeletePVar(playerid, "pBoomBoxY"); DeletePVar(playerid, "pBoomBoxZ");
	    if(GetPVarType(playerid, "pBoomBoxArea"))
	    {
	        new string[128];
			format(string, sizeof(string), "* %s has destroyed the boombox.", GetPlayerNameEx(playerid));
	        foreach(new i: Player)
			{
				if(IsPlayerInDynamicArea(i, GetPVarInt(playerid, "pBoomBoxArea")))
				{
					StopAudioStreamForPlayerEx(i);
					SendClientMessage(i, COLOR_PURPLE, string);
				}
			}	
	        DeletePVar(playerid, "pBoomBoxArea");
		}
		SendServerMessage(playerid, "You've destroyed your boombox!");
	}
	else
	{
	    foreach(new i: Player)
		{
			if(GetPVarType(i, "pBoomBox"))
			{
				if(GetPVarInt(i, "pBoomBoxVW") == GetPlayerVirtualWorld(playerid) && GetPVarInt(i, "pBoomBoxInt") == GetPlayerInterior(playerid) && IsPlayerInRangeOfPoint(playerid, 5.0, GetPVarFloat(i, "pBoomBoxX"), GetPVarFloat(i, "pBoomBoxY"), GetPVarFloat(i, "pBoomBoxZ")))
				{
					DestroyDynamicObject(GetPVarInt(i, "pBoomBox"));
					DestroyDynamic3DTextLabel(Text3D:GetPVarInt(i, "pBoomBoxLabel"));

					DeletePVar(i, "pBoomBox");
					DeletePVar(i, "pBoomBoxStation");
					DeletePVar(i, "pBoomBoxLabel");
					DeletePVar(i, "pBoomBoxX");
					DeletePVar(i, "pBoomBoxY");
					DeletePVar(i, "pBoomBoxZ");
					DeletePVar(i, "pBoomBoxInt");
					DeletePVar(i, "pBoomBoxVW");

					new string[128];
					if(GetPVarType(i, "pBoomBoxArea"))
					{
						format(string, sizeof(string), "* %s has destroyed the boombox.", GetPlayerNameEx(playerid));
						foreach(new pi:Player)
						{
							if(IsPlayerInDynamicArea(pi, GetPVarInt(i, "pBoomBoxArea")))
							{
								StopAudioStreamForPlayerEx(pi);
								SendClientMessage(pi, COLOR_PURPLE, string);
							}
						}	
						DeletePVar(i, "pBoomBoxArea");
					}
					format(string, sizeof(string), "%s has destroyed your boombox!", GetPlayerNameEx(playerid));
					SendClientMessage(i, COLOR_WHITE, string);
					return 1;
				}
			}
		}	
	    SendErrorMessage(playerid, "You don't have a boombox or you are not near one to destroy.");
	}
	return 1;
}
