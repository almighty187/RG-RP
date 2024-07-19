////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>

#define JOBSKILLMENU 1
#define JOBSKILLMENU2 2




CMD:skill(playerid, params[]) {
	return ShowPlayerDialogEx(playerid, JOBSKILLMENU, DIALOG_STYLE_LIST, "Job Skills","Detective\nLawyer\nWhore\nDrug Smuggling\nArms Dealer\nCar Mechanic\nBoxer\nFishing\nTrucker\nTreasure Hunter\nLock Picking", "Select", "Cancel");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {

	if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;
	switch(dialogid)
	{
		case JOBSKILLMENU:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: //Detective
					{
						new level = PlayerInfo[playerid][pDetSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Detective Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Detective Skill Level = %s\n\nYou need to find %d more people to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 1: //Lawyer
					{
						new level = PlayerInfo[playerid][pLawSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}

						format(szTitle, sizeof(szTitle), "Lawyer Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Lawyer Skill Level = %s\n\nYou need to free %d more people to level up.", string, remainingNeeded);

						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 2: //Whore
					{
						new level = PlayerInfo[playerid][pSexSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Whore Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Whore Skill Level = %s\n\nYou need to have sex %d times more to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 3: //Drug Smuggling
					{
						new level = PlayerInfo[playerid][pDrugSmuggler];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Drug Smuggling Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Drug Smuggling Skill Level = %s\n\nYou need to successfully smuggle %d more drugs to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 4: //Arms Dealer
					{
						new level = PlayerInfo[playerid][pArmsSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Arms Dealer Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Arms Dealer Skill Level = %s\n\nYou need to sell %d more guns to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 5: //Car Mechanic
					{
						new level = PlayerInfo[playerid][pMechSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Car Mechanic Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Car Mechanic Skill Level = %s\n\nYou need to repair/refill a car for %d times more to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 6: //Boxer
					{
						new level = PlayerInfo[playerid][pBoxSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Boxer Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Boxer Skill Level = %s\n\nYou need to Win %d more Matches to level up.", string, remainingNeeded);

						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 7: //Fishing
					{
						new level = PlayerInfo[playerid][pFishingSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Fishing Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Fishing Skill Level = %s\n\nYou need to successfully fish %d more times to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 8: //Trucker
					{
						new level = PlayerInfo[playerid][pTruckSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Trucker Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Trucker Skill Level = %s\n\nYou need to transport goods %d times to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 9: //Treasure Hunter
					{
						new level = PlayerInfo[playerid][pTreasureSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Treasure Hunter Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Treasure Hunter Skill Level = %s\n\nYou need to find treasure %d times to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					case 10: //Lock Picking
					{
					    new level = PlayerInfo[playerid][pCarLockPickSkill];
						new string[128], szTitle[128], szDialog[512];
						new remainingNeeded;

						if (level >= 0 && level < 50) {
						    format(string, sizeof(string), "1");
						    remainingNeeded = 50 - level;
						} else if (level >= 50 && level < 100) {
						    format(string, sizeof(string), "2");
						    remainingNeeded = 100 - level;
						} else if (level >= 100 && level < 200) {
						    format(string, sizeof(string), "3");
						    remainingNeeded = 200 - level;
						} else if (level >= 200 && level < 400) {
						    format(string, sizeof(string), "4");
						    remainingNeeded = 400 - level;
						} else if (level >= 400) {
						    format(string, sizeof(string), "5");
						    remainingNeeded = 0; // Max level reached
						}
						format(szTitle, sizeof(szTitle), "Lock Picking Skill Level");
						format(szDialog, sizeof(szDialog), "Level: Your Lock Picking Skill Level = %s\n\nYou need to successfully lock pick %d more cars to level up.", string, remainingNeeded);
						ShowPlayerDialogEx(playerid, JOBSKILLMENU2, DIALOG_STYLE_MSGBOX, szTitle, szDialog, "Back", "Close");
					}
					
				}
			}
		}
		case JOBSKILLMENU2:
		{
			if(response)
			{
				ShowPlayerDialogEx(playerid, JOBSKILLMENU, DIALOG_STYLE_LIST, "Job Skills","Detective\nLawyer\nWhore\nDrug Smuggling\nArms Dealer\nCar Mechanic\nBoxer\nFishing\nTrucker\nTreasure Hunter\nLock Picking", "Select", "Cancel");
			}
		}
	}
	return 0;
}
