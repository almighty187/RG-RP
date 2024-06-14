#define MAX_ARREST_POINTS 50
stock LoadArrestPoint(id)
{
	new string[128];
	mysql_format(MainPipeline, string, sizeof(string), "SELECT * FROM `arrestpoints` WHERE `id`=%d", id);
	mysql_tquery(MainPipeline, string, "OnLoadArrestPoint", "i", id);
}

stock LoadArrestPoints()
{
	printf("[LoadArrestPoints] Loading data from database...");
	mysql_tquery(MainPipeline, "SELECT * FROM `arrestpoints`", "OnLoadArrestPoints", "");
}
forward OnLoadArrestPoint(index);
public OnLoadArrestPoint(index)
{
    // Ensure the index is within the valid range
    if (index < 0 || index >= MAX_ARREST_POINTS)
    {
        printf("Error: Index out of bounds. Index: %d, Maximum allowed: %d", index, MAX_ARREST_POINTS - 1);
        return 0;
    }

    new rows;
    szMiscArray[0] = 0;
    cache_get_row_count(rows);

    for (new row; row < rows; row++)
    {
        cache_get_value_name_int(row, "id", ArrestPoints[index][arrestSQLId]);
        cache_get_value_name_float(row, "PosX", ArrestPoints[index][arrestPosX]);
        cache_get_value_name_float(row, "PosY", ArrestPoints[index][arrestPosY]);
        cache_get_value_name_float(row, "PosZ", ArrestPoints[index][arrestPosZ]);
        cache_get_value_name_int(row, "VW", ArrestPoints[index][arrestVW]);
        cache_get_value_name_int(row, "Int", ArrestPoints[index][arrestInt]);
        cache_get_value_name_int(row, "Type", ArrestPoints[index][arrestType]);

        if (ArrestPoints[index][arrestPosX] != 0)
        {
            switch (ArrestPoints[index][arrestType])
            {
                case 0:
                {
                    format(szMiscArray, sizeof(szMiscArray), "/arrest\nArrest Point #%d", index);
                    ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ] + 0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
                    ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
                    break;
                }
                case 2:
                {
                    format(szMiscArray, sizeof(szMiscArray), "/docarrest\nArrest Point #%d", index);
                    ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ] + 0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
                    ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
                    break;
                }
                case 3:
                {
                    format(szMiscArray, sizeof(szMiscArray), "/warrantarrest\nArrest Point #%d", index);
                    ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ] + 0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
                    ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
                    break;
                }
                case 4:
                {
                    format(szMiscArray, sizeof(szMiscArray), "/jarrest\nArrest Point #%d", index);
                    ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ] + 0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
                    ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
                    break;
                }
            }
        }
    }
    return 1;
}
/*forward OnLoadArrestPoint(index);
public OnLoadArrestPoint(index)
{
	new rows;
	szMiscArray[0] = 0;
	cache_get_row_count(rows);

	for(new row; row < rows; row++)
	{
		cache_get_value_name_int(row, "id", ArrestPoints[index][arrestSQLId]);
		cache_get_value_name_float(row, "PosX", ArrestPoints[index][arrestPosX]);
		cache_get_value_name_float(row, "PosY", ArrestPoints[index][arrestPosY]);
		cache_get_value_name_float(row, "PosZ", ArrestPoints[index][arrestPosZ]);
		cache_get_value_name_int(row, "VW", ArrestPoints[index][arrestVW]); 
		cache_get_value_name_int(row, "Int", ArrestPoints[index][arrestInt]); 
		cache_get_value_name_int(row, "Type", ArrestPoints[index][arrestType]); 
		if(ArrestPoints[index][arrestPosX] != 0)
		{
			switch(ArrestPoints[index][arrestType])
			{
				case 0:
				{
					format(szMiscArray, sizeof(szMiscArray), "/arrest\nArrest Point #%d", index);
					ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
					ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
				}
				case 2:
				{
					format(szMiscArray, sizeof(szMiscArray), "/docarrest\nArrest Point #%d", index);
					ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
					ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
				}
				case 3:
				{
					format(szMiscArray, sizeof(szMiscArray), "/warrantarrest\nArrest Point #%d", index);
					ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
					ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
				}
				case 4:
				{
					format(szMiscArray, sizeof(szMiscArray), "/jarrest\nArrest Point #%d", index);
					ArrestPoints[index][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[index][arrestVW], ArrestPoints[index][arrestInt], -1);
					ArrestPoints[index][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[index][arrestPosX], ArrestPoints[index][arrestPosY], ArrestPoints[index][arrestPosZ], ArrestPoints[index][arrestVW]);
				}
			}
		}
	}
	return 1;
}*/

forward OnLoadArrestPoints();
public OnLoadArrestPoints()
{
	new i, rows;
	szMiscArray[0] = 0;
	cache_get_row_count(rows);

	while(i < rows)
	{
		/*ArrestPoints[i][arrestSQLId] = cache_get_field_content_int(i, "id", MainPipeline);
		ArrestPoints[i][arrestPosX] = cache_get_field_content_float(i, "PosX", MainPipeline);
		ArrestPoints[i][arrestPosY] = cache_get_field_content_float(i, "PosY", MainPipeline);
		ArrestPoints[i][arrestPosZ] = cache_get_field_content_float(i, "PosZ", MainPipeline);
		ArrestPoints[i][arrestVW] = cache_get_field_content_int(i, "VW", MainPipeline); 
		ArrestPoints[i][arrestInt] = cache_get_field_content_int(i, "Int", MainPipeline); 
		ArrestPoints[i][arrestType] = cache_get_field_content_int(i, "Type", MainPipeline); 
		ArrestPoints[i][jailVW] = cache_get_field_content_int(i, "jailVW", MainPipeline); 
		ArrestPoints[i][jailInt] = cache_get_field_content_int(i, "jailInt", MainPipeline);
		ArrestPoints[i][JailPos1][0] = cache_get_field_content_float(i, "jailpos1x", MainPipeline);
		ArrestPoints[i][JailPos1][1] = cache_get_field_content_float(i, "jailpos1y", MainPipeline);
		ArrestPoints[i][JailPos1][2] = cache_get_field_content_float(i, "jailpos1z", MainPipeline);
		ArrestPoints[i][JailPos2][0] = cache_get_field_content_float(i, "jailpos2x", MainPipeline);
		ArrestPoints[i][JailPos2][1] = cache_get_field_content_float(i, "jailpos2y", MainPipeline);
		ArrestPoints[i][JailPos2][2] = cache_get_field_content_float(i, "jailpos2z", MainPipeline);
		if(ArrestPoints[i][arrestPosX] != 0)
		{
			switch(ArrestPoints[i][arrestType])
			{
				case 0:
				{
					format(szMiscArray, sizeof(szMiscArray), "/arrest\nArrest Point #%d", i);
					ArrestPoints[i][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[i][arrestVW], ArrestPoints[i][arrestInt], -1);
					ArrestPoints[i][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ], ArrestPoints[i][arrestVW]);
				}
				case 2:
				{
					format(szMiscArray, sizeof(szMiscArray), "/docarrest\nArrest Point #%d", i);
					ArrestPoints[i][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[i][arrestVW], ArrestPoints[i][arrestInt], -1);
					ArrestPoints[i][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ], ArrestPoints[i][arrestVW]);
				}
				case 3:
				{
					format(szMiscArray, sizeof(szMiscArray), "/warrantarrest\nArrest Point #%d", i);
					ArrestPoints[i][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[i][arrestVW], ArrestPoints[i][arrestInt], -1);
					ArrestPoints[i][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ], ArrestPoints[i][arrestVW]);
				}
				case 4:
				{
					format(szMiscArray, sizeof(szMiscArray), "/jarrest\nArrest Point #%d", i);
					ArrestPoints[i][arrestTextID] = CreateDynamic3DTextLabel(szMiscArray, COLOR_DBLUE, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[i][arrestVW], ArrestPoints[i][arrestInt], -1);
					ArrestPoints[i][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[i][arrestPosX], ArrestPoints[i][arrestPosY], ArrestPoints[i][arrestPosZ], ArrestPoints[i][arrestVW]);
				}
			}
		}*/
		LoadArrestPoint(i);
		i++;
	}
}

stock SaveArrestPoint(id)
{
	new string[1024];
	mysql_format(MainPipeline, string, sizeof(string), "UPDATE `arrestpoints` SET \
		`PosX`=%f, \
		`PosY`=%f, \
		`PosZ`=%f, \
		`VW`=%d, \
		`Int`=%d, \
		`Type`=%d, \
		`jailVW`=%d, \
		`jailInt`=%d, \
		`jailpos1x`=%f, \
		`jailpos1y`=%f, \
		`jailpos1z`=%f, \
		`jailpos2x`=%f, \
		`jailpos2y`=%f, \
		`jailpos2z`=%f WHERE `id`=%d",
		ArrestPoints[id][arrestPosX],
		ArrestPoints[id][arrestPosY],
		ArrestPoints[id][arrestPosZ],
		ArrestPoints[id][arrestVW],
		ArrestPoints[id][arrestInt],
		ArrestPoints[id][arrestType],
		ArrestPoints[id][jailVW],
		ArrestPoints[id][jailInt],
		ArrestPoints[id][JailPos1][0],
		ArrestPoints[id][JailPos1][1],
		ArrestPoints[id][JailPos1][2],
		ArrestPoints[id][JailPos2][0],
		ArrestPoints[id][JailPos2][1],
		ArrestPoints[id][JailPos2][2],
		id
	);

	mysql_tquery(MainPipeline, string, "OnQueryFinish", "i", SENDDATA_THREAD);
}

stock SaveArrestPoints()
{
	for(new i = 0; i < MAX_ARRESTPOINTS; i++)
	{
		SaveArrestPoint(i);
	}
	return 1;
}

stock RehashArrestPoint(id)
{
	DestroyDynamic3DTextLabel(ArrestPoints[id][arrestTextID]);
	DestroyDynamicPickup(ArrestPoints[id][arrestPickupID]);
	ArrestPoints[id][arrestSQLId] = -1;
	ArrestPoints[id][arrestPosX] = 0.0;
	ArrestPoints[id][arrestPosY] = 0.0;
	ArrestPoints[id][arrestPosZ] = 0.0;
	ArrestPoints[id][arrestVW] = 0;
	ArrestPoints[id][arrestInt] = 0;
	ArrestPoints[id][arrestType] = 0;
	LoadArrestPoint(id);
}

stock RehashArrestPoints()
{
	printf("[RehashArrestPoints] Deleting Arrest Points from server...");
	for(new i = 0; i < MAX_ARRESTPOINTS; i++)
	{
		RehashArrestPoint(i);
	}
	LoadArrestPoints();
}

GetArrestPointID(playerid) {
	new a = -1;
	for(new x = 0; x < MAX_ARRESTPOINTS; x++) 
	{
		if(IsPlayerInRangeOfPoint(playerid, 8.0, ArrestPoints[x][arrestPosX], ArrestPoints[x][arrestPosY], ArrestPoints[x][arrestPosZ]) && GetPlayerInterior(playerid) == ArrestPoints[x][arrestInt] && GetPlayerVirtualWorld(playerid) == ArrestPoints[x][arrestVW])
		{
			a = x;
			break;
		}
	}
	return a;
}

stock IsAtArrestPoint(playerid, type)
{
	if(IsPlayerConnected(playerid))
	{
		for(new x; x < MAX_ARRESTPOINTS; x++)
		{
			if(ArrestPoints[x][arrestPosX] != 0)
			{
				if(ArrestPoints[x][arrestType] == type)
				{
					switch(ArrestPoints[x][arrestType])
					{
						case 0:
						{
							if(IsPlayerInRangeOfPoint(playerid, 4.0, ArrestPoints[x][arrestPosX], ArrestPoints[x][arrestPosY], ArrestPoints[x][arrestPosZ]) && GetPlayerInterior(playerid) == ArrestPoints[x][arrestInt] && GetPlayerVirtualWorld(playerid) == ArrestPoints[x][arrestVW]) return 1;
						}
						case 1:
						{
							if(IsPlayerInRangeOfPoint(playerid, 50.0, ArrestPoints[x][arrestPosX], ArrestPoints[x][arrestPosY], ArrestPoints[x][arrestPosZ]) && GetPlayerInterior(playerid) == ArrestPoints[x][arrestInt] && GetPlayerVirtualWorld(playerid) == ArrestPoints[x][arrestVW]) return 1;
						}
						case 2:
						{
							if(IsPlayerInRangeOfPoint(playerid, 10.0, ArrestPoints[x][arrestPosX], ArrestPoints[x][arrestPosY], ArrestPoints[x][arrestPosZ]) && GetPlayerInterior(playerid) == ArrestPoints[x][arrestInt] && GetPlayerVirtualWorld(playerid) == ArrestPoints[x][arrestVW]) return 1;
						}
						case 3:
						{
							if(IsPlayerInRangeOfPoint(playerid, 4.0, ArrestPoints[x][arrestPosX], ArrestPoints[x][arrestPosY], ArrestPoints[x][arrestPosZ]) && GetPlayerInterior(playerid) == ArrestPoints[x][arrestInt] && GetPlayerVirtualWorld(playerid) == ArrestPoints[x][arrestVW]) return 1;
						}
						case 4:
						{
							if(IsPlayerInRangeOfPoint(playerid, 4.0, ArrestPoints[x][arrestPosX], ArrestPoints[x][arrestPosY], ArrestPoints[x][arrestPosZ]) && GetPlayerInterior(playerid) == ArrestPoints[x][arrestInt] && GetPlayerVirtualWorld(playerid) == ArrestPoints[x][arrestVW]) return 1;
						}
					}
				}
			}
		}
	}
	return 0;
}

CMD:arrestedit(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1)
	{
		new string[128], choice[32], id, amount;
		if(sscanf(params, "s[32]dD", choice, id, amount))
		{
			SendSyntaxMessage(playerid, "/arrestedit [name] [id] [amount]");
			SendClientMessageEx(playerid, COLOR_GREY, "Available names: Position, Type, jailpos1, jailpos2, Delete");
			return 1;
		}

		if(id >= MAX_ARRESTPOINTS)
		{
			SendErrorMessage(playerid, "Invalid Arrest Points ID!");
			return 1;
		}

		if(strcmp(choice, "position", true) == 0)
		{
			GetPlayerPos(playerid, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]);
			ArrestPoints[id][arrestInt] = GetPlayerInterior(playerid);
			ArrestPoints[id][arrestVW] = GetPlayerVirtualWorld(playerid);
			format(string, sizeof(string), "You have changed the position on Arrest Point #%d.", id);
			SendErrorMessage(playerid, string);
			DestroyDynamic3DTextLabel(ArrestPoints[id][arrestTextID]);
			DestroyDynamicPickup(ArrestPoints[id][arrestPickupID]);
			switch(ArrestPoints[id][arrestType])
			{
				case 0:
				{
					format(string, sizeof(string), "/arrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
				case 2:
				{
					format(string, sizeof(string), "/docarrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
				case 3:
				{
					format(string, sizeof(string), "/warrantarrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
				case 4:
				{
					format(string, sizeof(string), "/jarrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
			}
			SaveArrestPoint(id);
			format(string, sizeof(string), "%s has edited Arrest Point ID %d's position.", GetPlayerNameEx(playerid), id);
			Log("logs/arrestedit.log", string);
			return 1;
		}
		else if(strcmp(choice, "type", true) == 0)
		{
			if(ArrestPoints[id][arrestPosX] == 0)
			{
				format(string, sizeof(string), "Arrest Point #%d does not exist.", id);
				SendErrorMessage(playerid, string);
				return 1;
			}
			ArrestPoints[id][arrestType] = amount;
			format(string, sizeof(string), "You have changed the type for Arrest Point #%d to %d.", id, amount);
			SendErrorMessage(playerid, string);
			DestroyDynamic3DTextLabel(ArrestPoints[id][arrestTextID]);
			DestroyDynamicPickup(ArrestPoints[id][arrestPickupID]);
			switch(ArrestPoints[id][arrestType])
			{
				case 0:
				{
					format(string, sizeof(string), "/arrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
				case 2:
				{
					format(string, sizeof(string), "/docarrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
				case 3:
				{
					format(string, sizeof(string), "/warrantarrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
				case 4:
				{
					format(string, sizeof(string), "/jarrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
			}
			SaveArrestPoint(id);
			format(string, sizeof(string), "%s has changed the type on Arrest Point ID %d to %d.", GetPlayerNameEx(playerid), id, amount);
			Log("logs/arrestedit.log", string);
			return 1;
		}
		else if(strcmp(choice, "jailpos1", true) == 0) 
		{
			if(ArrestPoints[id][arrestPosX] == 0)
			{
				format(string, sizeof(string), "Arrest Point #%d does not exist.", id);
				SendErrorMessage(playerid, string);
				return 1;
			}
			GetPlayerPos(playerid, ArrestPoints[id][JailPos1][0], ArrestPoints[id][JailPos1][1], ArrestPoints[id][JailPos1][2]);
			ArrestPoints[id][jailVW] = GetPlayerVirtualWorld(playerid);
			ArrestPoints[id][jailInt] = GetPlayerInterior(playerid);
			format(string, sizeof(string), "You have changed the jail cell position 1 on Arrest Point #%d.", id);
			SendServerMessage(playerid, string);
			SaveArrestPoint(id);
			format(string, sizeof(string), "%s has changed the jail cell position 1 on Arrest Point ID %d.", GetPlayerNameEx(playerid), id);
			Log("logs/arrestedit.log", string);
		}
		else if(strcmp(choice, "jailpos2", true) == 0) 
		{
			if(ArrestPoints[id][arrestPosX] == 0)
			{
				format(string, sizeof(string), "Arrest Point #%d does not exist.", id);
				SendErrorMessage(playerid, string);
				return 1;
			}
			GetPlayerPos(playerid, ArrestPoints[id][JailPos2][0], ArrestPoints[id][JailPos2][1], ArrestPoints[id][JailPos2][2]);
			ArrestPoints[id][jailVW] = GetPlayerVirtualWorld(playerid);
			ArrestPoints[id][jailInt] = GetPlayerInterior(playerid);
			format(string, sizeof(string), "You have changed the jail cell position 2 on Arrest Point #%d.", id);
			SendServerMessage(playerid, string);
			SaveArrestPoint(id);
			format(string, sizeof(string), "%s has changed the jail cell position 2 on Arrest Point ID %d.", GetPlayerNameEx(playerid), id);
			Log("logs/arrestedit.log", string);
		}
		else if(strcmp(choice, "delete", true) == 0)
		{
			if(ArrestPoints[id][arrestPosX] == 0)
			{
				format(string, sizeof(string), "Arrest Point #%d does not exist.", id);
				SendErrorMessage(playerid, string);
				return 1;
			}
			DestroyDynamic3DTextLabel(ArrestPoints[id][arrestTextID]);
			DestroyDynamicPickup(ArrestPoints[id][arrestPickupID]);
			ArrestPoints[id][arrestPosX] = 0.0;
			ArrestPoints[id][arrestPosY] = 0.0;
			ArrestPoints[id][arrestPosZ] = 0.0;
			ArrestPoints[id][arrestVW] = 0;
			ArrestPoints[id][arrestInt] = 0;
			ArrestPoints[id][arrestType] = 0;
			SaveArrestPoint(id);
			format(string, sizeof(string), "You have deleted Arrest Point #%d.", id);
			SendServerMessage(playerid, string);
			format(string, sizeof(string), "%s has deleted Arrest Point ID %d.", GetPlayerNameEx(playerid), id);
			Log("logs/arrestedit.log", string);
			return 1;
		}
	}
	else SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	return 1;
}

CMD:arreststatus(playerid, params[])
{
	new id;
	if(sscanf(params, "i", id))
	{
		SendSyntaxMessage(playerid, "/arreststatus [id]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new string[128];
		format(string,sizeof(string),"|___________ Arrest Point Status (ID: %d) ___________|", id);
		SendClientMessageEx(playerid, COLOR_GREEN, string);
		format(string, sizeof(string), "[Position] X: %f | Y: %f | Z: %f | VW: %d | Int: %d | Type: %d", ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], ArrestPoints[id][arrestType]);
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "[JailPos 1] X: %f | Y: %f | Z: %f | VW: %d | Int: %d", ArrestPoints[id][JailPos1][0], ArrestPoints[id][JailPos1][1], ArrestPoints[id][JailPos1][2], ArrestPoints[id][jailVW], ArrestPoints[id][jailInt]);
		SendClientMessageEx(playerid, COLOR_WHITE, string);
		format(string, sizeof(string), "[JailPos 2] X: %f | Y: %f | Z: %f", ArrestPoints[id][JailPos2][0], ArrestPoints[id][JailPos2][1], ArrestPoints[id][JailPos2][2]);
		SendClientMessageEx(playerid, COLOR_WHITE, string);

	}
	else SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	return 1;
}

CMD:arrestnext(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1)
	{
		SendServerMessage(playerid, "Listing next available Arrest Point...");
		for(new x = 0; x < MAX_ARRESTPOINTS; x++)
		{
			if(ArrestPoints[x][arrestPosX] == 0)
		    {
		        new string[128];
		        format(string, sizeof(string), "%d is available to use.", x);
		        SendServerMessage(playerid, string);
		        break;
			}
		}
	}
	else SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	return 1;
}

CMD:gotoarrestpoint(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pFactionModerator] >= 1)
	{
		new id;
		if(sscanf(params, "d", id)) return SendSyntaxMessage(playerid, "/gotoarrestpoint [id]");

		SetPlayerPos(playerid, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]);
		SetPlayerInterior(playerid, ArrestPoints[id][arrestInt]);
		PlayerInfo[playerid][pInt] = ArrestPoints[id][arrestInt];
		SetPlayerVirtualWorld(playerid, ArrestPoints[id][arrestVW]);
		PlayerInfo[playerid][pVW] = ArrestPoints[id][arrestVW];
	}
 	else SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	return 1;
}
