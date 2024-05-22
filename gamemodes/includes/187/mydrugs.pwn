CMD:mydrugs(playerid, params[])
{
    new string[450];
    new dialogText[600];
    new header[128];
    new targetid = playerid;

    if(IsPlayerConnected(targetid))
    {
        format(header, sizeof(header), "%s's Drug Inventory", GetPlayerNameEx(targetid));
                
        for(new i; i < sizeof(Drugs); i++) 
        {
            format(string, sizeof(string), "{FFFFFF}%s: %dg\n", Drugs[i], PlayerInfo[targetid][pDrugs][i]);
            strcat(dialogText, string);
        }
        
        format(string, sizeof(string), "{FFFFFF}Pot Seeds: %d\nOpium Seeds: %d\nSyringes: %d\n", PlayerInfo[targetid][pWSeeds], PlayerInfo[targetid][pOpiumSeeds], PlayerInfo[targetid][pSyringes]);
        strcat(dialogText, string);

        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_MSGBOX, header, dialogText, "Close", "");
    }
    return 1;
}
