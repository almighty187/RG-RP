#include <YSI\y_hooks>

CMD:polls(playerid, params[])
{
	szMiscArray[0] = 0;
	for(new i; i < MAX_POLLS; i++)
	{
		DeletePVar(playerid, "pVoting");
		if(strfind(PlayerInfo[playerid][pPrisonReason], "Vacant", true) == -1)
		{
			format(szMiscArray, sizeof(szMiscArray), "%s\n%d | %s", szMiscArray, i, Polls[i][PollQuestion]);
		}
	}
	ShowPlayerDialogEx(playerid, DIALOG_POLLS, DIALOG_STYLE_LIST, "RG-RP Polls", szMiscArray, "Select", "Cancel");
	return 1;
}

CMD:editpolls(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1) 
	{
		DeletePVar(playerid, "pEditingPoll");
		szMiscArray[0] = 0;
		for(new i; i < MAX_POLLS; i++)
		{
			format(szMiscArray, sizeof(szMiscArray), "%s\n%d | %s", szMiscArray, i, Polls[i][PollQuestion]);
		}
		ShowPlayerDialogEx(playerid, DIALOG_EDITPOLLS, DIALOG_STYLE_LIST, "RG-RP Polls | Edit", szMiscArray, "Select", "Cancel");
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

	if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;
	switch(dialogid)
	{
		case DIALOG_POLLS:
		{
			switch(listitem)
			{
				case 0 .. MAX_POLLS:
				{
					if(PlayerInfo[playerid][HasVoted][listitem] > 0) return SendClientMessage(playerid, COLOR_WHITE, "You have already voted on this poll!");
					SetPVarInt(playerid, "pVoting", listitem);
					for(new i; i < MAX_POLLS_CHOICES; i++)
					{
						format(szMiscArray, sizeof(szMiscArray), "%s\n%d | %s", szMiscArray, i, PollChoices[listitem][i]);
					}
					ShowPlayerDialogEx(playerid, DIALOG_POLLS_VOTE, DIALOG_STYLE_LIST, "RG-RP Polls | Vote", szMiscArray, "Select", "Cancel");
				}
			}
		}
		case DIALOG_POLLS_VOTE:
		{
			switch(listitem)
			{
				case 0 .. MAX_POLLS_CHOICES:
				{
					PlayerInfo[playerid][HasVoted][GetPVarInt(playerid, "pVoting")] = gettime();

					Polls[GetPVarInt(playerid, "pVoting")][PollVotes][listitem] += 1;
					SavePoll(GetPVarInt(playerid, "pVoting"));
				}
			}
		}
		case DIALOG_EDITPOLLS:
		{
			switch(listitem)
			{
				case 0 .. MAX_POLLS:
				{
					SetPVarInt(playerid, "pEditingPoll", listitem);
					ShowPlayerDialogEx(playerid, DIALOG_EDITPOLLS2, DIALOG_STYLE_LIST, "RG-RP Polls | Edit", "Edit Question\nEdit Choices\nReset Poll", "Select", "Cancel");
				}
			}
		}
		case DIALOG_EDITPOLLS2:
		{
			switch(listitem)
			{
				case 0: ShowPlayerDialogEx(playerid, DIALOG_EDITPOLLS_NAME, DIALOG_STYLE_MSGBOX, "RG-RP Polls | Edit Question", "Please enter the question for the poll below.", "Okay", "Cancel");
				case 1:
				{
					szMiscArray[0] = 0;
					DeletePVar(playerid, "pEditingPollChoice");
					for(new i; i < MAX_POLLS_CHOICES; i++)
					{
						format(szMiscArray, sizeof(szMiscArray), "%s\n%d | %s", szMiscArray, i, PollChoices[GetPVarInt(playerid, "pEditingPoll")][i]);
					}
					ShowPlayerDialogEx(playerid, DIALOG_EDITPOLLS_CHOICES, DIALOG_STYLE_LIST, "RG-RP Polls | Edit Choices", szMiscArray, "Select", "Cancel");
				}
				case 2:
				{
					ResetPoll(GetPVarInt(playerid, "pEditingPoll"));
				}
			}
		}
	}
	return 0;
}

/*CheckPlayerPollStatus(playerid)
{
	for(new i; i < MAX_POLLS; i++) if(PlayerInfo[playerid][HasVoted][i] < Polls[i][LastReset]) PlayerInfo[playerid][HasVoted][i] = 0;
	return 1;
}*/

ResetPoll(id)
{
	format(Polls[id][PollQuestion], 256, "Vacant");
	for(new i; i < MAX_POLLS_CHOICES; i++) format(PollChoices[id][i], 255, "Vacant");

	foreach(new i: Player)
	{
		if(PlayerInfo[i][HasVoted][id] > 0) PlayerInfo[i][HasVoted][id] = 0;
	}

	Polls[id][LastReset] = gettime();
	SavePoll(id);
	return 1;
}

SavePoll(id) 
{
	szMiscArray[0] = 0;
	new mistring[64];
	for(new i; i < MAX_POLLS; i++)
	{
		format(szMiscArray, sizeof szMiscArray, "UPDATE `polls` SET `Question` = '%s'", Polls[id][PollQuestion]);

		for(i = 0; i != MAX_POLLS_CHOICES; ++i) format(szMiscArray, sizeof szMiscArray, "%s, `Choice%d` = '%s'", szMiscArray, i, PollChoices[id][i]);

		for(i = 0; i != MAX_POLLS_CHOICES; ++i) 
		{
			format(mistring, sizeof(mistring), "%s%d", mistring, Polls[id][PollVotes][i]);
			strcat(mistring, "|");
		}
		format(szMiscArray, sizeof szMiscArray, "%s, `Votes` = '%s'", szMiscArray, mistring);
	}

	format(szMiscArray, sizeof szMiscArray, "%s WHERE `id` = %d", szMiscArray, id + 1);
	mysql_tquery(MainPipeline, szMiscArray, false, "OnQueryFinish", "i", SENDDATA_THREAD);
	return 1;
}
