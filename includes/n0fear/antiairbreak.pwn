public OnPlayerAirbreak(playerid)
{
	new string[128];
    format(string,sizeof(string),"{AA3333}AdmWarning{FFFF00}: %s (ID: %d) may be using airbreak", GetPlayerNameEx(playerid), playerid);
	ABroadCast(COLOR_YELLOW, string, 2);
	format(string,sizeof(string),"AdmWarning: %s(%d) (ID: %d) may be using airbreak", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), playerid);
	Log("logs/airbreak.log", string);
	return 1;
}
