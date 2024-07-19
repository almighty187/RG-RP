/*
If a vending machine says "you are not at a candy/spunk vending machine" when pressing F and the animation starts, you need to add it's coordinate.
Vending Machine coordinates are located in callbacks.inc at like 216. You also need to specify if it's a Candy or Sprunk machine. Make sure to update callbacks.inc on Github when updating.
*/

public OnPlayerUseVending(playerid, type) {
    if (!IsPlayerNearVending(playerid, type)) {
  	 	ClearAnimationsEx(playerid);
    	return SendClientMessageEx(playerid, COLOR_GRAD1, "You're not near a %s machine!", (type == 1) ? ("Sprunk") : ("Candy"));
    	 
	}
    new Float:health;
    GetHealth(playerid, health);
    if(gettime() - LastShot[playerid] < 60) return SendClientMessageEx(playerid, COLOR_GRAD2, "You have been injured within the last 60 seconds, you cannot use the vending machine");
  	if((PlayerInfo[playerid][pConnectHours] > 5 && GetPlayerCash(playerid) < 5)) return SendClientMessageEx(playerid, COLOR_GRAD1, "You need at least $5 to buy %s!", (type == 1) ? ("a Sprunk") : ("some Candy")), ClearAnimationsEx(playerid);
    if((PlayerInfo[playerid][pConnectHours] < 5 && GetPlayerCash(playerid) < 3)) return SendClientMessageEx(playerid, COLOR_GRAD1, "You need at least $3 to buy %s!", (type == 1) ? ("a Sprunk") : ("some Candy")), ClearAnimationsEx(playerid);
	if(GetPVarInt(playerid, "VendingUse") != 0) return 1;
	if(health >= 99) {
		return SendClientMessage(playerid,COLOR_GREY, "Health is full!");
	}
	GameTextForPlayer(playerid, "~r~-$3.", 5000, 1);
 	ApplyAnimation(playerid, "VENDING", "VEND_Use", 3.0, 0, 0, 0, 0, 1);
  	PlayAudioStreamForPlayerEx(playerid, "http://media.rg-rp.org/Soundeffects/Vending.wav");
  	health+=40.0;
   	if(health >= 100.0) health=99.0;
    SetHealth(playerid, health);
    SetPVarInt(playerid, "VendingUse", 1);
  	SetTimerEx("SprunkTimer", 3000, false, "i", playerid); 
    if((PlayerInfo[playerid][pConnectHours] > 5)) {
    	SendClientMessageEx(playerid, COLOR_GRAD1, "You paid $5 for %s!", (type == 1) ? ("a Sprunk") : ("some Candy"));
    	GivePlayerCash(playerid, -5);
    }
    if((PlayerInfo[playerid][pConnectHours] < 5)) {
    	SendClientMessageEx(playerid, COLOR_GRAD1, "You paid $3 for %s!", (type == 1) ? ("a Sprunk") : ("some Candy"));
    	GivePlayerCash(playerid, -3);
    }
    return 1;
}  


forward SprunkTimer(playerid);
public SprunkTimer(playerid)
{
    if (!IsPlayerAttachedObjectSlotUsed(playerid, 4))
	{
		SetPlayerAttachedObject(playerid, 4, 1546, 5, 0.106, 0.055 ,-0.033 ,13 ,3.6 ,-69.9, 1, 1, 1);
		SetTimerEx("RemoveAttachedObject", 2500, false, "dd", playerid, 4);
	}
    ApplyAnimation(playerid, "VENDING", "VEND_Drink2_P", 3.0, 0, 0, 0, 0, 0);
    SetPlayerSpecialAction(playerid, 0); // Clear sprunk can.
    return DeletePVar(playerid,"VendingUse");
}
