////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>


hook OnPlayerText(playerid, text[])
{
    if(GetPVarInt(playerid, "PlayerCuffed") == 0)
	{
		if(PlayerInfo[playerid][pAnimUse] != 1)
		{
			switch(GetPVarInt(playerid, "ChatStyle"))
			{
				case 0: ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0); 
				case 1: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkA", 3.1,0,1,1,1,1,1);
				case 2: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkB", 3.1,0,1,1,1,1,1); 
				case 3: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkC", 3.1,0,1,1,1,1,1);
				case 4: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkD", 3.1,0,1,1,1,1,1); 
				case 5: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkE", 3.1,0,1,1,1,1,1);
				case 7: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkG", 3.1,0,1,1,1,1,1); 
				case 8: ApplyAnimation(playerid, "GANGS", "prtial_gngtlkH", 3.1,0,1,1,1,1,1);
			}
			new time=strlen(text)*100;
      		SetTimerEx("StopTalking",time,0,"i",playerid);
		}
	}

	return 1;
}

forward StopTalking(playerid);
public StopTalking(playerid) return ApplyAnimation(playerid, "CARRY", "crry_prtial", 2.0, 0, 0, 0, 0, 0);

CMD:chatstyle(playerid, params[])
{
	new aimid;
	if(sscanf(params, "i", aimid)) SendClientMessage(playerid, COLOR_GREY, "USAGE: /chatstyle [0-8]");
	else
	{
	    if(gPlayerLogged{playerid} == 0) return SendClientMessage(playerid, COLOR_WHITE, "You must be logged in to use this.");
	    if(GetPVarInt(playerid, "Injured") > 0) return SendClientMessage(playerid, COLOR_WHITE, "You are not able to use this !");
        if(PlayerInfo[playerid][pMuted] == 1) return SendClientMessage(playerid, COLOR_WHITE, "You are not able to use this !");
        if(GetPVarInt(playerid, "PlayerCuffed") != 0) return SendClientMessage(playerid, COLOR_WHITE, "You are not able to use this !");
		switch(aimid)
		{
		    case 0:
		    {
		        DeletePVar(playerid,"ChatStyle");
		        SendClientMessage(playerid,COLOR_WHITE,"Chatstyle removed.");
		    }
            case 1 .. 8:
            {
                SetPVarInt(playerid, "ChatStyle", aimid);
		        SendClientMessage(playerid,COLOR_WHITE,"Chatstyle set.");
            }
            default: SendClientMessage(playerid, COLOR_GREY, "USAGE: /chatstyle [0-8]");
		}
	}
	return 1;
}
