static PlayerTeam[MAX_PLAYERS];

forward SetTeam(playerid, team);
public SetTeam(playerid, team)
{
	PlayerTeam[playerid] = team;
	return SetPlayerTeam(playerid, 999);
}

forward GetTeam(playerid);
public GetTeam(playerid)
{
	return PlayerTeam[playerid];
}
