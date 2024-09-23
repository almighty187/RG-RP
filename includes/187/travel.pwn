define DIALOG_TRAVEL 1001

public OnDialogReponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid = DIALOG_TRAVEL)
	{
		if(response)
		{
			if(listitem == 0) // San Andreas
			{
			    SetPlayerPos(playerid, 1685.7559, -2241.0652, 13.5469);
			}
			else if(listitem == 1) // Tierra Robada
			{
			    SetPlayerPos(playerid, -2253.1401, 2347.0371 ,4.9743);
			}
			return 1;
		}
		else
		{
			// close
		}
	}
	return 1;
}

cmd:travel(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_TRAVEL, DIALOG_STYLE_LIST, "Where do you want to travel?", "San Andreas\n Tierra Robada", "Travel", "Close");
	return 1;
}