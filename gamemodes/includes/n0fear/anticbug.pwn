////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// Beta for now           /////
////////////////////////////////////////////


#include <YSI\y_hooks>



#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))



new bool:pCBugging[MAX_PLAYERS];
new ptmCBugFreezeOver[MAX_PLAYERS];
new ptsLastFiredWeapon[MAX_PLAYERS];


hook OnPlayerDisconnect(playerid, reason)
{
	ResetPlayerVariables(playerid);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!pCBugging[playerid] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(PRESSED(KEY_FIRE))
		{
			switch(GetPlayerWeapon(playerid))
			{
				case WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER:
				{
					ptsLastFiredWeapon[playerid] = gettime();
				}
			}
		}
		else if(PRESSED(KEY_CROUCH))
		{
			if((gettime() - ptsLastFiredWeapon[playerid]) < 1)
			{
                new string[128];
				TogglePlayerControllable(playerid, false);

				pCBugging[playerid] = true;

				GameTextForPlayer(playerid, "~r~~h~DON'T C-BUG!", 3000, 4);
                format(string,sizeof(string),"{AA3333}AdmWarning{FFFF00}: %s (ID: %d) may be using C bug", GetPlayerNameEx(playerid), playerid);
				ABroadCast(COLOR_YELLOW, string, 2);
				format(string,sizeof(string),"AdmWarning: %s(%d) (ID: %d) may be using C bug", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), playerid);
				Log("logs/cbug.log", string);
				KillTimer(ptmCBugFreezeOver[playerid]);
				ptmCBugFreezeOver[playerid] = SetTimerEx("CBugFreezeOver", 1500, false, "i", playerid);
			}
		}
	}
	return 1;
}

stock ResetPlayerVariables(playerid)
{
	pCBugging[playerid] = false;
	KillTimer(ptmCBugFreezeOver[playerid]);
	ptsLastFiredWeapon[playerid] = 0;
	return 1;
}

forward CBugFreezeOver(playerid);
public CBugFreezeOver(playerid)
{
	TogglePlayerControllable(playerid, true);

	pCBugging[playerid] = false;
	return 1;
}
