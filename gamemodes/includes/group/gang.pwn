#include <YSI\y_hooks>

#define             DIALOG_EDITGANG							(9100)
#define             DIALOG_GANG_NAME						(9101)
#define             DIALOG_GANG_DUTYCOL						(9102)
#define             DIALOG_GANG_RADIOCOL					(9103)
#define             DIALOG_GANG_OOCCOLOR					(9104)
#define             DIALOG_GANG_LISTPAY						(9105)
#define             DIALOG_GANG_EDITDIVS					(9106)
#define             DIALOG_GANG_EDITRANKS					(9107)
#define             DIALOG_GANG_LOCKERS						(9108)
#define             DIALOG_GANG_CRATEPOS					(9109)
#define             DIALOG_GANG_GARAGEPOS					(9110)
#define             DIALOG_GANG_LISTCLOTHES					(9111)
#define             DIALOG_GANG_TURFCAP						(9112)
#define             DIALOG_GANG_POINTCAP					(9113)
#define             DIALOG_GANG_PURGE						(9114)
#define             DIALOG_GANG_DISBAND						(9115)
#define             DIALOG_GANG_LOCKERACTION				(9116)
#define             DIALOG_GANG_EDITRANK					(9117)
#define             DIALOG_GANG_EDITDIV						(9118)
#define             DIALOG_GANG_EDITCLOTHES					(9119)
#define             DIALOG_GANG_TRANSFERSLOT				(9120)
#define             DIALOG_GANG_TRANSFERSLOTC				(9121)
#define             DIALOG_EDITWRANK						(9123)
#define             DIALOG_EDITWRANK1						(9124)
#define             DIALOG_GANGPOINTSHOP					(9125)
#define             DIALOG_GANGARMSDEALER					(9026)
#define             DIALOG_GANGDRUGDEALER					(9027)
#define             DIALOG_GANGARMSWEAPONS					(9028)
#define             DIALOG_GANGARMSEDIT						(9029)
#define             DIALOG_GANGARMSPRICES					(9030)
#define             DIALOG_GANGARMSDEPOSITMATS				(9031)
#define             DIALOG_GANGARMSWITHDRAWMATS				(9032)
#define             DIALOG_GANGARMSPRICE					(9033)


ReloadGang(gangid)
{
	new string[128];

	DestroyDynamic3DTextLabel(arrGroupData[gangid][gText][0]);
    DestroyDynamic3DTextLabel(arrGroupData[gangid][gText][1]);
    DestroyActor(arrGroupData[gangid][gActors][0]);
    DestroyActor(arrGroupData[gangid][gActors][1]);
	DestroyDynamicMapIcon(arrGroupData[gangid][g_adMapIcon]);
	DestroyDynamicMapIcon(arrGroupData[gangid][g_ddMapIcon]);
    if(arrGroupData[gangid][gArmsDealer] && arrGroupData[gangid][gArmsX] != 0.0 && arrGroupData[gangid][gArmsY] != 0.0 && arrGroupData[gangid][gArmsZ] != 0.0)
    {
		format(string, sizeof(string), "%s Arms Dealer\n{1FBDFF}Type /armsdealer {FFFF00}to use.", arrGroupData[gangid][g_szGroupName]);
        arrGroupData[gangid][gActors][0] = CreateActor(arrGroupData[gangid][gArmsSkin], arrGroupData[gangid][gArmsX], arrGroupData[gangid][gArmsY], arrGroupData[gangid][gArmsZ], arrGroupData[gangid][gArmsA]);
		arrGroupData[gangid][gText][0] = CreateDynamic3DTextLabel(string, arrGroupData[gangid][g_hDutyColour] * 256 + 0xFF, arrGroupData[gangid][gArmsX], arrGroupData[gangid][gArmsY], arrGroupData[gangid][gArmsZ] + 0.3, 10.0, .worldid = arrGroupData[gangid][gArmsWorld]);
	    SetActorVirtualWorld(arrGroupData[gangid][gActors][0], arrGroupData[gangid][gArmsWorld]);
		arrGroupData[gangid][g_adMapIcon] = CreateDynamicMapIcon(arrGroupData[gangid][gArmsX], arrGroupData[gangid][gArmsY], arrGroupData[gangid][gArmsZ], 6, 0, arrGroupData[gangid][gArmsWorld], .streamdistance = 500.0);
	}
	if(arrGroupData[gangid][gDrugDealer] && arrGroupData[gangid][gDrugX] != 0.0 && arrGroupData[gangid][gDrugY] != 0.0 && arrGroupData[gangid][gDrugZ] != 0.0)
    {
        format(string, sizeof(string), "%s Drug Dealer\n{1FBDFF}Type /drugdealer {FFFF00}to use.", arrGroupData[gangid][g_szGroupName]);
        arrGroupData[gangid][gActors][1] = CreateActor(arrGroupData[gangid][gDrugSkin], arrGroupData[gangid][gDrugX], arrGroupData[gangid][gDrugY], arrGroupData[gangid][gDrugZ], arrGroupData[gangid][gDrugA]);
        arrGroupData[gangid][gText][1] = CreateDynamic3DTextLabel(string, arrGroupData[gangid][g_hDutyColour] * 256 + 0xFF, arrGroupData[gangid][gDrugX], arrGroupData[gangid][gDrugY], arrGroupData[gangid][gDrugZ] + 0.3, 10.0, .worldid = arrGroupData[gangid][gDrugWorld]);
        SetActorVirtualWorld(arrGroupData[gangid][gActors][1], arrGroupData[gangid][gDrugWorld]);
		arrGroupData[gangid][g_ddMapIcon] = CreateDynamicMapIcon(arrGroupData[gangid][gDrugX], arrGroupData[gangid][gDrugY], arrGroupData[gangid][gDrugZ], 24, 0, arrGroupData[gangid][gDrugWorld], .streamdistance = 500.0);
	}
}
Gang_DisbandGang(iGroupID) {

	new
		i = 0,
		szQuery[256],
		string[256];
	format(string, sizeof(string), "(( Gang News: %s has been disbanded. ))", arrGroupData[iGroupID][g_szGroupName]);
	SendClientMessageToAll(COLOR_WHITE, string);
	SendDiscordMessage(4, string);
	arrGroupData[iGroupID][g_iAllegiance] = 0;
	arrGroupData[iGroupID][g_iBugAccess] = INVALID_RANK;
	arrGroupData[iGroupID][g_iRadioAccess] = INVALID_RANK;
	arrGroupData[iGroupID][g_iFindAccess] = INVALID_RANK;
	arrGroupData[iGroupID][g_iDeptRadioAccess] = INVALID_RANK;
	arrGroupData[iGroupID][g_iIntRadioAccess] = INVALID_RANK;
	arrGroupData[iGroupID][g_iGovAccess] = INVALID_RANK;
	arrGroupData[iGroupID][g_iTreasuryAccess] = INVALID_RANK;
	arrGroupData[iGroupID][g_iFreeNameChange] = INVALID_RANK;
	arrGroupData[iGroupID][g_iFreeNameChangeDiv] = INVALID_DIVISION;
	arrGroupData[iGroupID][g_iSpikeStrips] = INVALID_RANK;
	arrGroupData[iGroupID][g_iBarricades] = INVALID_RANK;
	arrGroupData[iGroupID][g_iCones] = INVALID_RANK;
	arrGroupData[iGroupID][g_iFlares] = INVALID_RANK;
	arrGroupData[iGroupID][g_iBarrels] = INVALID_RANK;
	arrGroupData[iGroupID][g_iLadders] = INVALID_RANK;
	arrGroupData[iGroupID][g_iTapes] = INVALID_RANK;
	arrGroupData[iGroupID][g_iBudget] = 0;
	arrGroupData[iGroupID][g_iBudgetPayment] = 0;
	arrGroupData[iGroupID][g_iCrateIsland] = INVALID_RANK;
	arrGroupData[iGroupID][g_fCratePos][0] = 0;
	arrGroupData[iGroupID][g_fCratePos][1] = 0;
	arrGroupData[iGroupID][g_fCratePos][2] = 0;
	arrGroupData[iGroupID][g_szGroupName][0] = 0;

	arrGroupData[iGroupID][g_hDutyColour] = 0xFFFFFF;
	arrGroupData[iGroupID][g_hRadioColour] = 0xFFFFFF;
//
	arrGroupData[iGroupID][g_iMemberCount] = 0;
	arrGroupData[iGroupID][g_iGroupToyID] = 0;
	arrGroupData[iGroupID][g_iMaterials] = 0;

	arrGroupData[iGroupID][g_iDrugs][0] = 0;
	arrGroupData[iGroupID][g_iDrugs][1] = 0;
	arrGroupData[iGroupID][g_iDrugs][2] = 0;
	arrGroupData[iGroupID][g_iDrugs][3] = 0;
	arrGroupData[iGroupID][g_iDrugs][4] = 0;
	
	arrGroupData[iGroupID][gArmsDealer] = 0;
    arrGroupData[iGroupID][gDrugDealer] = 0;
    arrGroupData[iGroupID][gArmsX] = 0.0;
    arrGroupData[iGroupID][gArmsY] = 0.0;
    arrGroupData[iGroupID][gArmsZ] = 0.0;
	arrGroupData[iGroupID][gArmsA] = 0.0;
    arrGroupData[iGroupID][gDrugX] = 0.0;
    arrGroupData[iGroupID][gDrugY] = 0.0;
    arrGroupData[iGroupID][gDrugZ] = 0.0;
	arrGroupData[iGroupID][gDrugA] = 0.0;
    arrGroupData[iGroupID][gArmsWorld] = 0;
    arrGroupData[iGroupID][gDrugWorld] = 0;
    arrGroupData[iGroupID][gDrugPot] = 0;
    arrGroupData[iGroupID][gDrugCrack] = 0;
    arrGroupData[iGroupID][gDrugMeth] = 0;
	arrGroupData[iGroupID][gDrugEcstasy] = 0;
    arrGroupData[iGroupID][gDrugHeroin] = 0;
    arrGroupData[iGroupID][gArmsMaterials] = 0;
    DestroyActor(arrGroupData[iGroupID][gActors][0]);
	DestroyActor(arrGroupData[iGroupID][gActors][1]);
    DestroyDynamic3DTextLabel(arrGroupData[iGroupID][gText][0]);
    DestroyDynamic3DTextLabel(arrGroupData[iGroupID][gText][1]);
	DestroyDynamicMapIcon(arrGroupData[iGroupID][g_adMapIcon]);
	DestroyDynamicMapIcon(arrGroupData[iGroupID][g_ddMapIcon]);
	
	/*szMiscArray[0] = 0;
	format(szMiscArray, sizeof(szMiscArray), "UPDATE `gWeaponsNew` SET `1` = '0'");
	for(new x = 2; x < 47; x++) format(szMiscArray, sizeof(szMiscArray), "%s, `%d` = '0'", szMiscArray, x);
	format(szMiscArray, sizeof(szMiscArray), "%s WHERE `id` = '%d'", szMiscArray, iGroupID + 1);
	mysql_function_query(MainPipeline, szMiscArray, false, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID);
	*/
	
	
	szMiscArray[0] = 0;
	format(szMiscArray, sizeof(szMiscArray), "UPDATE `gWeaponsNew` SET `1` = '0'");
	for(new x = 2; x < 47; x++) format(szMiscArray, sizeof(szMiscArray), "%s, `%d` = '0'", szMiscArray, x);
	mysql_format(MainPipeline, szMiscArray, sizeof(szMiscArray), "%s WHERE `id` = '%d'", szMiscArray, iGroupID + 1);
	mysql_tquery(MainPipeline, szMiscArray, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID);
	

	DestroyDynamic3DTextLabel(arrGroupData[iGroupID][g_tCrate3DLabel]);

	while(i < MAX_GROUP_DIVS) {
		arrGroupDivisions[iGroupID][i++][0] = 0;
	}
	i = 0;

	while(i < MAX_GROUP_RANKS) {
		arrGroupRanks[iGroupID][i][0] = 0;
		arrGroupData[iGroupID][g_iPaycheck][i++] = 0;
	}
	i = 0;

	while(i < MAX_GROUP_WEAPONS) {
		arrGroupData[iGroupID][g_iLockerGuns][i] = 0;
		arrGroupData[iGroupID][g_iLockerCost][i++] = 0;
	}

	i = 0;
	while(i < MAX_GROUP_LOCKERS) {
		DestroyDynamic3DTextLabel(arrGroupLockers[iGroupID][i][g_tLocker3DLabel]);
		arrGroupLockers[iGroupID][i][g_fLockerPos][0] = 0.0;
		arrGroupLockers[iGroupID][i][g_fLockerPos][1] = 0.0;
		arrGroupLockers[iGroupID][i][g_fLockerPos][2] = 0.0;
		arrGroupData[iGroupID][g_iLockerGuns][i] = 0;
		arrGroupData[iGroupID][g_iLockerCost][i++] = 0;
	}
	SaveGroup(iGroupID);
	
	for(new x; x < MAX_DYNAMIC_VEHICLES; x++)
	{
		if(DynVehicleInfo[x][gv_igID] != INVALID_GROUP_ID && DynVehicleInfo[x][gv_igID] == iGroupID)
		{
			DynVehicleInfo[x][gv_iModel] = 0;
			DynVehicleObjInfo[x][0][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
			DynVehicleObjInfo[x][1][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
			DynVehicleObjInfo[x][2][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
			DynVehicleObjInfo[x][3][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
			DynVehicleInfo[x][gv_igID] = INVALID_GROUP_ID;
			DynVehicleInfo[x][gv_igDivID] = 0;
			DynVehicleInfo[x][gv_fMaxHealth] = 1000;
			DynVehicleInfo[x][gv_iUpkeep] = 0;
			DynVehicleInfo[x][gv_iSiren] = 0;
			DynVeh_Save(x);
			DynVeh_Spawn(x);
		}
	}
	
	foreach(new x: Player)
	{
		if(PlayerInfo[x][pMember] == iGroupID || PlayerInfo[x][pLeader] == iGroupID || PlayerInfo[x][pSlotHolder] == iGroupID) {
			SendClientMessageEx(x, COLOR_WHITE, "Your group has been disbanded by the slot holder. All members have been automatically removed.");
			PlayerInfo[x][pLeader] = INVALID_GROUP_ID;
			PlayerInfo[x][pMember] = INVALID_GROUP_ID;
			PlayerInfo[x][pSlotHolder] = INVALID_GROUP_ID;
			PlayerInfo[x][pRank] = INVALID_RANK;
			PlayerInfo[x][pDivision] = INVALID_DIVISION;
			strcpy(PlayerInfo[x][pBadge], "None", 9);
		}
		if (PlayerInfo[x][pBugged] == iGroupID) PlayerInfo[x][pBugged] = INVALID_GROUP_ID;
	}
	/*
	format(szQuery, sizeof szQuery, "DELETE FROM `groupbans` WHERE `GroupBan` = %i", iGroupID);
	mysql_function_query(MainPipeline, szQuery, false, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID+1);

	format(szQuery, sizeof szQuery, "UPDATE `accounts` SET `Member` = "#INVALID_GROUP_ID", `SlotHolder` = "#INVALID_GROUP_ID", `Leader` = "#INVALID_GROUP_ID", `Division` = "#INVALID_DIVISION", `Rank` = "#INVALID_RANK" WHERE `Member` = %i OR `Leader` = %i OR `SlotHolder` = %i", iGroupID, iGroupID, iGroupID);
	return mysql_function_query(MainPipeline, szQuery, false, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID);
	*/
	
	
	mysql_format(MainPipeline, szQuery, sizeof szQuery, "DELETE FROM `groupbans` WHERE `GroupBan` = %i", iGroupID);
	mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID+1);

	mysql_format(MainPipeline, szQuery, sizeof szQuery, "UPDATE `accounts` SET `Member` = "#INVALID_GROUP_ID", `SlotHolder` = "#INVALID_GROUP_ID", `Leader` = "#INVALID_GROUP_ID", `Division` = "#INVALID_DIVISION", `Rank` = "#INVALID_RANK" WHERE `Member` = %i OR `Leader` = %i OR `SlotHolder` = %i", iGroupID, iGroupID, iGroupID);
	return mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID);
}
Gang_PurgeGang(iGroupID)
{
	new szQuery[256];
	foreach(new x: Player)
	{
		if(PlayerInfo[x][pMember] == iGroupID && PlayerInfo[x][pLeader] == INVALID_GROUP_ID)
		{
			SendClientMessageEx(x, COLOR_WHITE, "Your gang has been purged by the slot holder. All members have been automatically removed.");
			PlayerInfo[x][pLeader] = INVALID_GROUP_ID;
			PlayerInfo[x][pMember] = INVALID_GROUP_ID;
			PlayerInfo[x][pRank] = INVALID_RANK;
			PlayerInfo[x][pDivision] = INVALID_DIVISION;
		}
		if (PlayerInfo[x][pBugged] == iGroupID) PlayerInfo[x][pBugged] = INVALID_GROUP_ID;
	}
	arrGroupData[iGroupID][g_iMemberCount] = 0;
	/*
	format(szQuery, sizeof szQuery, "DELETE FROM `groupbans` WHERE `GroupBan` = %i", iGroupID);
	mysql_function_query(MainPipeline, szQuery, false, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID+1);

	format(szQuery, sizeof szQuery, "UPDATE `accounts` SET `Member` = "#INVALID_GROUP_ID", `Division` = "#INVALID_DIVISION", `Rank` = "#INVALID_RANK" WHERE `Member` = %i", iGroupID);
	return mysql_function_query(MainPipeline, szQuery, false, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID);
	*/
	mysql_format(MainPipeline, szQuery, sizeof szQuery, "DELETE FROM `groupbans` WHERE `GroupBan` = %i", iGroupID);
	mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID+1);

	mysql_format(MainPipeline, szQuery, sizeof szQuery, "UPDATE `accounts` SET `Member` = "#INVALID_GROUP_ID", `Leader` = "#INVALID_GROUP_ID", `Division` = "#INVALID_DIVISION", `Rank` = "#INVALID_RANK" WHERE `Member` = %i OR `Leader` = %i", iGroupID, iGroupID);
	return mysql_tquery(MainPipeline, szQuery, "OnQueryFinish", "ii", SENDDATA_THREAD, iGroupID);
}

Gang_DisplayDialog(iPlayerID, iGroupID) {

	new
		szTitle[22 + GROUP_MAX_NAME_LEN],
		szDialog[2048];

	format(szDialog, sizeof(szDialog),
		"{BBBBBB}Edit Weapon Restriction\n\
		{BBBBBB}Edit Withdraw Rank\n\
		{BBBBBB}Duty colour: {%s}(edit)\n\
		{BBBBBB}Radio colour: {%s}(edit)\n\
		{BBBBBB}Edit OOC Chat Color: {%s}(edit)\n",
		Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]),
		Group_NumToDialogHex(arrGroupData[iGroupID][g_hRadioColour]),
		Group_NumToDialogHex(arrGroupData[iGroupID][g_hOOCColor])
	);

	format(szDialog, sizeof(szDialog),
		"%s\
		{BBBBBB}Edit Divisions (%i defined)\n\
		{BBBBBB}Edit Ranks (%i defined)\n\
		{BBBBBB}Edit Group Clothes\n",
		szDialog,
		String_Count(arrGroupDivisions[iGroupID], MAX_GROUP_DIVS),
		String_Count(arrGroupRanks[iGroupID], MAX_GROUP_RANKS)
	);

	/*format(szDialog, sizeof(szDialog),
		"%s\
		{BBBBBB}Edit Group Clothes\n\
		{BBBBBB}Edit Turf Cap Rank{FFFFFF} %s (rank %i)\n\
		{BBBBBB}Edit Point Cap Rank {FFFFFF} %s (rank %i)\n\
		{FF0000}Transfer Slot\n\
		{FF0000}Purge Gang\n\
		{FF0000}Disband Gang",
		szDialog,
		(arrGroupData[iGroupID][g_iTurfCapRank] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iTurfCapRank],
		(arrGroupData[iGroupID][g_iPointCapRank] != INVALID_RANK) ? ("Yes") : ("No"), arrGroupData[iGroupID][g_iPointCapRank]
	);*/
	if(PlayerInfo[iPlayerID][pSlotHolder] == iGroupID) strcat(szDialog, "{BBBBBB}Leaders List\n{FF0000}Transfer Slot");
	format(szTitle, sizeof szTitle, "{FFFFFF}Leader Menu {%s}%s", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
	return ShowPlayerDialogEx(iPlayerID, DIALOG_EDITGANG, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

	if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;
	szMiscArray[0] = 0;
	new string[256];
	new
				iGroupID = PlayerInfo[playerid][pMember];	
	switch(dialogid)
	{
		case DIALOG_EDITWRANK: {
			if(response) {
				{
					SetPVarInt(playerid, "Gang_EditWRank", listitem);
					new
						szTitle[22 + GROUP_MAX_NAME_LEN],
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
						if(arrGroupRanks[iGroupID][i][0])
						{
							format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));
						}
					}
					
					format(szTitle, sizeof szTitle, "Withdraw Rank {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_EDITWRANK1, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
			}
			else Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_EDITWRANK1: {
			if(response) {
				{
					new editwrank = GetPVarInt(playerid, "Gang_EditWRank");
					arrGroupData[iGroupID][g_iWithdrawRank][editwrank] = listitem;
					format(szMiscArray, sizeof(szMiscArray), "You have adjusted the withdraw rank to %i.", listitem);
					SendClientMessageEx(playerid, COLOR_GREY, szMiscArray);
					format(szMiscArray, sizeof(szMiscArray), "%s has adjusted the withdraw rank for item %d to %i.", GetPlayerNameEx(playerid), editwrank, listitem);
					GroupLog(iGroupID, szMiscArray);
				}
			}
			else {
				DeletePVar(playerid, "Gang_EditWRank");
				Gang_DisplayDialog(playerid, iGroupID);
			}
		}
		case DIALOG_GANGPOINTSHOP:
		{
			new family = PlayerInfo[playerid][pMember];
		    if(family == INVALID_GROUP_ID || PlayerInfo[playerid][pLeader] < 0) return 1;

		    if(response)
		    {
		        switch(listitem)
		        {
					case 0: //Locker
		            {
						if(PlayerInfo[playerid][pCash] < 250000) return SendClientMessageEx(playerid, COLOR_GREY, "You need $250,000 on hand to purchase this upgrade.");
						for(new i = 0; i < MAX_GROUP_LOCKERS; i++)
						{
							if(arrGroupLockers[family][i][g_fLockerPos][0] == 0.0)
							{	
								//GetPlayerPos(playerid, arrGroupLockers[family][i][g_fLockerPos][0], arrGroupLockers[family][i][g_fLockerPos][1], arrGroupLockers[family][i][g_fLockerPos][2]);
								arrGroupLockers[family][i][g_fLockerPos][0] = 500;
								arrGroupLockers[family][i][g_fLockerPos][1] = 500;
								arrGroupLockers[family][i][g_fLockerPos][2] = 500;
								arrGroupLockers[family][i][g_iLockerVW] = 0;
								DestroyDynamic3DTextLabel(arrGroupLockers[family][i][g_tLocker3DLabel]);
								DestroyDynamicArea(arrGroupLockers[family][i][g_iLockerAreaID]);
								format(szMiscArray, sizeof szMiscArray, "%s Locker\n{FFFF00}Press {1FBDFF}~k~~CONVERSATION_YES~ {FFFF00} to use\n ID: %i", arrGroupData[family][g_szGroupName], arrGroupLockers[family][i]);
								arrGroupLockers[family][i][g_tLocker3DLabel] = CreateDynamic3DTextLabel(szMiscArray, arrGroupData[family][g_hDutyColour] * 256 + 0xFF, arrGroupLockers[family][i][g_fLockerPos][0], arrGroupLockers[family][i][g_fLockerPos][1], arrGroupLockers[family][i][g_fLockerPos][2], 15.0, .testlos = 1, .worldid = arrGroupLockers[family][i][g_iLockerVW]);
								arrGroupLockers[family][i][g_iLockerAreaID] = CreateDynamicSphere(arrGroupLockers[family][i][g_fLockerPos][0], arrGroupLockers[family][i][g_fLockerPos][1], arrGroupLockers[family][i][g_fLockerPos][2], 3.0, .worldid = arrGroupLockers[family][i][g_iLockerVW]);

								SaveGroup(family);
								GivePlayerCash(playerid, -250000);
								SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $250,000 on an additional locker (Type /editgang to edit the location).");
								return 1;
							}
						}
						SendClientMessageEx(playerid, COLOR_GREY, "Your gang already own max lockers count.");	
						
						//Log_Write("log_gang", "%s (uid: %i) spent 500 GP & $50000 on an NPC drug dealer for %s (id: %i).", GetPlayerNameEx(playerid), PlayerInfo[playerid][pID], arrGroupData[family][gName], family);
					}
					case 1: //Rank
		            {
						if(PlayerInfo[playerid][pCash] < 150000) return SendClientMessageEx(playerid, COLOR_GREY, "You need $150,000 on hand to purchase this upgrade.");
						for(new i = 0; i < MAX_GROUP_RANKS; i++)
						{
							if(!(arrGroupRanks[family][i][0]))
							{	
								mysql_escape_string("RankName", arrGroupRanks[family][i]);
								SaveGroup(family);
								PlayerInfo[playerid][pRank] = Group_GetMaxRank(family);
								GivePlayerCash(playerid, -150000);
								SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $150,000 on an additional rank and skin (Type /editgang to change the rank name and skin id).");
								return 1;
							}
						}
						SendClientMessageEx(playerid, COLOR_GREY, "Your gang already own max ranks count.");	
						//Log_Write("log_gang", "%s (uid: %i) spent 500 GP & $50000 on an NPC drug dealer for %s (id: %i).", GetPlayerNameEx(playerid), PlayerInfo[playerid][pID], arrGroupData[family][gName], family);
					}
					case 2: //Division
		            {
						if(PlayerInfo[playerid][pCash] < 50000) return SendClientMessageEx(playerid, COLOR_GREY, "You need $50,000 on hand to purchase this upgrade.");
						for(new i = 0; i < MAX_GROUP_RANKS; i++)
						{
							if(!(arrGroupDivisions[family][i][0]))
							{	
								mysql_escape_string("DivName", arrGroupDivisions[family][i]);
								SaveGroup(family);
								GivePlayerCash(playerid, -50000);
								SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $50,000 on an additional division (Type /editgang to change the division name).");
								return 1;
							}
						}
						SendClientMessageEx(playerid, COLOR_GREY, "Your gang already own max divisions count.");	
						//Log_Write("log_gang", "%s (uid: %i) spent 500 GP & $50000 on an NPC drug dealer for %s (id: %i).", GetPlayerNameEx(playerid), PlayerInfo[playerid][pID], arrGroupData[family][gName], family);
					}
					case 3: //Vehicle
		            {
						if(PlayerInfo[playerid][pCash] < 500000) return SendClientMessageEx(playerid, COLOR_GREY, "You need $500,000 on hand to purchase this upgrade.");
						GivePlayerCash(playerid, -500000);

						AddFlag(playerid, INVALID_PLAYER_ID, "Gang Vehicle");

						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $500,000 on a Gang Vehicle. (Flagged)");
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Contact a Lead Admin so you can get your gang vehicle");
						/*for(new i = 0; i < 11; i++)
						{
							if(!(arrGroupRanks[family][i][0]))
							{	
								mysql_escape_string("RankName", arrGroupRanks[family][i]);
								SaveGroup(family);
								GivePlayerCash(playerid, -500000);
								SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $500,000 on an additional rank and skin (Type /editgang to change the rank name and skin id).");
								return 1;
							}
						}
						SendClientMessageEx(playerid, COLOR_GREY, "Your gang already own max vehicles count.");	
						*/
						//Log_Write("log_gang", "%s (uid: %i) spent 500 GP & $50000 on an NPC drug dealer for %s (id: %i).", GetPlayerNameEx(playerid), PlayerInfo[playerid][pID], arrGroupData[family][gName], family);
					}
		            case 4: //Drug Dealer
		            {
						if(PlayerInfo[playerid][pCash] < 500000) return SendClientMessageEx(playerid, COLOR_GREY, "You need $500,000 on hand to purchase this upgrade.");
						if(arrGroupData[family][gDrugDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang already has this upgrade.");

						arrGroupData[family][gDrugDealer] = 1;
						arrGroupData[family][gDrugX] = 0.0;
						arrGroupData[family][gDrugY] = 0.0;
						arrGroupData[family][gDrugZ] = 0.0;
						arrGroupData[family][gDrugPot] = 0;
						arrGroupData[family][gDrugCrack] = 0;
						arrGroupData[family][gDrugMeth] = 0;
						arrGroupData[family][gDrugEcstasy] = 0;
						arrGroupData[family][gDrugMeth] = 0;
						arrGroupData[family][gDrugPrices][0] = 500;
						arrGroupData[family][gDrugPrices][1] = 1000;
						arrGroupData[family][gDrugPrices][2] = 3000;
						arrGroupData[family][gDrugPrices][3] = 5000;
						arrGroupData[family][gDrugPrices][4] = 10000;
						SaveGroup(family);
						GivePlayerCash(playerid, -500000);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $500,000 on a Drug Dealer NPC (Type /gangnpc to place your drug dealer and /destroygangnpc to destroy it).");
						//Log_Write("log_gang", "%s (uid: %i) spent 500 GP & $50000 on an NPC drug dealer for %s (id: %i).", GetPlayerNameEx(playerid), PlayerInfo[playerid][pID], arrGroupData[family][gName], family);
					}
					case 5: //Arms dealer
		            {
						if(PlayerInfo[playerid][pCash] < 500000)  return SendClientMessageEx(playerid, COLOR_GREY, "You need $500,000 on hand to purchase this upgrade.");
						if(arrGroupData[family][gArmsDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang already has this upgrade.");

						arrGroupData[family][gArmsDealer] = 1;
						arrGroupData[family][gArmsX] = 0.0;
						arrGroupData[family][gArmsY] = 0.0;
						arrGroupData[family][gArmsZ] = 0.0;
						arrGroupData[family][gArmsMaterials] = 0;
						SaveGroup(family);
						GivePlayerCash(playerid, -500000);
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $500,000 on an Arms Dealer NPC (Type /gangnpc to place your arms dealer and /destroygangnpc to destroy it).");
						//Log_Write("log_gang", "%s (uid: %i) spent 500 GP & $50000 on an NPC arm dealer for %s (id: %i).", GetPlayerNameEx(playerid), PlayerInfo[playerid][pID], arrGroupData[family][gName], family);
					}
                    case 6: //Exterior mapping
					{
						/*if(PlayerInfo[playerid][pCash] < 1000000) return SendClientMessageEx(playerid, COLOR_GREY, "You need $1,000,000 on hand to purchase this upgrade.");

						GivePlayerCash(playerid, -1000000);

						AddFlag(playerid, INVALID_PLAYER_ID, "Custom Gang Exterior Mapping");

						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $1,000,000 on a Custom Gang Exterior Mapping. (Flagged)");
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Contact a Lead Admin so you can get your gang vehicle");*/
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "This is disabled right now");
					}
					case 7: //Interior mapping
					{
						if(PlayerInfo[playerid][pCash] < 1000000) return SendClientMessageEx(playerid, COLOR_GREY, "You need $1,000,000 on hand to purchase this upgrade.");

						GivePlayerCash(playerid, -1000000);

						AddFlag(playerid, INVALID_PLAYER_ID, "Custom Gang Interior Mapping");

						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have spent $1,000,000 on a Custom Gang Interior Mapping. (Flagged)");
						SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "Contact a Lead Admin so you can get your custom interior");
					}
		        }
		    }
		}
		case DIALOG_EDITGANG: {
			if(!(0 <= PlayerInfo[playerid][pSlotHolder] < MAX_GROUPS) && !IsACriminal(playerid) && PlayerInfo[playerid][pMember] == INVALID_GROUP_ID) return 1;
			new
				szTitle[64 + GROUP_MAX_NAME_LEN];

			if(response) switch(listitem) {
				case 0: WeaponRankList(playerid);
				case 1: {
					new szDialog[256];
					format(szTitle, sizeof szTitle, "Withdraw Rank {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					format(szDialog, sizeof(szDialog),
						"{BBBBBB}Money{FFFFFF} (rank %i)\n\
						{BBBBBB}Materials{FFFFFF} (rank %i)\n\
						{BBBBBB}Drugs{FFFFFF} (rank %i)",
						arrGroupData[iGroupID][g_iWithdrawRank][0],
						arrGroupData[iGroupID][g_iWithdrawRank][1],
						arrGroupData[iGroupID][g_iWithdrawRank][2]
					);
					ShowPlayerDialogEx(playerid, DIALOG_EDITWRANK, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				/*case 2: {
					format(szTitle, sizeof szTitle, "Edit Gang Name {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_NAME, DIALOG_STYLE_INPUT, szTitle, "Specify a name for this gang.", "Confirm", "Cancel");
				}*/
				case 2: {
					format(szTitle, sizeof szTitle, "Edit Gang Duty Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_DUTYCOL, DIALOG_STYLE_INPUT, szTitle, "Enter a colour in hexadecimal format (for example, BCA3FF). This colour will be used to identify the gang (i.e. name tag colour).", "Confirm", "Cancel");
				}
				case 3: {
					format(szTitle, sizeof szTitle, "Edit Gang Radio Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_RADIOCOL, DIALOG_STYLE_INPUT, szTitle, "Enter a colour in hexadecimal format (for example, BCA3FF). This colour will be used for the gang's in-character radio chat.", "Confirm", "Cancel");
				}
				case 4: {
					format(szTitle, sizeof szTitle, "Edit Gang OOC Chat Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_OOCCOLOR, DIALOG_STYLE_INPUT, szTitle, "Enter a color in hexadecimal format (for example, BCA3FF). This color will be used for the gang's OOC chat.", "Confirm", "Cancel");
				}
				case 5: {

					new
						szDialog[(GROUP_MAX_DIV_LEN + 8) * MAX_GROUP_DIVS];

					for(new i = 0; i != MAX_GROUP_DIVS; ++i) {
						if(arrGroupDivisions[iGroupID][i][0])
						{
							format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupDivisions[iGroupID][i][0]) ? (arrGroupDivisions[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));
						}
					}

					format(szTitle, sizeof szTitle, "Edit Gang Divisions {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITDIVS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 6: {

					new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
						if(arrGroupRanks[iGroupID][i][0])
						{
							format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));
						}
					}

					format(szTitle, sizeof szTitle, "Edit Gang Ranks {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITRANKS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
				}
				case 7: {
					new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

					for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
						if(arrGroupRanks[iGroupID][i][0])
						{
							format(szDialog, sizeof szDialog, "%s\nRank %i (%s): Skin ID:%i", szDialog, i, arrGroupRanks[iGroupID][i], arrGroupData[iGroupID][g_iClothes][i]);
						}
					}

					format(szTitle, sizeof szTitle, "Edit Gang Clothes {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_LISTCLOTHES, DIALOG_STYLE_LIST, szTitle, szDialog, "Edit", "Cancel");
				}
				case 8: {
					mysql_format(MainPipeline, string, sizeof(string), "SELECT `id`, `Username`, `LastLogin`, `Leader`, `SlotHolder` FROM `accounts` WHERE `Leader` = %d", iGroupID);
					mysql_tquery(MainPipeline, string, "OnLeadersList", "i", playerid);
				}
				default: {
					format(szTitle, sizeof szTitle, "{FF0000}Transfer Slot{FFFFFF} {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					ShowPlayerDialogEx(playerid, DIALOG_GANG_TRANSFERSLOT, DIALOG_STYLE_INPUT, szTitle, "Please input the player id you wish to transfer slot to.", "Confirm", "Cancel");
				}
			}
			else SaveGroup(iGroupID);
		}
		case DIALOG_GANG_NAME: {

			if(response && (0 <= PlayerInfo[playerid][pSlotHolder] < MAX_GROUPS)) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				if(!(2 < strlen(inputtext) < GROUP_MAX_NAME_LEN)) {
					format(szTitle, sizeof szTitle, "Edit Gang {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_NAME, DIALOG_STYLE_INPUT, szTitle, "The specified name must be between 2 and "#GROUP_MAX_NAME_LEN" characters.\n\nSpecify a name for this gang.", "Confirm", "Cancel");
				}
				format(string, sizeof(string), "%s has changed group %d's name from %s to %s", GetPlayerNameEx(playerid), iGroupID+1, arrGroupData[iGroupID][g_szGroupName], inputtext);
				Log("logs/editgang.log", string);
				strcpy(arrGroupData[iGroupID][g_szGroupName], inputtext, GROUP_MAX_NAME_LEN);
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_DUTYCOL: {

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN],
					hColour;

				if(strlen(inputtext) > 6 || !ishex(inputtext)) {
					format(szTitle, sizeof szTitle, "Edit Gang Duty Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_DUTYCOL, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nEnter a colour in hexadecimal format (for example, BCA3FF). This colour will be used to identify the gang.", "Confirm", "Cancel");
				}
				sscanf(inputtext, "h", hColour);
				if (hColour == 0xFFFFFF) {
					format(szTitle, sizeof szTitle, "Edit Gang Duty Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_DUTYCOL, DIALOG_STYLE_INPUT, szTitle, "You cannot use white as the value.\n\nEnter a colour in hexadecimal format (for example, BCA3FF). This colour will be used to identify the gang.", "Confirm", "Cancel");
				}
				arrGroupData[iGroupID][g_hDutyColour] = hColour;
				foreach(new i: Player)
				{
					if (PlayerInfo[i][pMember] == iGroupID) SetPlayerToTeamColor(i);
				}

				format(string, sizeof(string), "%s has set the duty color to %x in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_hDutyColour], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgang.log", string);

			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_RADIOCOL: {

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN],
					hColour;

				if(strlen(inputtext) > 6 || !ishex(inputtext)) {
					format(szTitle, sizeof szTitle, "Edit Gang Radio Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_RADIOCOL, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nEnter a colour in hexadecimal format (for example, BCA3FF). This colour will be used for the gang's in-character radio chat.", "Confirm", "Cancel");
				}
				sscanf(inputtext, "h", hColour);
				arrGroupData[iGroupID][g_hRadioColour] = hColour;

				format(string, sizeof(string), "%s has set the radio color to %x in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_hRadioColour], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgang.log", string);

			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_OOCCOLOR: {

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN],
					hColour;

				if(strlen(inputtext) > 6 || !ishex(inputtext)) {
					format(szTitle, sizeof szTitle, "Edit Gang OOC Chat Color {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_OOCCOLOR, DIALOG_STYLE_INPUT, szTitle, "Invalid value specified.\n\nEnter a color in hexadecimal format (for example, BCA3FF). This color will be that of their OOC Chat.", "Confirm", "Cancel");
				}
				sscanf(inputtext, "h", hColour);
				arrGroupData[iGroupID][g_hOOCColor] = hColour;

				format(string, sizeof(string), "%s has set the OOC Chat color to %x in %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_hOOCColor], arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgang.log", string);
			}

			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_EDITDIVS: {

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				SetPVarInt(playerid, "Gang_EditDiv", listitem);
				format(szTitle, sizeof szTitle, "Edit Gang Division (%i) {%s}(%s)", listitem, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITDIV, DIALOG_STYLE_INPUT, szTitle, "Specify a division name.", "Confirm", "Cancel");
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_EDITDIV: {

			new
				iDivID = GetPVarInt(playerid, "Gang_EditDiv"),
				szTitle[32 + GROUP_MAX_NAME_LEN];

			if(response) {
				if(strlen(inputtext) >= GROUP_MAX_DIV_LEN) {
					format(szTitle, sizeof szTitle, "Edit Gang Division (%i) {%s}(%s)", iDivID, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITDIV, DIALOG_STYLE_INPUT, szTitle, "The specified name must be less than "#GROUP_MAX_DIV_LEN" characters in length.\n\nSpecify a division name.", "Confirm", "Cancel");
				}
				if(strlen(inputtext) < 2) {
					format(szTitle, sizeof szTitle, "Edit Gang Division (%i) {%s}(%s)", iDivID, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITDIV, DIALOG_STYLE_INPUT, szTitle, "The specified name must be atleast 2 characters in length.\n\nSpecify a division name.", "Confirm", "Cancel");
				}
				if( 2 <= strlen(inputtext) < GROUP_MAX_DIV_LEN) mysql_escape_string(inputtext, arrGroupDivisions[iGroupID][iDivID]);
			}

			new
				szDialog[(GROUP_MAX_DIV_LEN + 8) * MAX_GROUP_DIVS];

			for(new i = 0; i != MAX_GROUP_DIVS; ++i) {
				if(arrGroupDivisions[iGroupID][i][0])
				{
					format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupDivisions[iGroupID][i][0]) ? (arrGroupDivisions[iGroupID][i]) : ("{AAAAAA}(undefined){FFFFFF}")));
				}
			}

			format(szTitle, sizeof szTitle, "Edit Gang Divisions {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
			ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITDIVS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
			DeletePVar(playerid, "Gang_EditDiv");
		}
		case DIALOG_GANG_EDITRANKS: {

			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				SetPVarInt(playerid, "Gang_EditRank", listitem);
				format(szTitle, sizeof szTitle, "Edit Gang Rank (%i) {%s}(%s)", listitem, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITRANK, DIALOG_STYLE_INPUT, szTitle, "Specify a rank name.", "Confirm", "Cancel");
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_EDITRANK: {

			new
				iRankID = GetPVarInt(playerid, "Gang_EditRank"),
				szTitle[32 + GROUP_MAX_NAME_LEN];

			if(response) {
				if(strlen(inputtext) >= GROUP_MAX_RANK_LEN) {
					format(szTitle, sizeof szTitle, "Edit Gang Rank (%i) {%s}(%s)", iRankID, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITRANK, DIALOG_STYLE_INPUT, szTitle, "The specified name must be less than "#GROUP_MAX_RANK_LEN" characters in length.\n\nSpecify a rank name.", "Confirm", "Cancel");
				}
				if(strlen(inputtext) < 2) {
					format(szTitle, sizeof szTitle, "Edit Gang Rank (%i) {%s}(%s)", iRankID, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITRANK, DIALOG_STYLE_INPUT, szTitle, "The specified name must be atleast 2 characters in length.\n\nSpecify a rank name.", "Confirm", "Cancel");
				}
				if( 2 <= strlen(inputtext) < GROUP_MAX_RANK_LEN) mysql_escape_string(inputtext, arrGroupRanks[iGroupID][iRankID]);
			}

			new
				szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

			for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
				if(arrGroupRanks[iGroupID][i][0])
				{
					format(szDialog, sizeof szDialog, "%s\n(%i) %s", szDialog, i, ((arrGroupRanks[iGroupID][i][0]) ? (arrGroupRanks[iGroupID][i]) : ("{BBBBBB}(undefined){FFFFFF}")));
				}	
			}

			format(szTitle, sizeof szTitle, "Edit Gang Ranks {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
			ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITRANKS, DIALOG_STYLE_LIST, szTitle, szDialog, "Select", "Cancel");
			DeletePVar(playerid, "Gang_EditRank");
		}
		case DIALOG_GANG_LOCKERS: {

			new
				szTitle[32 + GROUP_MAX_NAME_LEN];

			if(response)
			{
				format(szTitle, sizeof szTitle, "Edit Gang Locker Position {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				SetPVarInt(playerid, "Gang_EditLocker", listitem);
				ShowPlayerDialogEx(playerid, DIALOG_GANG_LOCKERACTION, DIALOG_STYLE_MSGBOX, szTitle, "{FFFFFF}Are you sure you want to move this locker to your current position?", "Confirm", "Cancel");
				return 1;
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_LISTCLOTHES: {
		
			if(response) {

				new
					szTitle[32 + GROUP_MAX_NAME_LEN];

				SetPVarInt(playerid, "Gang_EditRankSkin", listitem);
				format(szTitle, sizeof szTitle, "Edit Gang Clothes (%i) {%s}(%s)", listitem, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITCLOTHES, DIALOG_STYLE_INPUT, szTitle, "Specify a skin ID for this rank.", "OK", "Cancel");
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_EDITCLOTHES: {

			new
				iRankID = GetPVarInt(playerid, "Gang_EditRankSkin");

			if(response) {
				new szTitle[128];
				if(!(0 <= strval(inputtext) <= 311)) {
					format(szTitle, sizeof szTitle, "Edit Gang Clothes (%i) {%s}(%s)", listitem + 1, Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_EDITCLOTHES, DIALOG_STYLE_INPUT, szTitle, "The specified ID must be between 0 and 311.\n\nSpecify a skin ID for this rank.", "OK", "Cancel");
				}
				arrGroupData[iGroupID][g_iClothes][iRankID] = strval(inputtext);
				new
						szDialog[(GROUP_MAX_RANK_LEN + 8) * MAX_GROUP_RANKS];

				for(new i = 0; i != MAX_GROUP_RANKS; ++i) {
					if(arrGroupRanks[iGroupID][i][0])
					{
						format(szDialog, sizeof szDialog, "%s\nRank %i (%s): Skin ID:%i", szDialog, i, arrGroupRanks[iGroupID][i], arrGroupData[iGroupID][g_iClothes][i]);
					}
				}

				format(szTitle, sizeof szTitle, "Edit Gang Clothes {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				ShowPlayerDialogEx(playerid, DIALOG_GANG_LISTCLOTHES, DIALOG_STYLE_LIST, szTitle, szDialog, "Edit", "Cancel");
				format(string, sizeof(string), "%s has changed the skin ID for rank %d (%s) to $%d in %s (%d)", GetPlayerNameEx(playerid), iRankID, arrGroupRanks[iGroupID][iRankID], strval(inputtext), iGroupID + 1);
				Log("logs/editgang.log", string);
				DeletePVar(playerid, "Gang_EditRankSkin");
				return 1;
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_TURFCAP: {

			if(response) {
				arrGroupData[iGroupID][g_iTurfCapRank] = listitem;
				format(string, sizeof(string), "%s has set the minimum rank for turf capping to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iTurfCapRank], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iTurfCapRank]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
				Log("logs/editgang.log", string);
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_POINTCAP: {

			if(response) {
				arrGroupData[iGroupID][g_iPointCapRank] = listitem;
				format(string, sizeof(string), "%s has set the minimum rank for point capping to %d (%s) in group %d (%s)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_iPointCapRank], arrGroupRanks[iGroupID][arrGroupData[iGroupID][g_iPointCapRank]], iGroupID+1, arrGroupData[iGroupID][g_szGroupName]);
				Log("logs/editgang.log", string);
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_TRANSFERSLOT: {
			new
				szTitle[64 + GROUP_MAX_NAME_LEN];
			if(response) {
				new id = strval(inputtext);
			
				if(!IsPlayerConnected(id) || !gPlayerLogged{id}) {
					SendClientMessageEx(playerid, COLOR_WHITE, "  The player you are trying to transfer to is not connected!");
					format(szTitle, sizeof szTitle, "{FF0000}Transfer Slot{FFFFFF} {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_TRANSFERSLOT, DIALOG_STYLE_INPUT, szTitle, "Please input the player id you wish to transfer slot to.", "Confirm", "Cancel");
				}
				if(PlayerInfo[id][pMember] != PlayerInfo[playerid][pSlotHolder]) return SendClientMessageEx(playerid, COLOR_WHITE, "  The player you are trying to transfer to is not a part of your gang!");
				szMiscArray[0] = 0;
				SetPVarInt(playerid, "SlotTransferTo", id);
				format(szTitle, sizeof szTitle, "{FF0000}Transfer Slot{FFFFFF} {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				format(szMiscArray, sizeof(szMiscArray), "{FFFFFF}Are you absolutely sure you wish to transfer the slot to {FF0000}%s", GetPlayerNameEx(id));
				return ShowPlayerDialogEx(playerid, DIALOG_GANG_TRANSFERSLOTC, DIALOG_STYLE_MSGBOX, szTitle, szMiscArray, "Transfer", "Cancel");
			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_TRANSFERSLOTC: {
			new
				szTitle[64 + GROUP_MAX_NAME_LEN];
			if(!response) {
				DeletePVar(playerid, "SlotTransferTo");
				format(szTitle, sizeof szTitle, "{FF0000}Transfer Slot{FFFFFF} {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
				return ShowPlayerDialogEx(playerid, DIALOG_GANG_TRANSFERSLOT, DIALOG_STYLE_INPUT, szTitle, "Please input the player id you wish to transfer slot to.", "Confirm", "Cancel");
			}
			if(response) {
				new id = GetPVarInt(playerid, "SlotTransferTo");
			
				if(!IsPlayerConnected(id) || !gPlayerLogged{id}) {
					SendClientMessageEx(playerid, COLOR_WHITE, "  The player you are trying to transfer to has disconnected!");
					format(szTitle, sizeof szTitle, "{FF0000}Transfer Slot{FFFFFF} {%s}(%s)", Group_NumToDialogHex(arrGroupData[iGroupID][g_hDutyColour]), arrGroupData[iGroupID][g_szGroupName]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANG_TRANSFERSLOT, DIALOG_STYLE_INPUT, szTitle, "Please input the player id you wish to transfer slot to.", "Confirm", "Cancel");
				}
				new name[MAX_PLAYER_NAME];
				GetPlayerName(id, name, sizeof(name));
				strcpy(arrGroupData[iGroupID][g_SlotHolder], name, MAX_PLAYER_NAME);
				PlayerInfo[id][pSlotHolder] = iGroupID;
				PlayerInfo[id][pLeader] = iGroupID;
				PlayerInfo[id][pMember] = iGroupID;
				PlayerInfo[id][pRank] = Group_GetMaxRank(iGroupID);
				PlayerInfo[playerid][pSlotHolder] = INVALID_GROUP_ID;
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have transfered the slot to %s.", GetPlayerNameEx(id));
				SendClientMessageEx(id, COLOR_LIGHTBLUE, "* %s has transfered the slot to you, you are now %s slot holder. (Type /help for more information)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName]);
				if(arrGroupData[iGroupID][g_iGroupType] == GROUP_TYPE_CRIMINAL)
				{
					format(string, sizeof(string), "(( Gang News: %s is now the slot holder of %s. ))", GetPlayerNameEx(id), arrGroupData[iGroupID][g_szGroupName]);
					SendClientMessageToAll(COLOR_WHITE, string);
					SendDiscordMessage(4, string);
				}
				return 1;
			}
		}
		case DIALOG_GANG_PURGE: {
			
			if(response && (0 <= PlayerInfo[playerid][pSlotHolder] < MAX_GROUPS)) {
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have purged your gang. All members got kicked whether online or offline.");
				format(string, sizeof(string), "%s has purged %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgang.log", string);
				Gang_PurgeGang(iGroupID);

			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
		case DIALOG_GANG_DISBAND: {

			if(response && (0 <= PlayerInfo[playerid][pSlotHolder] < MAX_GROUPS)) {
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "* You have disbanded your gang, you are now a civilian again.");
				format(string, sizeof(string), "%s has disbanded %s (%d)", GetPlayerNameEx(playerid), arrGroupData[iGroupID][g_szGroupName], iGroupID+1);
				Log("logs/editgang.log", string);
				Gang_DisbandGang(iGroupID);

			}
		}
		case DIALOG_GANGARMSDEALER:
		{
			new dealer = PlayerInfo[playerid][pDealerGang];
		    if(!IsPlayerInRangeOfPoint(playerid, 3.0, arrGroupData[dealer][gArmsX], arrGroupData[dealer][gArmsY], arrGroupData[dealer][gArmsZ])) return 1;


			if(response)
			{
				if(listitem == 0)
			    {
					//new title[256], string[1024];
                    new title[256];
					format(title, sizeof(title), "{%s}%s {FFFFFF}- Arms Dealer (Materials available: %i)", Group_NumToDialogHex(arrGroupData[dealer][g_hDutyColour]), arrGroupData[dealer][g_szGroupName], arrGroupData[PlayerInfo[playerid][pMember]][gArmsMaterials]);
					format(string, sizeof(string), "Weapon\tPrice\tCost\n");
					for(new item; item < sizeof(ArmsDealerItems); item++)
					{
						if(arrGroupData[dealer][gArmsPrices][item] == 0) continue;
						new cost = arrGroupData[dealer][gArmsPrices][item];
						format(string, sizeof(string), "%s%s\t($%s)\t%s materials\n", string, ArmsDealerItems[item], number_format(cost), ArmsDealerCosts[item]);
					}
					ShowPlayerDialogEx(playerid, DIALOG_GANGARMSWEAPONS, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Buy", "Back");
				}
				if(listitem == 1)
				{
					format(string, sizeof(string), "{%s}%s {FFFFFF}- Arms Dealer (Materials available: %i)", Group_NumToDialogHex(arrGroupData[dealer][g_hDutyColour]), arrGroupData[dealer][g_szGroupName], arrGroupData[PlayerInfo[playerid][pMember]][gArmsMaterials]);
					ShowPlayerDialogEx(playerid, DIALOG_GANGARMSEDIT, DIALOG_STYLE_LIST, string, "Edit prices\nDeposit mats\nWithdraw mats", "Select", "Back");
				}
			}
		}
		case DIALOG_GANGARMSWEAPONS:
		{
		    new dealer = PlayerInfo[playerid][pDealerGang];
		    if(!IsPlayerInRangeOfPoint(playerid, 3.0, arrGroupData[dealer][gArmsX], arrGroupData[dealer][gArmsY], arrGroupData[dealer][gArmsZ])) return 1;


			if(response)
			{
				if (strcmp("9mm", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 500) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][0]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 500;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][0];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][0]);
			        GivePlayerValidWeapon(playerid, 22);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a 9mm for $%i.", arrGroupData[dealer][gArmsPrices][0]);
				}
				if (strcmp("Sdpistol", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 1000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][1]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 1000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][1];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][1]);
			        GivePlayerValidWeapon(playerid, 23);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Sdpistol for $%i.", arrGroupData[dealer][gArmsPrices][1]);
				}
				if (strcmp("MP5", inputtext) == 0) {
					if(arrGroupData[dealer][gArmsMaterials] < 2500) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][2]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 2500;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][2];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][2]);
			        GivePlayerValidWeapon(playerid, 29);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a MP5 for $%i.", arrGroupData[dealer][gArmsPrices][2]);
				}
				if (strcmp("Tec-9", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 2500) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][3]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 2500;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][3];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][3]);
			        GivePlayerValidWeapon(playerid, 32);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Tec-9 for $%i.", arrGroupData[dealer][gArmsPrices][3]);
				}
				if (strcmp("Micro Uzi", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 3000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][4]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 3000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][4];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][4]);
			        GivePlayerValidWeapon(playerid, 28);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Micro Uzi for $%i.", arrGroupData[dealer][gArmsPrices][4]);
				}
				if (strcmp("Rifle", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 3000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][5]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 3000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][5];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][5]);
			        GivePlayerValidWeapon(playerid, 33);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Rifle for $%i.", arrGroupData[dealer][gArmsPrices][5]);
				}
				if (strcmp("Shotgun", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 4000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][6]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 4000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][6];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][6]);
			        GivePlayerValidWeapon(playerid, 25);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Shotgun for $%i.", arrGroupData[dealer][gArmsPrices][6]);
				}
				if (strcmp("Desert Eagle", inputtext) == 0) {
					if(arrGroupData[dealer][gArmsMaterials] < 5000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
					if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][7]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
					arrGroupData[dealer][gArmsMaterials] -= 5000;
					arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][7];
					GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][7]);
					GivePlayerValidWeapon(playerid, 24);
					SaveGroup(dealer);
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Deagle for $%i.", arrGroupData[dealer][gArmsPrices][7]);
				}
				if (strcmp("AK-47", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 10000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][8]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 10000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][8];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][8]);
			        GivePlayerValidWeapon(playerid, 30);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a AK-47 for $%i.", arrGroupData[dealer][gArmsPrices][8]);
				}
				if (strcmp("M4A1", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 15000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][9]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 15000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][9];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][9]);
			        GivePlayerValidWeapon(playerid, 31);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a M4A1 for $%i.", arrGroupData[dealer][gArmsPrices][9]);
				}
				if (strcmp("Combat Shotgun", inputtext) == 0) {
			        if(arrGroupData[dealer][gArmsMaterials] < 20000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
			        if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][10]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 20000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][10];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][10]);
			        GivePlayerValidWeapon(playerid, 27);
			        SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Combat Shotgun for $%i.", arrGroupData[dealer][gArmsPrices][10]);
				}
				if (strcmp("Sniper Rifle", inputtext) == 0) {
					if(arrGroupData[dealer][gArmsMaterials] < 30000) return SendClientMessageEx(playerid, COLOR_GREY, "This gang's arms dealer doesn't have enough materials for this weapon.");
					if(PlayerInfo[playerid][pCash] < arrGroupData[dealer][gArmsPrices][11]) return SendClientMessageEx(playerid, COLOR_GREY, "You can't afford to purchase this weapon.");
			        arrGroupData[dealer][gArmsMaterials] -= 30000;
			        arrGroupData[dealer][g_iBudget] += arrGroupData[dealer][gArmsPrices][11];
			        GivePlayerCash(playerid, -arrGroupData[dealer][gArmsPrices][11]);
			        GivePlayerValidWeapon(playerid, 34);
					SaveGroup(dealer);
			        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have purchased a Sniper Rifle for $%i.", arrGroupData[dealer][gArmsPrices][11]);
				}
			}
			else
		    {
				new title[128];
				format(title, sizeof(title), "{%s}%s {FFFFFF}- Arms Dealer", Group_NumToDialogHex(arrGroupData[dealer][g_hDutyColour]), arrGroupData[dealer][g_szGroupName]);
				format(string, sizeof(string), "Buy Guns");
				if(PlayerInfo[playerid][pMember] == dealer && 0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) strcat(string, "\nEdit");
				ShowPlayerDialogEx(playerid, DIALOG_GANGARMSDEALER, DIALOG_STYLE_LIST, title, string, "Select", "Cancel");
			}
		}
		case DIALOG_GANGARMSEDIT:
		{
			new family = PlayerInfo[playerid][pMember], title[256];
		    if(family == INVALID_GROUP_ID || PlayerInfo[playerid][pLeader] < 0) return 1;

			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
					{
						format(string, sizeof(string), "Weapon\tPrice\tCost\n");
						for(new item; item < sizeof(ArmsDealerItems); item++)
						{
							new cost = arrGroupData[family][gArmsPrices][item];
							format(string, sizeof(string), "%s%s\t($%s)\t%s materials\n", string, ArmsDealerItems[item], number_format(cost), ArmsDealerCosts[item]);
						}
						ShowPlayerDialogEx(playerid, DIALOG_GANGARMSPRICES, DIALOG_STYLE_TABLIST_HEADERS, "Choose a weapon to edit price.", string, "Change", "Back");
					}
					case 1:
					{
						format(string, sizeof(string), "How many materials would you like to deposit? (Materials available: %i)", arrGroupData[family][gArmsMaterials]);
						ShowPlayerDialogEx(playerid, DIALOG_GANGARMSDEPOSITMATS, DIALOG_STYLE_INPUT, "Arms Dealer | Deposit Mats", string, "Submit", "Back");

					}
					case 2:
					{
						format(string, sizeof(string), "How many materials would you like to withdraw? (Materials available: %i)", arrGroupData[family][gArmsMaterials]);
						ShowPlayerDialogEx(playerid, DIALOG_GANGARMSWITHDRAWMATS, DIALOG_STYLE_INPUT, "Arms Dealer | Withdraw Mats", string, "Submit", "Back");
					}
			    }
			}
			else
			{
				format(title, sizeof(title), "{%s}%s {FFFFFF}- Arms Dealer", Group_NumToDialogHex(arrGroupData[family][g_hDutyColour]), arrGroupData[family][g_szGroupName]);
				ShowPlayerDialogEx(playerid, DIALOG_GANGARMSDEALER, DIALOG_STYLE_LIST, title, "Buy Guns\nEdit", "Select", "Cancel");
			}
		}
		case DIALOG_GANGARMSPRICES:
		{
			new family = PlayerInfo[playerid][pMember];
		    if(family == INVALID_GROUP_ID || PlayerInfo[playerid][pLeader] < 0) return 1;

		    if(response)
		    {
				SetPVarInt(playerid, "EditingArmsItem", listitem);
		        ShowPlayerDialogEx(playerid, DIALOG_GANGARMSPRICE, DIALOG_STYLE_INPUT, "Arms Dealer | Prices", "Enter the new price for this item:", "Submit", "Back");
		    }
		    else
		    {
		        format(string, sizeof(string), "{%s}%s {FFFFFF}- Arms Dealer (Materials available: %i)", Group_NumToDialogHex(arrGroupData[family][g_hDutyColour]), arrGroupData[family][g_szGroupName], arrGroupData[family][gArmsMaterials]);
				ShowPlayerDialogEx(playerid, DIALOG_GANGARMSEDIT, DIALOG_STYLE_LIST, string, "Edit prices\nDeposit mats\nWithdraw mats", "Select", "Back");
			}
		}
		case DIALOG_GANGARMSDEPOSITMATS:
		{
			new family = PlayerInfo[playerid][pMember];
		    if(family == INVALID_GROUP_ID || PlayerInfo[playerid][pLeader] < 0) return 1;

			if(response)
			{
			    new amount;

			    if(sscanf(inputtext, "i", amount))
			    {
			        format(string, sizeof(string), "How many materials would you like to deposit? (Materials available: %i)", arrGroupData[family][gArmsMaterials]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANGARMSDEPOSITMATS, DIALOG_STYLE_INPUT, "Arms Dealer | Deposit Mats", string, "Submit", "Back");
				}
				if(amount < 1 || amount > PlayerInfo[playerid][pMats])
				{
			        format(string, sizeof(string), "{FF0000}Error: {DDDDDD}Invalid Amount{FFFFFF}\n\nHow many materials would you like to deposit? (Materials available: %i)", arrGroupData[family][gArmsMaterials]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANGARMSDEPOSITMATS, DIALOG_STYLE_INPUT, "Arms Dealer | Deposit Mats", string, "Submit", "Back");
			    }

			    arrGroupData[family][gArmsMaterials] += amount;
			    PlayerInfo[playerid][pMats] -= amount;
				SaveGroup(family);
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have deposited %i materials in your gang arms dealer.", amount);
			}

			format(string, sizeof(string), "{%s}%s {FFFFFF}- Arms Dealer (Materials available: %i)", Group_NumToDialogHex(arrGroupData[family][g_hDutyColour]), arrGroupData[family][g_szGroupName], arrGroupData[family][gArmsMaterials]);
			ShowPlayerDialogEx(playerid, DIALOG_GANGARMSEDIT, DIALOG_STYLE_LIST, string, "Edit prices\nDeposit mats\nWithdraw mats", "Select", "Back");
		}
		case DIALOG_GANGARMSWITHDRAWMATS:
		{
		    new family = PlayerInfo[playerid][pMember];
		    if(family == INVALID_GROUP_ID || PlayerInfo[playerid][pLeader] < 0) return 1;

			if(response)
			{
			    new amount;

			    if(sscanf(inputtext, "i", amount))
			    {
			        format(string, sizeof(string), "How many materials would you like to withdraw? (Materials available: %i)", arrGroupData[family][gArmsMaterials]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANGARMSWITHDRAWMATS, DIALOG_STYLE_INPUT, "Arms Dealer | Withdraw Mats", string, "Submit", "Back");
				}
				if(amount < 1 || amount > arrGroupData[family][gArmsMaterials])
				{
				    format(string, sizeof(string), "{FF0000}Error: {DDDDDD}Invalid Amount{FFFFFF}\n\nHow many materials would you like to withdraw? (Materials available: %i)", arrGroupData[family][gArmsMaterials]);
					return ShowPlayerDialogEx(playerid, DIALOG_GANGARMSWITHDRAWMATS, DIALOG_STYLE_INPUT, "Arms Dealer | Withdraw Mats", string, "Submit", "Back");
			    }

			    arrGroupData[family][gArmsMaterials] -= amount;
			    PlayerInfo[playerid][pMats] += amount;
				SaveGroup(family);
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have withdrawn %i materials from your gang arms dealer.", amount);
			}

			format(string, sizeof(string), "{%s}%s {FFFFFF}- Arms Dealer (Materials available: %i)", Group_NumToDialogHex(arrGroupData[family][g_hDutyColour]), arrGroupData[family][g_szGroupName], arrGroupData[family][gArmsMaterials]);
			ShowPlayerDialogEx(playerid, DIALOG_GANGARMSEDIT, DIALOG_STYLE_LIST, string, "Edit prices\nDeposit mats\nWithdraw mats", "Select", "Back");
		}
		case DIALOG_GANGARMSPRICE:
		{
		    new family = PlayerInfo[playerid][pMember];
		    if(family == INVALID_GROUP_ID || PlayerInfo[playerid][pLeader] < 0)
			{
				DeletePVar(playerid, "EditingArmsItem");
				return 1;
			}
		    if(response)
		    {
		        new amount = strval(inputtext), item = GetPVarInt(playerid, "EditingArmsItem");
		        if(amount < 0) return ShowPlayerDialogEx(playerid, DIALOG_GANGARMSPRICE, DIALOG_STYLE_INPUT, "Arms dealer | Prices", "{FF0000}Error: {DDDDDD}Invalid Amount{FFFFFF}\n\nEnter the new price for this item", "Submit", "Back");


				arrGroupData[family][gArmsPrices][item] = amount;
				SaveGroup(family);
				for(new i; i < sizeof(ArmsDealerItems); i++)
				{
					if(item == i) SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have set the price of %s to $%i.", ArmsDealerItems[i], amount);
				}
		    }
			DeletePVar(playerid, "EditingArmsItem");
			format(string, sizeof(string), "Weapon\tPrice\tCost\n");
			for(new item; item < sizeof(ArmsDealerItems); item++)
			{
				new cost = arrGroupData[family][gArmsPrices][item];
				format(string, sizeof(string), "%s%s\t($%s)\t%s materials\n", string, ArmsDealerItems[item], number_format(cost), ArmsDealerCosts[item]);
			}
			ShowPlayerDialogEx(playerid, DIALOG_GANGARMSPRICES, DIALOG_STYLE_TABLIST_HEADERS, "Choose a weapon to edit price.", string, "Change", "Back");
		}
		case DIALOG_GANG_LOCKERACTION: {

			new
				iLocker = GetPVarInt(playerid, "Gang_EditLocker");

			if(response)
			{
				GetPlayerPos(playerid, arrGroupLockers[iGroupID][iLocker][g_fLockerPos][0], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][1], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][2]);
				arrGroupLockers[iGroupID][iLocker][g_iLockerVW] = GetPlayerVirtualWorld(playerid);
				DestroyDynamic3DTextLabel(arrGroupLockers[iGroupID][iLocker][g_tLocker3DLabel]);
				DestroyDynamicArea(arrGroupLockers[iGroupID][iLocker][g_iLockerAreaID]);
				format(szMiscArray, sizeof szMiscArray, "%s Locker\n{FFFF00}Press {1FBDFF}~k~~CONVERSATION_YES~ {FFFF00} to use\n ID: %i", arrGroupData[iGroupID][g_szGroupName], arrGroupLockers[iGroupID][iLocker]);
				arrGroupLockers[iGroupID][iLocker][g_tLocker3DLabel] = CreateDynamic3DTextLabel(szMiscArray, arrGroupData[iGroupID][g_hDutyColour] * 256 + 0xFF, arrGroupLockers[iGroupID][iLocker][g_fLockerPos][0], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][1], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][2], 15.0, .testlos = 1, .worldid = arrGroupLockers[iGroupID][iLocker][g_iLockerVW]);
				arrGroupLockers[iGroupID][iLocker][g_iLockerAreaID] = CreateDynamicSphere(arrGroupLockers[iGroupID][iLocker][g_fLockerPos][0], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][1], arrGroupLockers[iGroupID][iLocker][g_fLockerPos][2], 3.0, .worldid = arrGroupLockers[iGroupID][iLocker][g_iLockerVW]);

			}
			return Gang_DisplayDialog(playerid, iGroupID);
		}
	}
	return 0;
}
CMD:gangnpc(playerid, params[])
{
	new family = PlayerInfo[playerid][pMember], type, skinid;
	szMiscArray[0] = 0;
	if(family == INVALID_GROUP_ID || !IsACriminal(playerid)) return SendClientMessageEx(playerid, COLOR_GRAD2, " You are not allowed to use this command.");
	//if(PlayerInfo[playerid][pJailTime] > 0 || GetPVarInt(playerid, "IsInArena") >= 0 || GetPVarInt( playerid, "EventToken") != 0 || GetPVarInt(playerid, "Injured") != 0 || PlayerCuffed[playerid] >= 1) return SendClientMessageEx(playerid, COLOR_WHITE, "You cannot do this right now.");
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessageEx(playerid, COLOR_GREY, "You must be on foot to use this command.");
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS)
	{
		if(sscanf(params, "ii", type, skinid))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /gangnpc [type] [skinid]");
			SendClientMessageEx(playerid, COLOR_GREY, "Types: (1) Arms Dealer (2) Drug Dealer");
			return 1;
		}
		if(!(0 <= skinid <= 311)) return SendClientMessageEx(playerid, COLOR_GREY, "Invalid skin specified.");

		if(type == 1)
		{
		    if(!arrGroupData[family][gArmsDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang doesn't have the arms dealer upgrade. (/gangupgrade)");
			if(arrGroupData[family][gArmsX] != 0.0 && arrGroupData[family][gArmsY] != 0.0 && arrGroupData[family][gArmsZ] != 0.0) return SendClientMessageEx(playerid, COLOR_GREY, "Your arms dealer is already placed.");
			GetPlayerPos(playerid, arrGroupData[family][gArmsX], arrGroupData[family][gArmsY], arrGroupData[family][gArmsZ]);
			SetPlayerPos(playerid, arrGroupData[family][gArmsX] + 1.0, arrGroupData[family][gArmsY], arrGroupData[family][gArmsZ] + 1.0);
	        GetPlayerFacingAngle(playerid, arrGroupData[family][gArmsA]);
	        arrGroupData[family][gArmsWorld] = GetPlayerVirtualWorld(playerid);
			arrGroupData[family][gArmsSkin] = skinid;
			SaveGroup(family);
			ReloadGang(family);
	        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have placed the arms dealer for your gang.");
		}
		else if(type == 2)
		{
		    if(!arrGroupData[family][gDrugDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang doesn't have the drug dealer upgrade. (/gangupgrade)");
			if(arrGroupData[family][gDrugX] != 0.0 && arrGroupData[family][gDrugY] != 0.0 && arrGroupData[family][gDrugZ] != 0.0) return SendClientMessageEx(playerid, COLOR_GREY, "Your drug dealer is already placed.");
			GetPlayerPos(playerid, arrGroupData[family][gDrugX], arrGroupData[family][gDrugY], arrGroupData[family][gDrugZ]);
			SetPlayerPos(playerid, arrGroupData[family][gDrugX] + 1.0, arrGroupData[family][gDrugY], arrGroupData[family][gDrugZ] + 1.0);
	        GetPlayerFacingAngle(playerid, arrGroupData[family][gDrugA]);
	        arrGroupData[family][gDrugWorld] = GetPlayerVirtualWorld(playerid);
			arrGroupData[family][gDrugSkin] = skinid;
			SaveGroup(family);
			ReloadGang(family);
	        SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have placed the drug dealer for your gang.");
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "Only group leaders may use this command.");
	return 1;
}
CMD:destroygangnpc(playerid, params[])
{
	new family = PlayerInfo[playerid][pMember], type;
	if(family == INVALID_GROUP_ID || !IsACriminal(playerid)) return SendClientMessageEx(playerid, COLOR_GRAD2, " You are not allowed to use this command.");
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS)
	{
		if(sscanf(params, "i", type))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /destroygangnpc [type]");
			SendClientMessageEx(playerid, COLOR_GREY, "Types: (1) Arms Dealer (2) Drug Dealer");
			return 1;
		}
		if(type == 1)
		{
			if(!arrGroupData[family][gArmsDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang doesn't have the arms dealer upgrade. (/gangupgrade)");
			if(arrGroupData[family][gArmsX] == 0.0 && arrGroupData[family][gArmsY] == 0.0 && arrGroupData[family][gArmsZ] == 0.0) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang arms dealer is already destroyed.");
			if(IsPlayerInRangeOfPoint(playerid, 3.0, arrGroupData[family][gArmsX], arrGroupData[family][gArmsY], arrGroupData[family][gArmsZ]) && GetPlayerVirtualWorld(playerid) == arrGroupData[family][gArmsWorld])
			{
				arrGroupData[family][gArmsX] = 0.0;
				arrGroupData[family][gArmsY] = 0.0;
				arrGroupData[family][gArmsZ] = 0.0;
				arrGroupData[family][gArmsA] = 0.0;
				arrGroupData[family][gArmsWorld] = 0;
				SaveGroup(family);
				ReloadGang(family);
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have destroyed the arms dealer for your gang. (Type /gangnpc to place it again)");
			} else SendClientMessageEx(playerid, COLOR_GREY, "You are not near your gang arms dealer.");
		}
		else if(type == 2)
		{
			if(!arrGroupData[family][gDrugDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang doesn't have the drug dealer upgrade. (/gangupgrade)");
			if(arrGroupData[family][gDrugX] == 0.0 && arrGroupData[family][gDrugY] == 0.0 && arrGroupData[family][gDrugZ] == 0.0) return SendClientMessageEx(playerid, COLOR_GREY, "Your gang drug dealer is already destroyed.");
			if(IsPlayerInRangeOfPoint(playerid, 3.0, arrGroupData[family][gDrugX], arrGroupData[family][gDrugY], arrGroupData[family][gDrugZ]) && GetPlayerVirtualWorld(playerid) == arrGroupData[family][gDrugWorld])
			{
				arrGroupData[family][gDrugX] = 0.0;
				arrGroupData[family][gDrugY] = 0.0;
				arrGroupData[family][gDrugZ] = 0.0;
				arrGroupData[family][gDrugA] = 0.0;
				arrGroupData[family][gDrugWorld] = 0;
				SaveGroup(family);
				ReloadGang(family);
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "You have destroyed the drug dealer for your gang. (Type /gangnpc to place it again)");
			} else SendClientMessageEx(playerid, COLOR_GREY, "You are not near your gang drug dealer.");
		}
	}

	else SendClientMessageEx(playerid, COLOR_GRAD1, "Only group leaders may use this command.");
	return 1;
}


CMD:deletegangnpc(playerid, params[])
{
	new szString[128],
		type,
		iGroupID = PlayerInfo[playerid][pMember];
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pGangModerator] >= 2)
	{
		if(sscanf(params, "i", type)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /deletegangnpc [type] ");
			SendClientMessageEx(playerid, COLOR_GREY, "Types: (1) Arms Dealer (2) Drug Dealer");
			return 1;
		}
		if(type == 1)
		{
			if(!arrGroupData[iGroupID][gArmsDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "This gang doesn't have the arms dealer upgrade.");
			arrGroupData[iGroupID][gArmsDealer] = 0;
			SaveGroup(iGroupID);
			ReloadGang(iGroupID);
			format(szString, sizeof(szString), "** Your gang Arms Dealer npc has been deleted...");
			foreach(new i: Player)
			{
			if(PlayerInfo[i][pMember] == iGroupID)
				{
					SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szString);
				}
			}
		}
		if(type == 2)
		{
			if(!arrGroupData[iGroupID][gDrugDealer]) return SendClientMessageEx(playerid, COLOR_GREY, "This gang doesn't have the drug dealer upgrade.");
			arrGroupData[iGroupID][gDrugDealer] = 0;
			SaveGroup(iGroupID);
			ReloadGang(iGroupID);
			format(szString, sizeof(szString), "** Your gang Drug Dealer npc has been deleted...");
			foreach(new i: Player)
			{
			if(PlayerInfo[i][pMember] == iGroupID)
				{
					SendClientMessageEx(i, arrGroupData[iGroupID][g_hRadioColour] * 256 + 255, szString);
				}
			}
		}

	}
	else return SendClientMessage(playerid, COLOR_GRAD2, "You're not authorized to use this command.");
	return 1;
}
CMD:gangnpchelp(playerid, params[])
{
	SendClientMessageEx(playerid, COLOR_WHITE, "*** GANG NPC *** /armsdealer /drugdealer /gangnpc /destroygangnpc /gangupgrade");
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1 || PlayerInfo[playerid][pGangModerator] >= 2) SendClientMessageEx(playerid, COLOR_WHITE, "Administrator: /deletegangnpc");
	return 1;
}
CMD:armsdealer(playerid, params[])
{
	if(PlayerInfo[playerid][pConnectHours] < 2 || PlayerInfo[playerid][pWRestricted] > 0) return SendClientMessage(playerid, COLOR_GREY, "You are either weapon restricted or you played less than two playing hours.");

	for(new i = 0; i < MAX_GROUPS; i ++)
	{
	    if(arrGroupData[i][gArmsDealer] && IsPlayerInRangeOfPoint(playerid, 3.0, arrGroupData[i][gArmsX], arrGroupData[i][gArmsY], arrGroupData[i][gArmsZ]) && GetPlayerVirtualWorld(playerid) == arrGroupData[i][gArmsWorld])
	    {
			new title[128], string[1024];
	        PlayerInfo[playerid][pDealerGang] = i;
			format(title, sizeof(title), "{%s}%s {FFFFFF}- Arms Dealer", Group_NumToDialogHex(arrGroupData[i][g_hDutyColour]), arrGroupData[i][g_szGroupName]);
			format(string, sizeof(string), "Buy Guns");
			if(PlayerInfo[playerid][pMember] == PlayerInfo[playerid][pDealerGang] && 0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) strcat(string, "\nEdit");
	        ShowPlayerDialogEx(playerid, DIALOG_GANGARMSDEALER, DIALOG_STYLE_LIST, title, string, "Select", "Cancel");
	        return 1;
		}
	}

	SendClientMessageEx(playerid, COLOR_GREY, "You are not in range of any gang owned arms dealers.");
	return 1;
}
CMD:drugdealer(playerid, params[])
{
	for(new i = 0; i < MAX_GROUPS; i ++)
	{
	    if(arrGroupData[i][gDrugDealer] && IsPlayerInRangeOfPoint(playerid, 3.0, arrGroupData[i][gDrugX], arrGroupData[i][gDrugY], arrGroupData[i][gDrugZ]) && GetPlayerVirtualWorld(playerid) == arrGroupData[i][gDrugWorld])
	    {
			new title[128], string[1024];
	        PlayerInfo[playerid][pDealerGang] = i;
			format(title, sizeof(title), "{%s}%s {FFFFFF}- Drug Dealer", Group_NumToDialogHex(arrGroupData[i][g_hDutyColour]), arrGroupData[i][g_szGroupName]);
			format(string, sizeof(string), "Buy Drugs");
			if(PlayerInfo[playerid][pMember] == PlayerInfo[playerid][pDealerGang] && 0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) strcat(string, "\nEdit");
	        ShowPlayerDialogEx(playerid, DIALOG_GANGDRUGDEALER, DIALOG_STYLE_LIST, title, string, "Select", "Cancel");
	        return 1;
		}
	}

	SendClientMessageEx(playerid, COLOR_GREY, "You are not in range of any gang owned drug dealers.");
	return 1;
}
CMD:gangupgrade(playerid, params[])
{
	if(PlayerInfo[playerid][pMember] == INVALID_GROUP_ID || !IsACriminal(playerid)) return SendClientMessageEx(playerid, COLOR_GRAD2, " You are not allowed to use this command.");
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS)
	{
		new
		    title[48],
			string[1024] = "Perk\tDescription\tCost";
		strcat(string, "\nLocker\tAn additional gang locker\t{00AA00} $250,000");
		strcat(string, "\nRank\tAn additional rank and skin\t{00AA00} $100,000");
		strcat(string, "\nDivision\tAn additional division\t{00AA00} $50,000");
		strcat(string, "\nVehicle\tAn additional gang vehicle\t{00AA00} $500,000");
		strcat(string, "\nDrug dealer\tAn NPC which sells individually stocked drugs\t{00AA00} $500,000");
		strcat(string, "\nArms dealer\tAn NPC which sells individually stocked weapons\t{00AA00} $500,000");
	    strcat(string, "\nCustom Mapping\tUp to 50 mapped objects for your gang.\t{00AA00} $1,000,000");
	    strcat(string, "\nCustom Interior\tCustom interior exclusively for your gang.\t{00AA00} $1,000,000");

		format(title, sizeof(title), "Gang upgrades");
		ShowPlayerDialogEx(playerid, DIALOG_GANGPOINTSHOP, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Select", "Cancel");
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "Only group leaders may use this command.");
	return 1;
}
CMD:getgangslot(playerid, params[]) {
	new string[256], iGroupName[GROUP_MAX_NAME_LEN];
	if(!(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS) && !(0 <= PlayerInfo[playerid][pMember] < MAX_GROUPS))
	{
		if(sscanf(params, "s[32]", iGroupName))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /getgangslot [name]");
			SendClientMessageEx(playerid, COLOR_GREY, "You need 5,000,000$ cash in-hand to buy a gang slot.");
			return 1;
		}
		if (GetPlayerCash(playerid) < 5000000) {
		    SendClientMessageEx(playerid, COLOR_GREY, "You don't have that much money.");
		    return 1;
		}
		for(new i = 10; i < 21; i++)
		{
			if(!(arrGroupData[i][g_szGroupName][0]))
			{
				new name[MAX_PLAYER_NAME];
				GetPlayerName(playerid, name, sizeof(name));
				strcpy(arrGroupData[i][g_szGroupName], iGroupName, GROUP_MAX_NAME_LEN);
				strcpy(arrGroupData[i][g_SlotHolder],name, MAX_PLAYER_NAME);
				arrGroupData[i][g_iGroupType] = GROUP_TYPE_CRIMINAL;
				arrGroupData[i][g_iAllegiance] = 0;
				arrGroupData[i][g_iRadioAccess] = 0;
				arrGroupData[i][g_iOOCChat] = 0;
				arrGroupData[i][g_iDeptRadioAccess] = INVALID_RANK;
				arrGroupData[i][g_iIntRadioAccess] = INVALID_RANK;
				arrGroupData[i][g_iBugAccess] = INVALID_RANK;
				arrGroupData[i][g_iFindAccess] = INVALID_RANK;
				arrGroupData[i][g_iGovAccess] = INVALID_RANK;
				arrGroupData[i][g_iTreasuryAccess] = INVALID_RANK;
				arrGroupData[i][g_iFreeNameChange] = INVALID_RANK;
				arrGroupData[i][g_iFreeNameChangeDiv] = INVALID_DIVISION;
				arrGroupData[i][g_iSpikeStrips] = INVALID_RANK;
				arrGroupData[i][g_iBarricades] = INVALID_RANK;
				arrGroupData[i][g_iCones] = INVALID_RANK;
				arrGroupData[i][g_iFlares] = INVALID_RANK;
				arrGroupData[i][g_iBarrels] = INVALID_RANK;
				arrGroupData[i][g_iLadders] = INVALID_RANK;
				arrGroupData[i][g_iTapes] = INVALID_RANK;
				arrGroupData[i][g_iCrateIsland] = INVALID_RANK;
				arrGroupData[i][g_iTackleAccess] = INVALID_RANK;
				arrGroupData[i][g_iWheelClamps] = INVALID_RANK;
				arrGroupData[i][g_iDoCAccess] = INVALID_RANK;
				arrGroupData[i][g_iMedicAccess] = INVALID_DIVISION;
				arrGroupData[i][g_iDMVAccess] = INVALID_RANK;
				arrGroupData[i][gTempNum] = INVALID_RANK;
				arrGroupData[i][gLEOArrest] = INVALID_RANK;
				arrGroupData[i][g_iBudget] = 0;
				arrGroupData[i][g_iBudgetPayment] = 0;
				arrGroupData[i][g_iLockerStock] = 2000;
				arrGroupData[i][g_iLockerCostType] = 0;
				arrGroupData[i][g_iLockerGuns][0] = 5;
				arrGroupData[i][g_iLockerCost][0] = 0;
				arrGroupData[i][g_iLockerGuns][1] = 41;
				arrGroupData[i][g_iLockerCost][1] = 0;
				arrGroupData[i][g_iLockerGuns][2] = 22;
				arrGroupData[i][g_iLockerCost][2] = 10;
				arrGroupData[i][g_iLockerGuns][3] = 23;
				arrGroupData[i][g_iLockerCost][3] = 10;
				arrGroupData[i][g_iLockerGuns][4] = 25;
				arrGroupData[i][g_iLockerCost][4] = 20;
				arrGroupData[i][g_iLockerGuns][5] = 29;
				arrGroupData[i][g_iLockerCost][5] = 20;
				arrGroupData[i][g_iLockerGuns][6] = 24;
				arrGroupData[i][g_iLockerCost][6] = 40;
				arrGroupData[i][g_iLockerGuns][7] = 30;
				arrGroupData[i][g_iLockerCost][7] = 70;
				arrGroupData[i][g_iLockerGuns][8] = 31;
				arrGroupData[i][g_iLockerCost][8] = 100;
				arrGroupData[i][g_iLockerGuns][9] = 27;
				arrGroupData[i][g_iLockerCost][9] = 100;
				arrGroupData[i][g_iLockerGuns][10] = 34;
				arrGroupData[i][g_iLockerCost][10] = 150;
				arrGroupData[i][g_fCratePos][0] = 0;
				arrGroupData[i][g_fCratePos][1] = 0;
				arrGroupData[i][g_fCratePos][2] = 0;
				arrGroupData[i][g_iMemberCount] = 0;
				arrGroupData[i][g_iGroupToyID] = 0;
				arrGroupData[i][g_iMaterials] = 0;
				arrGroupData[i][g_iDrugs][0] = 0;
				arrGroupData[i][g_iDrugs][1] = 0;
				arrGroupData[i][g_iDrugs][2] = 0;
				arrGroupData[i][g_iDrugs][3] = 0;
				arrGroupData[i][g_iDrugs][4] = 0;
				arrGroupData[i][gArmsDealer] = 0;
				arrGroupData[i][gDrugDealer] = 0;
				arrGroupData[i][gArmsX] = 0.0;
				arrGroupData[i][gArmsY] = 0.0;
				arrGroupData[i][gArmsZ] = 0.0;
				arrGroupData[i][gArmsA] = 0.0;
				arrGroupData[i][gDrugX] = 0.0;
				arrGroupData[i][gDrugY] = 0.0;
				arrGroupData[i][gDrugZ] = 0.0;
				arrGroupData[i][gDrugA] = 0.0;
				arrGroupData[i][gArmsWorld] = 0;
				arrGroupData[i][gDrugWorld] = 0;
				arrGroupData[i][gDrugPot] = 0;
				arrGroupData[i][gDrugCrack] = 0;
				arrGroupData[i][gDrugMeth] = 0;
				arrGroupData[i][gDrugEcstasy] = 0;
				arrGroupData[i][gDrugHeroin] = 0;
				arrGroupData[i][gArmsMaterials] = 0;
				for (new x; x < MAX_GROUP_LOCKERS; x++)
				{
					arrGroupLockers[i][x][g_fLockerPos][0] = 0;
					arrGroupLockers[i][x][g_fLockerPos][1] = 0;
					arrGroupLockers[i][x][g_fLockerPos][2] = 0;
					DestroyDynamic3DTextLabel(arrGroupLockers[i][x][g_tLocker3DLabel]);
				}
				for(new x; x < MAX_DYNAMIC_VEHICLES; x++)
				{
					if(DynVehicleInfo[x][gv_igID] != INVALID_GROUP_ID && DynVehicleInfo[x][gv_igID] == i)
					{
						DynVehicleInfo[x][gv_iModel] = 0;
						DynVehicleObjInfo[x][0][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
						DynVehicleObjInfo[x][1][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
						DynVehicleObjInfo[x][2][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
						DynVehicleObjInfo[x][3][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
						DynVehicleInfo[x][gv_igID] = INVALID_GROUP_ID;
						DynVehicleInfo[x][gv_igDivID] = 0;
						DynVehicleInfo[x][gv_fMaxHealth] = 1000;
						DynVehicleInfo[x][gv_iUpkeep] = 0;
						DynVehicleInfo[x][gv_iSiren] = 0;
						DynVeh_Save(x);
						DynVeh_Spawn(x);
					}
				}
				arrGroupData[i][g_iTurfCapRank] = 1;
				arrGroupData[i][g_iPointCapRank] = 1;
				arrGroupData[i][g_iCrimeType] = GROUP_CRIMINAL_TYPE_RACE;
				arrGroupData[i][g_iMemberCount]++;
				mysql_escape_string("RankName", arrGroupRanks[i][0]);
				mysql_escape_string("RankName", arrGroupRanks[i][1]);
				mysql_escape_string("RankName", arrGroupRanks[i][2]);
				mysql_escape_string("RankName", arrGroupRanks[i][3]);
				mysql_escape_string("RankName", arrGroupRanks[i][4]);
				mysql_escape_string("RankName", arrGroupRanks[i][5]);
				mysql_escape_string("RankName", arrGroupRanks[i][6]);
				mysql_escape_string("DivName", arrGroupDivisions[i][0]);
				mysql_escape_string("DivName", arrGroupDivisions[i][1]);
				mysql_escape_string("DivName", arrGroupDivisions[i][2]);
				mysql_escape_string("DivName", arrGroupDivisions[i][3]);
				SaveGroup(i);
				
				PlayerInfo[playerid][pSlotHolder] = i;
				PlayerInfo[playerid][pLeader] = i;
				PlayerInfo[playerid][pMember] = i;
				PlayerInfo[playerid][pRank] = Group_GetMaxRank(i);
				PlayerInfo[playerid][pDivision] = -1;
				GivePlayerCash(playerid, -5000000);
				format(string, sizeof(string), "You paid 5,000,000$ for a gang slot. You are now the Slot Holder of %s. (Type /help for more information)", arrGroupData[i][g_szGroupName]);
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "(( Gang News: %s is now an official gang. ))", arrGroupData[i][g_szGroupName]);
				SendClientMessageToAll(COLOR_WHITE, string);
				SendDiscordMessage(4, string);
				format(string, sizeof(string), "%s (%d) has paid 5m for a gang slot (ID:%d).", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), i);
				GroupLog(i, string);
				return 1;
			}		
		} 
		SendClientMessageEx(playerid, COLOR_GREY, "All gang slots are taken.");		
	}	
	else SendClientMessageEx(playerid, COLOR_GREY, "You are already apart of a group.");
	return 1;
}

CMD:editgang(playerid, params[]) {
	if(0 <= PlayerInfo[playerid][pLeader] < MAX_GROUPS && IsACriminal(playerid))
	{
		Gang_DisplayDialog(playerid, PlayerInfo[playerid][pMember]);
	} else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	return 1;
}
CMD:creategang(playerid, params[]) {
	new string[256], iGroupName[GROUP_MAX_NAME_LEN];
	if (PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pGangModerator] >= 2)
	{
		new giveplayerid;
		if(sscanf(params, "us[32]", giveplayerid, iGroupName))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /creategang [player] [name]");
			return 1;
		}
	
		if(IsPlayerConnected(giveplayerid))	{
			if(!(0 <= PlayerInfo[giveplayerid][pMember] < MAX_GROUPS))
			{
				for(new i = 10; i < 35; i++)
				{
					if(!(arrGroupData[i][g_szGroupName][0]))
					{
						new name[MAX_PLAYER_NAME];
						GetPlayerName(giveplayerid, name, sizeof(name));
						strcpy(arrGroupData[i][g_szGroupName], iGroupName, GROUP_MAX_NAME_LEN);
						strcpy(arrGroupData[i][g_SlotHolder],name, MAX_PLAYER_NAME);
						arrGroupData[i][g_iGroupType] = GROUP_TYPE_CRIMINAL;
						arrGroupData[i][g_iAllegiance] = 0;
						arrGroupData[i][g_iRadioAccess] = 0;
						arrGroupData[i][g_iOOCChat] = 0;
						arrGroupData[i][g_iDeptRadioAccess] = INVALID_RANK;
						arrGroupData[i][g_iIntRadioAccess] = INVALID_RANK;
						arrGroupData[i][g_iBugAccess] = INVALID_RANK;
						arrGroupData[i][g_iFindAccess] = INVALID_RANK;
						arrGroupData[i][g_iGovAccess] = INVALID_RANK;
						arrGroupData[i][g_iTreasuryAccess] = INVALID_RANK;
						arrGroupData[i][g_iFreeNameChange] = INVALID_RANK;
						arrGroupData[i][g_iFreeNameChangeDiv] = INVALID_DIVISION;
						arrGroupData[i][g_iSpikeStrips] = INVALID_RANK;
						arrGroupData[i][g_iBarricades] = INVALID_RANK;
						arrGroupData[i][g_iCones] = INVALID_RANK;
						arrGroupData[i][g_iFlares] = INVALID_RANK;
						arrGroupData[i][g_iBarrels] = INVALID_RANK;
						arrGroupData[i][g_iLadders] = INVALID_RANK;
						arrGroupData[i][g_iTapes] = INVALID_RANK;
						arrGroupData[i][g_iCrateIsland] = INVALID_RANK;
						arrGroupData[i][g_iTackleAccess] = INVALID_RANK;
						arrGroupData[i][g_iWheelClamps] = INVALID_RANK;
						arrGroupData[i][g_iDoCAccess] = INVALID_RANK;
						arrGroupData[i][g_iMedicAccess] = INVALID_DIVISION;
						arrGroupData[i][g_iDMVAccess] = INVALID_RANK;
						arrGroupData[i][gTempNum] = INVALID_RANK;
						arrGroupData[i][gLEOArrest] = INVALID_RANK;
						arrGroupData[i][g_iBudget] = 0;
						arrGroupData[i][g_iBudgetPayment] = 0;
						arrGroupData[i][g_iLockerStock] = 2000;
						arrGroupData[i][g_iLockerCostType] = 0;
						arrGroupData[i][g_iLockerGuns][0] = 5;
						arrGroupData[i][g_iLockerCost][0] = 0;
						arrGroupData[i][g_iLockerGuns][1] = 41;
						arrGroupData[i][g_iLockerCost][1] = 0;
						arrGroupData[i][g_iLockerGuns][2] = 22;
						arrGroupData[i][g_iLockerCost][2] = 10;
						arrGroupData[i][g_iLockerGuns][3] = 23;
						arrGroupData[i][g_iLockerCost][3] = 10;
						arrGroupData[i][g_iLockerGuns][4] = 25;
						arrGroupData[i][g_iLockerCost][4] = 20;
						arrGroupData[i][g_iLockerGuns][5] = 29;
						arrGroupData[i][g_iLockerCost][5] = 20;
						arrGroupData[i][g_iLockerGuns][6] = 24;
						arrGroupData[i][g_iLockerCost][6] = 40;
						arrGroupData[i][g_iLockerGuns][7] = 30;
						arrGroupData[i][g_iLockerCost][7] = 70;
						arrGroupData[i][g_iLockerGuns][8] = 31;
						arrGroupData[i][g_iLockerCost][8] = 100;
						arrGroupData[i][g_iLockerGuns][9] = 27;
						arrGroupData[i][g_iLockerCost][9] = 100;
						arrGroupData[i][g_iLockerGuns][10] = 34;
						arrGroupData[i][g_iLockerCost][10] = 150;
						arrGroupData[i][g_fCratePos][0] = 0;
						arrGroupData[i][g_fCratePos][1] = 0;
						arrGroupData[i][g_fCratePos][2] = 0;
						arrGroupData[i][g_iMemberCount] = 0;
						arrGroupData[i][g_iGroupToyID] = 0;
						arrGroupData[i][g_iMaterials] = 0;
						arrGroupData[i][g_iDrugs][0] = 0;
						arrGroupData[i][g_iDrugs][1] = 0;
						arrGroupData[i][g_iDrugs][2] = 0;
						arrGroupData[i][g_iDrugs][3] = 0;
						arrGroupData[i][g_iDrugs][4] = 0;
						arrGroupData[i][gArmsDealer] = 0;
						arrGroupData[i][gDrugDealer] = 0;
						arrGroupData[i][gArmsX] = 0.0;
						arrGroupData[i][gArmsY] = 0.0;
						arrGroupData[i][gArmsZ] = 0.0;
						arrGroupData[i][gArmsA] = 0.0;
						arrGroupData[i][gDrugX] = 0.0;
						arrGroupData[i][gDrugY] = 0.0;
						arrGroupData[i][gDrugZ] = 0.0;
						arrGroupData[i][gDrugA] = 0.0;
						arrGroupData[i][gArmsWorld] = 0;
						arrGroupData[i][gDrugWorld] = 0;
						arrGroupData[i][gDrugPot] = 0;
						arrGroupData[i][gDrugCrack] = 0;
						arrGroupData[i][gDrugMeth] = 0;
						arrGroupData[i][gDrugEcstasy] = 0;
						arrGroupData[i][gDrugHeroin] = 0;
						arrGroupData[i][gArmsMaterials] = 0;
						arrGroupData[i][g_iCrimeType] = 0;
						for (new x; x < MAX_GROUP_LOCKERS; x++)
						{
							arrGroupLockers[i][x][g_fLockerPos][0] = 0;
							arrGroupLockers[i][x][g_fLockerPos][1] = 0;
							arrGroupLockers[i][x][g_fLockerPos][2] = 0;
							DestroyDynamic3DTextLabel(arrGroupLockers[i][x][g_tLocker3DLabel]);
						}
						for(new x; x < MAX_DYNAMIC_VEHICLES; x++)
						{
							if(DynVehicleInfo[x][gv_igID] != INVALID_GROUP_ID && DynVehicleInfo[x][gv_igID] == i)
							{
								DynVehicleInfo[x][gv_iModel] = 0;
								DynVehicleObjInfo[x][0][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
								DynVehicleObjInfo[x][1][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
								DynVehicleObjInfo[x][2][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
								DynVehicleObjInfo[x][3][gv_iAttachedObjectModel] = INVALID_OBJECT_ID;
								DynVehicleInfo[x][gv_igID] = INVALID_GROUP_ID;
								DynVehicleInfo[x][gv_igDivID] = 0;
								DynVehicleInfo[x][gv_fMaxHealth] = 1000;
								DynVehicleInfo[x][gv_iUpkeep] = 0;
								DynVehicleInfo[x][gv_iSiren] = 0;
								DynVeh_Save(x);
								DynVeh_Spawn(x);
							}
						}
						arrGroupData[i][g_iTurfCapRank] = 1;
						arrGroupData[i][g_iPointCapRank] = 1;
						arrGroupData[i][g_iCrimeType] = GROUP_CRIMINAL_TYPE_RACE;
						arrGroupData[i][g_iMemberCount]++;
						mysql_escape_string("RankName", arrGroupRanks[i][0]);
						mysql_escape_string("RankName", arrGroupRanks[i][1]);
						mysql_escape_string("RankName", arrGroupRanks[i][2]);
						mysql_escape_string("RankName", arrGroupRanks[i][3]);
						mysql_escape_string("RankName", arrGroupRanks[i][4]);
						mysql_escape_string("RankName", arrGroupRanks[i][5]);
						mysql_escape_string("RankName", arrGroupRanks[i][6]);
						mysql_escape_string("DivName", arrGroupDivisions[i][0]);
						mysql_escape_string("DivName", arrGroupDivisions[i][1]);
						mysql_escape_string("DivName", arrGroupDivisions[i][2]);
						mysql_escape_string("DivName", arrGroupDivisions[i][3]);
						SaveGroup(i);
						
						PlayerInfo[giveplayerid][pSlotHolder] = i;
						PlayerInfo[giveplayerid][pLeader] = i;
						PlayerInfo[giveplayerid][pMember] = i;
						PlayerInfo[giveplayerid][pRank] = Group_GetMaxRank(i);
						PlayerInfo[giveplayerid][pDivision] = -1;
						
						format(string, sizeof(string), "(( Gang News: %s is now an official gang. ))", arrGroupData[i][g_szGroupName]);
						SendClientMessageToAll(COLOR_WHITE, string);
						SendDiscordMessage(4, string);
						format(string, sizeof(string), "%s (%d) has created a gang slot (ID:%d) for %s (%d).", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), i, GetPlayerNameEx(giveplayerid), GetPlayerSQLId(giveplayerid));
						GroupLog(i, string);
						return 1;
					}		
				} 
				SendClientMessageEx(playerid, COLOR_GREY, "All gang slots are taken.");	
			} else SendClientMessageEx(playerid, COLOR_GREY, "That player is already in another group.");
		}
		else SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	return 1;
}
CMD:makesh(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pFactionModerator] >= 2)
	{
		new giveplayerid, announce;
		if(sscanf(params, "ui(0)", giveplayerid, announce)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /makesh [player] [announce(0=no / 1=yes)]");
		}
		else {
			if(IsPlayerConnected(giveplayerid))	{
   				SetPVarInt(playerid, "MakingSH", giveplayerid);
   				SetPVarInt(playerid, "MakingSHSQL", GetPlayerSQLId(giveplayerid));
				SetPVarInt(playerid, "MakingSHAnnounce", announce);
				Group_ListGroups(playerid, DIALOG_MAKESLOTHOLDER);
			}
			else SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");

	return 1;
}
CMD:takesh(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pFactionModerator] >= 2)
	{
		new giveplayerid, string[256];
		if(sscanf(params, "u", giveplayerid)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /takesh [player]");
		}
		else {
			if(IsPlayerConnected(giveplayerid))	{
				if(0 <= PlayerInfo[giveplayerid][pSlotHolder] < MAX_GROUPS)
				{
					strcpy(arrGroupData[PlayerInfo[giveplayerid][pMember]][g_SlotHolder], "None", MAX_PLAYER_NAME);
					PlayerInfo[giveplayerid][pSlotHolder] = INVALID_GROUP_ID;
					format(string, sizeof(string), "You have been removed as Slot Holder of  %s by Administrator %s.", arrGroupData[PlayerInfo[giveplayerid][pMember]][g_szGroupName], GetPlayerNameEx(playerid));
					SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "You have taken %s's slot holder perms.", GetPlayerNameEx(giveplayerid));
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Administrator %s has taken %s's slot holder status of the %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid), arrGroupData[PlayerInfo[giveplayerid][pMember]][g_szGroupName]);
					Log("logs/group.log", string);
				}	else SendClientMessageEx(playerid, COLOR_GREY, "That player isn't a slot holder of any group.");
			}
			else SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");

	return 1;
}
CMD:takeleader(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pFactionModerator] >= 2)
	{
		new giveplayerid, string[256];
		if(sscanf(params, "u", giveplayerid)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /takeleader [player]");
		}
		else {
			if(!IsPlayerConnected(giveplayerid)) return SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
			if(0 <= PlayerInfo[giveplayerid][pLeader] < MAX_GROUPS)
			{
				PlayerInfo[giveplayerid][pLeader] = INVALID_GROUP_ID;
				format(string, sizeof(string), "Your leadership has been taken by Administrator %s.", GetPlayerNameEx(playerid));
				SendClientMessageEx(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "You have taken %s's leadership.", GetPlayerNameEx(giveplayerid));
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "Administrator %s has taken %s's leadership of the %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(giveplayerid), arrGroupData[PlayerInfo[giveplayerid][pMember]][g_szGroupName]);
				Log("logs/group.log", string);
			}	else SendClientMessageEx(playerid, COLOR_GREY, "That player isn't a leader of any group.");
		}
	}
	else if (0 <= PlayerInfo[playerid][pSlotHolder] < MAX_GROUPS && PlayerInfo[playerid][pAdmin] < 2 && PlayerInfo[playerid][pMember] == PlayerInfo[playerid][pSlotHolder])
	{
		new takingleader, string[128];
		if(sscanf(params, "u", takingleader)) {
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /takeleader [player]");
		}
		else {
			if(!IsPlayerConnected(takingleader)) return SendClientMessageEx(playerid, COLOR_GREY, "Invalid player specified.");
	    
			if(PlayerInfo[takingleader][pLeader] == PlayerInfo[playerid][pSlotHolder])	{
				PlayerInfo[takingleader][pLeader] = INVALID_GROUP_ID;
				format(string, sizeof(string), "Your leadership has been taken by %s.", GetPlayerNameEx(playerid));
				SendClientMessageEx(takingleader, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "You have taken %s's leadership.", GetPlayerNameEx(takingleader));
				SendClientMessageEx(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "%s has taken %s's leadership of the %s.", GetPlayerNameEx(playerid), GetPlayerNameEx(takingleader), arrGroupData[PlayerInfo[takingleader][pMember]][g_szGroupName]);
				Log("logs/group.log", string);
   			}
			else SendClientMessageEx(playerid, COLOR_GREY, "This player isn't in your group or isn't leader.");
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");

	return 1;
}
