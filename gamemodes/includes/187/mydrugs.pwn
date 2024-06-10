////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by 187    /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
CMD:mydrugs(playerid, params[])
{
    new string[450];
    new dialogText[600];
    new header[128];

    if(IsPlayerConnected(playerid))
    {
        format(header, sizeof(header), "%s's Drug Inventory", GetPlayerNameEx(playerid));
                
        for(new i; i < sizeof(Drugs); i++) 
        {
            format(string, sizeof(string), "{FFFFFF}%s: %dg\n", Drugs[i], PlayerInfo[playerid][pDrugs][i]);
            strcat(dialogText, string);
        }
        
        format(string, sizeof(string), "{FFFFFF}Pot Seeds: %d\nOpium Seeds: %d\nSyringes: %d\n", PlayerInfo[playerid][pWSeeds], PlayerInfo[playerid][pOpiumSeeds], PlayerInfo[playerid][pSyringes]);
        strcat(dialogText, string);

        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, header, dialogText, "Close", "");
    }
    return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if(arrAntiCheat[playerid][ac_iFlags][AC_DIALOGSPOOFING] > 0) return 1;
    
   	switch (dialogid)
	{
 		case 1:
 		{
            if (response)
			{
            	return 1;
  			}
        }
    }
    return 1;
}
