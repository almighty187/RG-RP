CMD:setrankname(playerid, params[]){
	new
		iGroupID = PlayerInfo[playerid][pMember],
		iRank = PlayerInfo[playerid][pRank],
		iTargetID,
		iRankName[24],
		szMessage[128];

	if (0 <= iGroupID < MAX_GROUPS) {
 		if (iRank >= arrGroupData[iGroupID][g_iCustomRanks]) {
			if(sscanf(params, "us[24]", iTargetID, iRankName)) return SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /setrankname [player] [name]");
			if(!IsPlayerConnected(iTargetID)) return SendClientMessageEx(playerid, COLOR_WHITE, "Player entered isn't currently connected!");
			if(strlen(iRankName) > 24) return SendClientMessageEx(playerid, COLOR_GREY, "Rank cannot be higher than 24 characters!");
			if(iGroupID == PlayerInfo[iTargetID][pMember])
			{
				if(strcmp(iRankName, "None", false)) {
					format(szMessage, sizeof(szMessage), "You have set %s's rank title to %s", GetPlayerNameEx(iTargetID), iRankName);
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);
					format(szMessage, sizeof(szMessage), "Your rank title has been set to %s by %s", iRankName, GetPlayerNameEx(playerid));
					SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);
					strcpy(PlayerInfo[iTargetID][pRankName], iRankName, 24);
					return 1;
				} 
				else {
					format(szMessage, sizeof(szMessage), "You have revoked %s's rank title", GetPlayerNameEx(iTargetID));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, szMessage);
					format(szMessage, sizeof(szMessage), "Your rank title has been revoked by %s", GetPlayerNameEx(playerid));
					SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, szMessage);
					strcpy(PlayerInfo[iTargetID][pRankName], arrGroupRanks[iGroupID][PlayerInfo[playerid][pRank]], 24);
					return 1;
				}	
			}
			else SendClientMessageEx(playerid, COLOR_GRAD1, "That person is not in your group.");		
		}
		else return SendClientMessageEx(playerid, COLOR_GREY, "You cannot use this command.");
	}
	else return SendClientMessageEx(playerid, COLOR_GREY, "You are not in a group.");
	return 1;
}

forward OnSetRankName(playerid, target, name[]);
public OnSetRankName(playerid, target, name[]) {
    strcpy(PlayerInfo[target][pRankName], name, 24);
    return 1;
}