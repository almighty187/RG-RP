CMD:impoundedit(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new string[128], choice[32], id, amount;
		if(sscanf(params, "s[32]dD", choice, id, amount))
		{
			SendSyntaxMessage(playerid, "/impoundedit [name] [id] [amount]");
			SendClientMessageEx(playerid, COLOR_GREY, "Available names: Position, Delete");
			return 1;
		}

		if(id >= MAX_IMPOUNDPOINTS)
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "Invalid Impound Points ID!");
			return 1;
		}

		if(strcmp(choice, "position", true) == 0)
		{
			GetPlayerPos(playerid, ImpoundPoints[id][impoundPosX], ImpoundPoints[id][impoundPosY], ImpoundPoints[id][impoundPosZ]);
			ImpoundPoints[id][impoundInt] = GetPlayerInterior(playerid);
			ImpoundPoints[id][impoundVW] = GetPlayerVirtualWorld(playerid);
			format(string, sizeof(string), "You have changed the position on impound Point #%d.", id);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			DestroyDynamic3DTextLabel(ImpoundPoints[id][impoundTextID]);
			format(string, sizeof(string), "Impound Yard #%d\nType /impound to impound a vehicle", id);
			ImpoundPoints[id][impoundTextID] = CreateDynamic3DTextLabel(string, COLOR_YELLOW, ImpoundPoints[id][impoundPosX], ImpoundPoints[id][impoundPosY], ImpoundPoints[id][impoundPosZ]+0.6, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ImpoundPoints[id][impoundVW], ImpoundPoints[id][impoundInt], -1);
			DestroyDynamicMapIcon(ImpoundPoints[id][impoundicon]);
			ImpoundPoints[id][impoundicon] = CreateDynamicMapIcon(ImpoundPoints[id][impoundPosX], ImpoundPoints[id][impoundPosY], ImpoundPoints[id][impoundPosZ], 11, COLOR_YELLOW, .streamdistance = 500.0, .style = MAPICON_GLOBAL);
			SaveImpoundPoint(id);
			format(string, sizeof(string), "%s has edited Impound Point ID %d's position.", GetPlayerNameEx(playerid), id);
			Log("logs/impoundedit.log", string);
			SendDiscordMessage(8, string);
			return 1;
		}
		else if(strcmp(choice, "delete", true) == 0)
		{
			if(ImpoundPoints[id][impoundPosX] == 0)
			{
				format(string, sizeof(string), "Impound Point #%d does not exist.", id);
				SendClientMessageEx(playerid, COLOR_WHITE, string);
				return 1;
			}
			DestroyDynamic3DTextLabel(ImpoundPoints[id][impoundTextID]);
			DestroyDynamicMapIcon(ImpoundPoints[id][impoundicon]);
			ImpoundPoints[id][impoundPosX] = 0.0;
			ImpoundPoints[id][impoundPosY] = 0.0;
			ImpoundPoints[id][impoundPosZ] = 0.0;
			ImpoundPoints[id][impoundVW] = 0;
			ImpoundPoints[id][impoundInt] = 0;
			SaveImpoundPoint(id);
			format(string, sizeof(string), "You have deleted Impound Point #%d.", id);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			format(string, sizeof(string), "%s has deleted Impound Point ID %d.", GetPlayerNameEx(playerid), id);
			Log("logs/impoundedit.log", string);
			SendDiscordMessage(8, string);
			return 1;
		}
	}
	else SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	return 1;
}

CMD:impoundstatus(playerid, params[])
{
	new id;
	if(sscanf(params, "i", id))
	{
		SendSyntaxMessage(playerid, "/impoundstatus [id]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new string[128];
		format(string,sizeof(string),"|___________ Impound Point Status (ID: %d) ___________|", id);
		SendClientMessageEx(playerid, COLOR_GREEN, string);
		format(string, sizeof(string), "[Position] X: %f | Y: %f | Z: %f | VW: %d | Int: %d", ImpoundPoints[id][impoundPosX], ImpoundPoints[id][impoundPosY], ImpoundPoints[id][impoundPosZ], ImpoundPoints[id][impoundVW], ImpoundPoints[id][impoundInt]);
		SendClientMessageEx(playerid, COLOR_WHITE, string);
	}
	else
	{
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	}
	return 1;
}

CMD:impoundnext(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pFactionModerator] == 2)
	{
		SendClientMessageEx(playerid, COLOR_RED, "* Listing next available Impound Point...");
		for(new x = 0; x < MAX_IMPOUNDPOINTS; x++)
		{
			if(ImpoundPoints[x][impoundPosX] == 0)
		    {
		        new string[128];
		        format(string, sizeof(string), "%d is available to use.", x);
		        SendClientMessageEx(playerid, COLOR_WHITE, string);
		        break;
			}
		}
	}
	else
	{
	    SendClientMessageEx(playerid, COLOR_GRAD2, "You are not authorized to use that command.");
		return 1;
	}
	return 1;
}

CMD:gotoimpoundpoint(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new id;
		if(sscanf(params, "d", id)) return SendSyntaxMessage(playerid, "/gotoimpoundpoint [id]");

		SetPlayerPos(playerid, ImpoundPoints[id][impoundPosX], ImpoundPoints[id][impoundPosY], ImpoundPoints[id][impoundPosZ]);
		SetPlayerInterior(playerid, ImpoundPoints[id][impoundInt]);
		PlayerInfo[playerid][pInt] = ImpoundPoints[id][impoundInt];
		SetPlayerVirtualWorld(playerid, ImpoundPoints[id][impoundVW]);
		PlayerInfo[playerid][pVW] = ImpoundPoints[id][impoundVW];
	}
	return 1;
}

stock IsAtImpoundingPoint(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		for(new x; x < MAX_IMPOUNDPOINTS; x++)
		{
			if(ImpoundPoints[x][impoundPosX] != 0)
			{
				if(IsPlayerInRangeOfPoint(playerid, 4.0, ImpoundPoints[x][impoundPosX], ImpoundPoints[x][impoundPosY], ImpoundPoints[x][impoundPosZ]) && GetPlayerInterior(playerid) == ImpoundPoints[x][impoundInt] && GetPlayerVirtualWorld(playerid) == ImpoundPoints[x][impoundVW]) return 1;
			}
		}
	}
	return 0;
}

stock SaveImpoundPoint(id)
{
	new string[1024];
	mysql_format(MainPipeline, string, sizeof(string), "UPDATE `impoundpoints` SET \
		`PosX`=%f, \
		`PosY`=%f, \
		`PosZ`=%f, \
		`VW`=%d, \
		`Int`=%d WHERE `id`=%d",
		ImpoundPoints[id][impoundPosX],
		ImpoundPoints[id][impoundPosY],
		ImpoundPoints[id][impoundPosZ],
		ImpoundPoints[id][impoundVW],
		ImpoundPoints[id][impoundInt],
		id
	);

	mysql_tquery(MainPipeline, string, "OnQueryFinish", "i", SENDDATA_THREAD);
}

stock SaveImpoundPoints()
{
	for(new i = 0; i < MAX_ImpoundPoints; i++)
	{
		SaveImpoundPoint(i);
	}
	return 1;
}

stock RehashImpoundPoint(id)
{
	DestroyDynamic3DTextLabel(ImpoundPoints[id][impoundTextID]);
	ImpoundPoints[id][impoundSQLId] = -1;
	ImpoundPoints[id][impoundPosX] = 0.0;
	ImpoundPoints[id][impoundPosY] = 0.0;
	ImpoundPoints[id][impoundPosZ] = 0.0;
	ImpoundPoints[id][impoundVW] = 0;
	ImpoundPoints[id][impoundInt] = 0;
	LoadImpoundPoint(id);
}

stock RehashImpoundPoints()
{
	printf("[RehashImpoundPoints] Deleting impound Points from server...");
	for(new i = 0; i < MAX_ImpoundPoints; i++)
	{
		RehashImpoundPoint(i);
	}
	LoadImpoundPoints();
}

stock LoadImpoundPoint(id)
{
	new string[128];
	format(string, sizeof(string), "SELECT * FROM `impoundpoints` WHERE `id`=%d", id);
	mysql_tquery(MainPipeline, string, "OnLoadImpoundPoint", "i", id);
}

stock LoadImpoundPoints()
{
	printf("[LoadImpoundPoints] Loading data from database...");
	mysql_tquery(MainPipeline, "SELECT * FROM `impoundpoints`", "OnLoadImpoundPoints", "");
}

forward OnLoadImpoundPoint(index);
public OnLoadImpoundPoint(index)
{
	new rows;
	szMiscArray[0] = 0;
	cache_get_row_count(rows);

	for(new row; row < rows; row++)
	{
		cache_get_value_name_int(row, "id", ImpoundPoints[index][impoundSQLId]);
		cache_get_value_name_float(row, "PosX", ImpoundPoints[index][impoundPosX]);
		cache_get_value_name_float(row, "PosY", ImpoundPoints[index][impoundPosY]);
		cache_get_value_name_float(row, "PosZ", ImpoundPoints[index][impoundPosZ]);
		cache_get_value_name_int(row, "VW", ImpoundPoints[index][impoundVW]);
		cache_get_value_name_int(row, "Int", ImpoundPoints[index][impoundInt]);
		if(ImpoundPoints[index][impoundPosX] != 0)
		{
			format(szMiscArray, sizeof(szMiscArray), "Impound Yard #%d\nType /impound to impound a vehicle", index);
			ImpoundPoints[index][impoundTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_YELLOW, ImpoundPoints[index][impoundPosX], ImpoundPoints[index][impoundPosY], ImpoundPoints[index][impoundPosZ]+0.6, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ImpoundPoints[index][impoundVW], ImpoundPoints[index][impoundInt], -1);
			CreateDynamicMapIcon(ImpoundPoints[index][impoundPosX], ImpoundPoints[index][impoundPosY], ImpoundPoints[index][impoundPosZ], 11	, COLOR_YELLOW, .streamdistance = 500.0, .style = MAPICON_GLOBAL);
		}
	}
	return 1;
}

forward OnLoadImpoundPoints();
public OnLoadImpoundPoints()
{
	new i, rows;
	szMiscArray[0] = 0;
	cache_get_row_count(rows);

	while(i < rows)
	{
		/*ImpoundPoints[i][impoundSQLId] = cache_get_field_content_int(i, "id", MainPipeline); 
		ImpoundPoints[i][impoundPosX] = cache_get_field_content_float(i, "PosX", MainPipeline);
		ImpoundPoints[i][impoundPosY] = cache_get_field_content_float(i, "PosY", MainPipeline);
		ImpoundPoints[i][impoundPosZ] = cache_get_field_content_float(i, "PosZ", MainPipeline);
		ImpoundPoints[i][impoundVW] = cache_get_field_content_int(i, "VW", MainPipeline);
		ImpoundPoints[i][impoundInt] = cache_get_field_content_int(i, "Int", MainPipeline); 
		if(ImpoundPoints[i][impoundPosX] != 0)
		{
			format(szMiscArray, sizeof(szMiscArray), "Impound Yard #%d\nType /impound to impound a vehicle", i);
			ImpoundPoints[i][impoundTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_YELLOW, ImpoundPoints[i][impoundPosX], ImpoundPoints[i][impoundPosY], ImpoundPoints[i][impoundPosZ]+0.6, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ImpoundPoints[i][impoundVW], ImpoundPoints[i][impoundInt], -1);
		}*/
		LoadImpoundPoint(i);
		i++;
	}
}
