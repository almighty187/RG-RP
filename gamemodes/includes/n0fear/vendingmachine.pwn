////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>



//============================================//
new Float:Vending[30][4] = {
{5312.4751,-4037.6917,1099.9078,357.3655},
{1392.1689,-37.4026,1000.9190,268.8610},
{1153.9084,-1461.1725,15.7969,269.3753},
{2224.4072,-1153.7219,1025.7969,268.8720},
{-16.3888,-90.8459,1003.5469,183.6595},
{495.7409,-23.5278,1000.6797,184.0095},
{-32.5353,-185.9060,1003.5469,179.9828},
{-35.9471,-139.4373,1003.5469,180.8417},
{-15.2291,-139.4371,1003.5469,181.8862},
{2352.9949,-1356.9926,24.3984,81.4894},
{2326.2161,-1645.9894,14.8270,1.2298},
{2060.3730,-1898.6987,13.5538,358.0622},
{1730.0648,-1943.9822,13.5683,359.9656},
{1788.2915,-1369.6107,15.7578,271.5237},
{1634.1901,-2238.2849,13.5077,357.0520},
{2140.2788,-1161.2979,23.9922,90.3452},
{2153.7239,-1015.5566,62.8875,131.0789},
{2480.6074,-1958.5238,13.5829,176.6882},
{1278.6086,372.2467,19.5547,63.2938},
{0.0,0.0,0.0,0.0}, // Empty
{0.0,0.0,0.0,0.0}, // Empty
{0.0,0.0,0.0,0.0}, // Empty
{0.0,0.0,0.0,0.0}, // Empty
{662.4121,-551.4104,16.3359,176.9450},
{0.0,0.0,0.0,0.0}, // Empty
{0.0,0.0,0.0,0.0}, // Empty
{2138.1719,-1733.8719,13.5506,1.7392}, // Idlewood gas chips
{1463.5256,-1706.5750,14.5469,90.1163}, //Preshing squre
{1902.6885,-1766.7441,13.5469,89.5741}, // Idlewood Burger shot
{2141.1072,-1734.0316,13.5494,1.3868} // Idlewood gas station

};


hook OnGameModeInit()
{
	for(new h = 0; h < sizeof(Vending); h++)
	{
		CreateDynamic3DTextLabel("   [Vending]\nPress F to use", COLOR_GREEN, Vending[h][0], Vending[h][1], Vending[h][2] + 1.3, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 30.0);
	}
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_SECONDARY_ATTACK))
    {
        for(new h = 0; h < sizeof(Vending); h++)
        {
            if(IsPlayerInRangeOfPoint(playerid,1.0,Vending[h][0], Vending[h][1], Vending[h][2]))
            {
                new Float:health;
                GetHealth(playerid,health);
                if(GetPVarInt(playerid, "VendingUse") != 0) return 1;
                if(health >= 99) return SendClientMessage(playerid,COLOR_GREY, "Health is full!");
                if(GetPlayerCash(playerid) < 3) return SendClientMessage(playerid,COLOR_GREY,"You need 3$ to use this.");
                if(GetPVarInt(playerid, "Injured") == 1) return SendClientMessage(playerid,COLOR_GREY,"You are dead, you cant use this.");
                SetPlayerPos(playerid,Vending[h][0], Vending[h][1], Vending[h][2]);
                SetPlayerFacingAngle(playerid,Vending[h][3]);
                GivePlayerMoney(playerid,-3);
                GameTextForPlayer(playerid, "~r~-$3.", 5000, 1);
                ApplyAnimation(playerid, "VENDING", "VEND_Use", 3.0, 0, 0, 0, 0, 0);
                PlayAudioStreamForPlayerEx(playerid, "https://media.rg-rp.net/Soundeffects/Vending.wav");
                health+=40.0;
                if(health >= 100.0) health=99.0;
                SetHealth(playerid, health);
                PlayerInfo[playerid][pMuted] = 1;
                SetPVarInt(playerid, "VendingUse", 1);
                SetTimerEx("VendingFinish", 2300, false, "i", playerid);
            }
        }
    }
    return 1;
}

forward VendingFinish(playerid);
public VendingFinish(playerid)
{
    PlayerInfo[playerid][pMuted] = 0;
    if (!IsPlayerAttachedObjectSlotUsed(playerid, 4))
	{
		SetPlayerAttachedObject(playerid, 4, 1546, 5, 0.106, 0.055 ,-0.033 ,13 ,3.6 ,-69.9, 1, 1, 1);
		SetTimerEx("RemoveAttachedObject", 2500, false, "dd", playerid, 4);
	}
    ApplyAnimation(playerid, "VENDING", "VEND_Drink2_P", 3.0, 0, 0, 0, 0, 0);
    SetPlayerSpecialAction(playerid, 0); // Clear sprunk can.
    return DeletePVar(playerid,"VendingUse");
}
