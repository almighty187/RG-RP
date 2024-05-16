new Float:PlayerHealth[MAX_PLAYERS],
	Float:PlayerArmor[MAX_PLAYERS];

forward SetHealth(playerid, Float:hp);
public SetHealth(playerid, Float:hp)
{
	PlayerHealth[playerid] = hp;
	//UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0xFFFFFFFF, GetHealthArmorForLabel(playerid));
	return SetPlayerHealth(playerid, hp);
}

forward GetHealth(playerid, &Float:hp);
public GetHealth(playerid, &Float:hp)
{
	hp = PlayerHealth[playerid];
	return 1;
}

forward SetArmour(playerid, Float:hp);
public SetArmour(playerid, Float:hp)
{
	PlayerArmor[playerid] = hp;
	//UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0xFFFFFFFF, GetHealthArmorForLabel(playerid));
	return SetPlayerArmour(playerid, hp);
}

forward GetArmour(playerid, &Float:hp);
public GetArmour(playerid, &Float:hp)
{
	hp = PlayerArmor[playerid];
	return 1;
}

RemoveArmor(Player)
{
	SetArmour(Player, 0.0);
	return 1;
}

