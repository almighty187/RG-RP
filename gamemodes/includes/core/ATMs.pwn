#include <YSI\y_hooks>

#define ATM					10000
#define ATM_AMOUNT 			10001
#define ATM_TRANSFER_TO		10002
#define ATM_TRANSFER_AMT	10003


new Float:ATMs[16][4] = {
{2065.3232, -1897.6429, 13.2686, 0.0000},
{2160.9404, -1733.0797, 13.1687, 358.4479}, // Idlewood gas station
{1901.7501, -1786.7529, 13.1021, 90.3382}, // Idlewood burger shot
{2398.5542, -1548.6835, 23.8189, 179.4480}, // East ls
{2308.4949, -1638.7850, 14.4486, 269.5833}, // Ganton bar
{1847.3932, -1860.3418, 13.2133, 0.0000},
{1520.4270, -1561.2681, 13.3513, 359.3913},
{1172.5966, -1318.8878, 15.0261, 0.0000}, // All sints hopsital
{1066.5370, -1026.4215, 31.7410, 0.0000}, // ModShop
{1001.2426, -925.1960, 41.9741, 277.9713},
{1319.5170, -897.7850, 39.2214, 0.0000}, // Robois food mart
{2333.6199, -1319.7637, 23.7986, 89.3152}, // Gas Station Easy L.S
{661.3817, -576.5142, 15.9848,269.9492}, // Blueberry
{2194.8999023,1982.8000488,11.8999996,270.0000000}, // LV
{0.0, 0.0, 0.0, 0.0}, // Empty
{0.0, 0.0, 0.0, 0.0} // Empty
};

hook OnGameModeInit() {


	for(new h = 0; h < sizeof(ATMs); h++)
	{
        //CreateDynamicObject(2942, ATMs[h][0], ATMs[h][1], ATMs[h][2]+0.5, 0.000000, 0.000000, ATMs[h][3], 0);
        CreateDynamicObject(2942, ATMs[h][0], ATMs[h][1], ATMs[h][2], 0.000000, 0.000000, ATMs[h][3], 0);
        CreateDynamicMapIcon(ATMs[h][0], ATMs[h][1], ATMs[h][2], 52, COLOR_YELLOW);
        CreateDynamic3DTextLabel("ATM\n{DDDDDD}Press ~k~~CONVERSATION_YES~ to access atm", COLOR_GREEN, ATMs[h][0], ATMs[h][1], ATMs[h][2]+1.3, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, 80.0);
        CreateDynamicSphere(ATMs[h][0], ATMs[h][1], ATMs[h][2], 3.0);
        print("[Streamer] ATM Points Loaded");
	}
	return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {

	if((newkeys & KEY_YES))
	{
	    for(new i = 0; i < sizeof(ATMs); ++i) {
	        // Check if the player is near an ATM
	        if (IsPlayerInRangeOfPoint(playerid, 1.0, ATMs[i][0], ATMs[i][1], ATMs[i][2])) {
	       	 	ApplyAnimation(playerid, "ped", "ATM", 12.17, 0, 0, 0, 1, 0);
         		format(szMiscArray, sizeof(szMiscArray), "{FF8000}** {C2A2DA}%s approaches the ATM, typing in their PIN.", GetPlayerNameEx(playerid));
	            SetPlayerChatBubble(playerid, szMiscArray, COLOR_PURPLE, 15.0, 5000);
	            ShowATMMenu(playerid);
	            return 1; // Exit the function once we found a matching ATM
         	}
        }
    }
	return 0;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

	if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;
	switch(dialogid) {

		case ATM: {
			
			if(!response) {
				TogglePlayerControllable(playerid, 1);
				return 1;
			}

			//TogglePlayerControllable(playerid, 0);

			switch(listitem) {		
				case 0: ShowATMMenu(playerid, 1);
				case 1: ShowATMMenu(playerid, 2);
				case 2: ShowATMMenu(playerid, 3);
			}
		}

		case ATM_AMOUNT: {
			if(!response) {
				DeletePVar(playerid, "ATMWithdraw");
				DeletePVar(playerid, "ATMDeposit");
				return ShowATMMenu(playerid);
			}

			new 
				iAmount = strval(inputtext);

			if(GetPVarType(playerid, "ATMWithdraw")) {
				
				if(iAmount < 1) {
					SendErrorMessage(playerid, "Negative amounts cannot be transfered!");
					return ShowATMMenu(playerid, 1);
				}

				if(iAmount > PlayerInfo[playerid][pAccount]) {
					SendErrorMessage(playerid, "You are trying to withdraw more than you have!");
					return ShowATMMenu(playerid, 1);
				}

				if(gettime()-GetPVarInt(playerid, "LastTransaction") < 10) {
					SendErrorMessage(playerid, "You can only make a transaction once every 10 seconds, please wait!");
					return ShowATMMenu(playerid, 1);
				}
				SetPVarInt(playerid, "LastTransaction", gettime());
				
				if(!Bank_TransferCheck(-iAmount)) return 1;
				GivePlayerCash(playerid, iAmount);
				PlayerInfo[playerid][pAccount] -= iAmount; 
				format(szMiscArray, sizeof(szMiscArray), "You have withdrawn $%s from your account. ", number_format(iAmount));
				SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);

				if(PlayerInfo[playerid][pDonateRank] == 0) {
					new fee;
					fee = 3*iAmount/100;
					if(!Bank_TransferCheck(-fee)) return 1;
					PlayerInfo[playerid][pAccount] -= fee;
					format(szMiscArray, sizeof(szMiscArray), "You have been charged a 3 percent withdraw fee: -$%d.", fee);
					SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
				}

				OnPlayerStatsUpdate(playerid);

				DeletePVar(playerid, "ATMWithdraw");

				return ShowATMMenu(playerid);
			}
			else if(GetPVarType(playerid, "ATMDeposit")) {

				if(iAmount < 1) {
					SendErrorMessage(playerid, "Negative amounts cannot be transfered!");
					return ShowATMMenu(playerid, 2);
				}

				if(iAmount > GetPlayerCash(playerid)) {
					SendErrorMessage(playerid, " You are trying to deposit more than you have!");
					return ShowATMMenu(playerid, 2);
				}

				if(gettime()-GetPVarInt(playerid, "LastTransaction") < 10) {
					SendErrorMessage(playerid, "You can only make a transaction once every 10 seconds, please wait!");
					return ShowATMMenu(playerid, 2);
				}
				SetPVarInt(playerid, "LastTransaction", gettime());
				
				if(!Bank_TransferCheck(iAmount)) return 1;
				GivePlayerCash(playerid, -iAmount);
				PlayerInfo[playerid][pAccount] += iAmount; 
				format(szMiscArray, sizeof(szMiscArray), "You have deposited $%s to your account. ", number_format(iAmount));
				SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);

				if(PlayerInfo[playerid][pDonateRank] == 0) {
					new fee;
					fee = 3*iAmount/100;
					if(!Bank_TransferCheck(-fee)) return 1;
					PlayerInfo[playerid][pAccount] -= fee;
					format(szMiscArray, sizeof(szMiscArray), "You have been charged a 3 percent deposit fee: -$%d.", fee);
					SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
				}

				OnPlayerStatsUpdate(playerid);

				DeletePVar(playerid, "ATMDeposit");

				return ShowATMMenu(playerid);
			}
		}

		case ATM_TRANSFER_TO: {
			
			if(!response) {
				return ShowATMMenu(playerid);
			}

			new id = strval(inputtext);
			
			if(!IsPlayerConnected(id) || !gPlayerLogged{id}) {
				SendErrorMessage(playerid, "The player you are trying to transfer to is not connected!");
				return ShowATMMenu(playerid, 3);
			}

			SetPVarInt(playerid, "ATMTransferTo", id);
			return ShowATMMenu(playerid, 4);
		}

		case ATM_TRANSFER_AMT: {

			if(!response) {
				DeletePVar(playerid, "ATMTransferTo");
				return ShowATMMenu(playerid, 3);
			}

			new 
				id = GetPVarInt(playerid, "ATMTransferTo"),
				iAmount = strval(inputtext);


			if(restarting) {
				SendErrorMessage(playerid, "Transactions are currently disabled due to the server being restarted for maintenance.");
				return ShowATMMenu(playerid, 3);
			}
			if(PlayerInfo[playerid][pLevel] < 3) {
				SendErrorMessage(playerid, "You must be at least level 3 to use this feature!");
				return ShowATMMenu(playerid, 3);
			}
			if(gettime()-GetPVarInt(playerid, "LastTransaction") < 10) {
				SendErrorMessage(playerid, "You can only make a transaction once every 10 seconds, please wait!");
				return ShowATMMenu(playerid, 3);
			}

			if(iAmount > PlayerInfo[playerid][pAccount] || iAmount < 0) return SendClientMessageEx(playerid, COLOR_WHITE, "You are trying to send more than you have!");

			if(PlayerInfo[playerid][pDonateRank] == 0) {
				new fee;
				fee = 3*iAmount/100;
				PlayerInfo[playerid][pAccount] -= fee;
				format(szMiscArray, sizeof(szMiscArray), "You have been charged a 3 percent transfer fee: -$%d.", fee);
				SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
			}

			// Use these as they update the MySQL Directly with less function calls
			GivePlayerCashEx(playerid, TYPE_BANK, -iAmount);
			GivePlayerCashEx(id, TYPE_BANK, iAmount);

			format(szMiscArray, sizeof(szMiscArray), "You have transferred $%s to %s's account.", number_format(iAmount), GetPlayerNameEx(id));
			SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
			
			format(szMiscArray, sizeof(szMiscArray), "$%s has been transferred to your bank account from %s.", number_format(iAmount), GetPlayerNameEx(playerid));
			SendClientMessageEx(id, COLOR_WHITE, szMiscArray);

			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			PlayerPlaySound(id, 1052, 0.0, 0.0, 0.0);
				
				
			new ip[32], ipex[32];
			GetPlayerIp(playerid, ip, sizeof(ip));
			GetPlayerIp(id, ipex, sizeof(ipex));
			format(szMiscArray, sizeof(szMiscArray), "[ATM] %s(%d) (IP:%s) has transferred $%s to %s(%d) (IP:%s).", GetPlayerNameEx(playerid), GetPlayerSQLId(playerid), ip, number_format(iAmount), GetPlayerNameEx(id), GetPlayerSQLId(id), ipex);
			if(PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[id][pAdmin] >= 2) Log("logs/adminpay.log", szMiscArray); else Log("logs/pay.log", szMiscArray);
			format(szMiscArray, sizeof(szMiscArray), "[ATM] %s (IP:%s) has transferred $%s to %s (IP:%s).", GetPlayerNameEx(playerid), ip, number_format(iAmount), GetPlayerNameEx(id), ipex);
			

			if(PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[id][pAdmin] >= 2) {
				format(szMiscArray, sizeof(szMiscArray), "[ATM] Admin %s has transferred $%s to %s", GetPlayerNameEx(playerid), number_format(iAmount), GetPlayerNameEx(id));
				if(!strcmp(GetPlayerIpEx(playerid),  GetPlayerIpEx(id), true)) strcat(szMiscArray, " (1)");
				ABroadCast(COLOR_WHITE,szMiscArray, 4);
			}
			else ABroadCast(COLOR_WHITE,szMiscArray,2);
			
			SetPVarInt(playerid, "LastTransaction", gettime());
			DeletePVar(playerid, "ATMTransferTo");

			return ShowATMMenu(playerid);
		}
	}
	return 0;
}


forward ForgetATM(playerid);
public ForgetATM(playerid) {
	DeletePVar(playerid, "AtATM");
	return 1;
}

ShowATMMenu(playerid, menu = 0) {

	new szTitle[48];

	szMiscArray[0] = 0;

	format(szTitle, sizeof(szTitle), "ATM Menu ($%s)", number_format(PlayerInfo[playerid][pAccount]));

	if(PlayerInfo[playerid][pFreezeBank] == 1) return ShowPlayerDialogEx(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, szTitle, "Your assets have been frozen! Contact judicial!", "Ok", "");

	switch(menu) {

		case 0: { // main menu
			ShowPlayerDialogEx(playerid, ATM, DIALOG_STYLE_LIST, szTitle, "Withdraw\nDeposit\nTransfer", "Select", "Cancel");
		}

		case 1: { // iAmount withdraw
			ShowPlayerDialogEx(playerid, ATM_AMOUNT, DIALOG_STYLE_INPUT, szTitle, "Please input how much you wish to withdraw from your account.", "Withdraw", "Cancel");
			SetPVarInt(playerid, "ATMWithdraw", 1);
		}

		case 2: { // iAmount deposit
			ShowPlayerDialogEx(playerid, ATM_AMOUNT, DIALOG_STYLE_INPUT, szTitle, "Please input how much you wish to deposit to your account.", "Deposit", "Cancel");
			SetPVarInt(playerid, "ATMDeposit", 1);
		}

		case 3: { // transfer to
			ShowPlayerDialogEx(playerid, ATM_TRANSFER_TO, DIALOG_STYLE_INPUT, szTitle, "Please input the player id you wish to transfer money to.", "Next", "Cancel");
		}

		case 4: { // transfer iAmount
			format(szMiscArray, sizeof(szMiscArray), "Please input the amount you wish to transfer to {FF0000}%s", GetPlayerNameEx(GetPVarInt(playerid, "ATMTransferTo")));
			ShowPlayerDialogEx(playerid, ATM_TRANSFER_AMT, DIALOG_STYLE_INPUT, szTitle, szMiscArray, "Transfer", "Cancel");
		}
	}

	return 1;
}
