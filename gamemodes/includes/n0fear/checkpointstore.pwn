#include <YSI\y_hooks>

//----------------------------------------------------------
new Float:CheckpointAreas[8][6] =
{
	{-25.8740,-187.8994,1003.5469, -29.1234,-185.1281,1003.5469}, // 24/7
	{6.0968,-31.1404,1003.5494, 2.1593,-29.0054,1003.5494}, // 24/7
	{-25.9979,-141.1634,1003.5469, -22.2423,-138.6211,1003.5469}, // 24/7
	{-27.3893,-31.3759,1003.5573,-30.7023,-29.0040,1003.5573}, // 24/7
	{-27.4420,-57.6850,1003.5469,-23.5890,-55.6249,1003.5469}, // 24/7
	{365.0366,-11.4588,1002.6439,368.1488, -6.1050, 1002.3885}, // Cluckin Bell
	{372.1912,-133.4454,1002.3047,372.7783,-118.8684,1002.1565}, // Pizza
 	{363.0318,-75.1106,1002.2307,376.5155,-67.4349,1001.5078} // Burger

};
//----------------------------------------------------------
new CheckpointAreaType[8][1] =
{
	{CHECKPOINT_STORE},
	{CHECKPOINT_STORE},
	{CHECKPOINT_STORE},
	{CHECKPOINT_STORE},
	{CHECKPOINT_STORE},
	{CHECKPOINT_RESTAURANT},
 	{CHECKPOINT_RESTAURANT},
  	{CHECKPOINT_RESTAURANT}
};
//----------------------------------------------------------
hook OnPlayerEnterCheckpoint(playerid)
{
	switch(GetPVarInt(playerid, "Checkpoint"))
	{
		case CHECKPOINT_NONE: DisablePlayerCheckpoint(playerid);
        case CHECKPOINT_STORE:
        {
            if(GetPVarInt(playerid, "OCC") == 0)
			{
			    new rand = random(5)+1; // AI
				switch(rand)
				{
				    case 1: SendClientMessage(playerid,COLOR_WHITE,"24/7 Cashier Says: {FFFFFF}Welcome, what can I get for you today?");
				    case 2: SendClientMessage(playerid,COLOR_WHITE,"24/7 Cashier Says: {FFFFFF}Hey, how are you?");
				    case 3: SendClientMessage(playerid,COLOR_WHITE,"24/7 Cashier Says: {FFFFFF}Welcome.");
				    case 4: SendClientMessage(playerid,COLOR_WHITE,"24/7 Cashier Says:{FFFFFF} Hello there, what can I do for you today?");
				    default: SendClientMessage(playerid,COLOR_WHITE,"24/7 Cashier Says: {FFFFFF}There's a variety of items to purchase.");
				}
				new iBusiness = InBusiness(playerid);

			    if (Businesses[iBusiness][bAutoSale])
				{
					if (Businesses[iBusiness][bInventory] < 1)
					{
						SendErrorMessage(playerid, "This store does not have any items at the moment!");
						SetPVarInt(playerid, "OCC", 0);
						return 1;
					}
					if (!Businesses[iBusiness][bStatus])
					{
						SendErrorMessage(playerid, "This store is closed!");
						SetPVarInt(playerid, "OCC", 0);
						return 1;
					}
				}
				else return SendErrorMessage(playerid, "You need to interact with the business employees to buy.");
				DisplayItemPricesDialog(iBusiness, playerid);
			    SetPVarInt(playerid, "OCC", 1);
    		}
    	}
		case CHECKPOINT_RESTAURANT:
        {
            if(GetPVarInt(playerid, "OCC") == 0)
			{
			    new rand = random(5)+1; // AI
				switch(rand)
				{
				    case 1: SendClientMessage(playerid,COLOR_WHITE,"Restaurant Cashier Says: {FFFFFF}Welcome, what can I get for you today?");
				    case 2: SendClientMessage(playerid,COLOR_WHITE,"Restaurant Cashier Says: {FFFFFF}Hey, how are you?");
				    case 3: SendClientMessage(playerid,COLOR_WHITE,"Restaurant Cashier Says: {FFFFFF}Welcome.");
				    case 4: SendClientMessage(playerid,COLOR_WHITE,"Restaurant Cashier Says:{FFFFFF} Hello there, what can I do for you today?");
				    default: SendClientMessage(playerid,COLOR_WHITE,"Restaurant Cashier Says: {FFFFFF}There's a variety of meals to purchase.");
				}
				new iBusiness = InBusiness(playerid);
				if (Businesses[iBusiness][bInventory] < 1)
				{
				    SendErrorMessage(playerid, "Business does not have enough inventory!");
				    return 1;
				}

				if (!Businesses[iBusiness][bStatus])
				{
					SendErrorMessage(playerid, "This restaurant is closed!");
					return 1;
				}
				if(Businesses[iBusiness][bMaxLevel] > 0 && PlayerInfo[playerid][pConnectHours] > Businesses[iBusiness][bMaxLevel])
					return SendErrorMessage(playerid, "The cashier has denied you service, this discount store is for new citizens only.");
				new szDialog[512], pvar[25], line;

				for (new item; item < sizeof(RestaurantItems); ++item)
				{
					format(szDialog, sizeof(szDialog), "%s%s  ($%s)\n", szDialog, RestaurantItems[item], number_format(Businesses[iBusiness][bItemPrices][item]));
					format(pvar, sizeof(pvar), "Business_MenuItem%d", line);
					SetPVarInt(playerid, pvar, item);
					format(pvar, sizeof(pvar), "Business_MenuItemPrice%d", line);
					SetPVarInt(playerid, pvar, Businesses[iBusiness][bItemPrices][item]);
					line++;
				}

				if (strlen(szDialog) == 0)
				{
			        SendErrorMessage(playerid, "Store is not selling any items!");
			    }
			    else
				{
			    	ShowPlayerDialogEx(playerid, RESTAURANTMENU, DIALOG_STYLE_LIST, "Menu", szDialog, "Buy", "Cancel");
			    	SetPVarInt(playerid, "OCC", 1);
   				}
   			}
   		}
	}
	return 1;
}
forward LoadChecks(playerid);
public LoadChecks(playerid)
{
    for(new i = 0; i < sizeof(CheckpointAreas); i++)
	{
        if(IsPlayerInRangeOfPoint(playerid,20.0,CheckpointAreas[i][0],CheckpointAreas[i][1],CheckpointAreas[i][2]))
        {
            SetPlayerCheckpoint(playerid,CheckpointAreas[i][3],CheckpointAreas[i][4],CheckpointAreas[i][5],1.0);
            SetPVarInt(playerid, "Checkpoint", CheckpointAreaType[i][0]);
            SetPVarInt(playerid, "OCC", 0);
        }
    }
    return 1; //LoadIntSystem(playerid);
}
        
