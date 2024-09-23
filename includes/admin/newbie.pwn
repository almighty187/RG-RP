#include <YSI\y_hooks>

CMD:newb(playerid, params[]) {

	szMiscArray[0] = 0;

	if(PlayerInfo[playerid][pNMute] == 1) return SendClientMessageEx(playerid, COLOR_GREY, "You are muted from the newbie chat channel.");
	if(PlayerInfo[playerid][pToggledChats][0]) return SendClientMessageEx(playerid, COLOR_GREY, "You have the channel toggled, /tog newbie to re-enable!");
	if(PlayerInfo[playerid][pTut] == 0) return SendClientMessageEx(playerid, COLOR_GREY, "You can't do that at this time.");
	if(nonewbie) return SendClientMessageEx(playerid, COLOR_GRAD2, "The newbie chat channel has been disabled by an administrator!");

	if(GetPVarType(playerid, "HasNewbQues")) {
		SendErrorMessage(playerid, "You have already asked a newbie question.");
		return SendServerMessage(playerid, "Type /cancelnewbie to submit a new one!");
	}

	ShowPlayerDialogEx(playerid, SEND_NEWBIE, DIALOG_STYLE_INPUT, "Ask Newbie Question", "Please input your question\nPlease bare in mind only script/server related questions will be answered.", "Send", "Cancel");

	return 1;
}

CMD:cancelnewbie(playerid, params[]) {

	SendServerMessage(playerid, "You have cancelled your request");
	ClearNewbVars(playerid);
	return 1;
}

CMD:newbquestions(playerid, params[]) {

	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] > 0) {
		GetNewbieQuestions(playerid);
	}

	return 1;
}

CMD:an(playerid, params[]) { 
	
	szMiscArray[0] = 0;

	new id;

	if(sscanf(params, "u", id)) return SendSyntaxMessage(playerid, "/an [playerid/PartOfName]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "That player is no longer connected!");
	if(!GetPVarType(id, "HasNewbQues")) return SendErrorMessage(playerid, "That player hasn't asked a newbie question!");
	if(GetPVarType(id, "NewbBeingAnswered")) return SendErrorMessage(playerid, "Another helper is answering that request!");

	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] > 0) {

		SetPVarInt(playerid, "AnsweringNewb", id);
		SetPVarInt(id, "NewbBeingAnswered", playerid);
		GetPVarString(id, "HasNewbQues", szMiscArray, 128);
		format(szMiscArray, sizeof(szMiscArray), "%s (ID:%d) Q: %s\nPlease type in your answer below!", GetPlayerNameEx(id), id, szMiscArray);
		ShowPlayerDialogEx(playerid, ACCEPT_NEWBIE, DIALOG_STYLE_INPUT, "Newbie Answer", szMiscArray, "Answer", "");
	}

	return 1;
}

CMD:tn(playerid, params[]) {
	
	szMiscArray[0] = 0;

	new id;

	if(sscanf(params, "u", id)) return SendSyntaxMessage(playerid, "/tn [playerid/PartOfName]");
	if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "That player is no longer connected!");
	if(!GetPVarType(id, "HasNewbQues")) return SendErrorMessage(playerid, "That player hasn't asked a newbie question!");
	if(GetPVarType(id, "NewbBeingAnswered")) return SendErrorMessage(playerid, "Another helper is answering that request!");


	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pHelper] > 0) {

		SetPVarInt(playerid, "AnsweringNewb", id);
		SetPVarInt(id, "NewbBeingAnswered", playerid);
		GetPVarString(id, "HasNewbQues", szMiscArray, 128);
		
		ShowPlayerDialogEx(playerid, DENY_NEWBIE, DIALOG_STYLE_LIST, "Why is this not a valid request?", "Not a Question\nIC Matter\nSpam", "Select","");
	}

	return 1;
}

SendNewbQuestionToQueue(iPlayerID, szQuestion[]) {

	szMiscArray[0] = 0;

	SetPVarString(iPlayerID, "HasNewbQues", szQuestion);

	format(szMiscArray, sizeof(szMiscArray), "Newb: %s (ID:%d) Q: %s", GetPlayerNameEx(iPlayerID), iPlayerID, szQuestion);

	foreach(new i : Player) {
		if((PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pHelper] > 0))
			
			ChatTrafficProcess(i, COLOR_NEWBIE, szMiscArray, 0);
	}

	SendServerMessage(iPlayerID, "Your question was submitted");

	return 1;
}

ClearNewbVars(iPlayerID) {
	
	DeletePVar(iPlayerID, "HasNewbQues");
	DeletePVar(GetPVarInt(iPlayerID, "NewbBeingAnswered"), "AnsweringNewb");
	DeletePVar(iPlayerID, "NewbBeingAnswered");

	return 1;
}

AnswerNewbie(iPlayerID, iNewbieID, szAnswer[]) {

	szMiscArray[0] = 0;

	if(!GetPVarType(iNewbieID, "HasNewbQues")) return SendErrorMessage(iPlayerID, "That player does not have an active question!");

	GetPVarString(iNewbieID, "HasNewbQues", szMiscArray, 128);

	format(szMiscArray, sizeof(szMiscArray), "Q: (%s): %s", GetPlayerNameEx(iNewbieID), szMiscArray);
	SendGlobalNewbMsg(szMiscArray);
	Log("logs/newbiechat.log", szMiscArray);

	szMiscArray[0] = 0;

	format(szMiscArray, sizeof(szMiscArray), "A: (%s): %s", GetPlayerNameEx(iPlayerID), szAnswer);
	SendGlobalNewbMsg(szMiscArray);
	Log("logs/newbiechat.log", szMiscArray);

	if(PlayerInfo[iPlayerID][pHelper] == 1 && PlayerInfo[iPlayerID][pAdmin] < 1) {
		ReportCount[iPlayerID]++;
		ReportHourCount[iPlayerID]++;
		AddCAReportToken(iPlayerID); // Advisor Tokens
	}

	SendServerMessage(iNewbieID, "Your question has been answered! If you have more questions or for additional assistance use [/requesthelp]");

	ClearNewbVars(iNewbieID);

	return 1;
}

SendGlobalNewbMsg(szMessage[]) {
	
	foreach(new i : Player) {
		if(PlayerInfo[i][pToggledChats][0] == 0) {
			SendClientMessageEx(i, COLOR_NEWBIE, szMessage);
		}
	}
	return 1;
}

GetNewbieQuestions(iPlayerID) {
	
	szMiscArray[0] = 0;

	SendClientMessageEx(iPlayerID, COLOR_GREEN,"_______________________________________");
	foreach(new i : Player) {
		if(GetPVarType(i, "HasNewbQues")) {
			GetPVarString(i, "HasNewbQues", szMiscArray, 128);
			format(szMiscArray, sizeof(szMiscArray), "Newb: %s (ID:%d) Q: %s", GetPlayerNameEx(i), i, szMiscArray);
			SendClientMessageEx(iPlayerID, COLOR_NEWBIE, szMiscArray);
		}
	}
	SendClientMessageEx(iPlayerID, COLOR_GREEN,"_______________________________________");
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

	if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;
	switch(dialogid) {
		
		case SEND_NEWBIE: {

			if(response) {
				
				if(isnull(inputtext)) return SendErrorMessage(playerid, "You cannot send no question!");
				if(strlen(inputtext) > 110) return SendErrorMessage(playerid, "That message is too long!");

				SendNewbQuestionToQueue(playerid, inputtext);
			}
		}

		case ACCEPT_NEWBIE: {

			if(response) {
				if(isnull(inputtext)) return SendErrorMessage(playerid, "You cannot send no question!");
				if(strlen(inputtext) > 110) {
					DeletePVar(GetPVarInt(playerid, "AnsweringNewb"), "NewbBeingAnswered");
					DeletePVar(playerid, "AnsweringNewb");
					return SendErrorMessage(playerid, "That message is too long!");
				}

				AnswerNewbie(playerid, GetPVarInt(playerid, "AnsweringNewb"), inputtext);
			}
			else {
				
				DeletePVar(GetPVarInt(playerid, "AnsweringNewb"), "NewbBeingAnswered");
				DeletePVar(playerid, "AnsweringNewb");
			}
		}

		case DENY_NEWBIE: {

			if(response) {	
				new id = GetPVarInt(playerid, "AnsweringNewb");

				switch(listitem) {
				
					case 0: {
						SendServerMessage(id, "Your newbie message has not been answered due to it not being considered a question.");
					}

					case 1: {
						SendServerMessage(id, "Your newbie message has not been answered due to it being considered an IC matter.");
						SendServerMessage(id, "We may only answer script/server related questions on /newb.");
					}

					case 2: {
						SendServerMessage(id, "Your newbie message has not been answered due to it being considered spam.");
						SendServerMessage(id, "Repeated abuse will result in a mute and/or further punishment.");
					}

				}

				ClearNewbVars(id);	
			}
			else {
				
				DeletePVar(GetPVarInt(playerid, "AnsweringNewb"), "NewbBeingAnswered");
				DeletePVar(playerid, "AnsweringNewb");
			}
			
		}
	}
	return 0;
}

hook OnPlayerDisconnect(playerid, reason) {

	// cancel newbie report if they have one
	ClearNewbVars(playerid);

	return 1;
}
