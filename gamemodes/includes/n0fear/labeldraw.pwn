////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>

forward OneSecondTimer();
public OneSecondTimer()
{
	foreach (Player,i)
	{
		if(GetPVarInt(i, "LableDraw") > 0)
		{
	 		SetPVarInt(i, "LableDraw", GetPVarInt(i, "LableDraw")-1);
	   		if(GetPVarInt(i, "LableDraw") == 0)
		    {
	     		TextDrawHideForPlayer(i,LableDraw[i]);
	       		if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
				{
	   				TextDrawHideForPlayer(i,UsedDraw[i]);
				}
	   			DeletePVar(i,"LableDraw");
			}
		}
	}
	return 1;
}

hook OnGameModeInit()
{
	SetTimer("OneSecondTimer", 1000, 1);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		UsedDraw[i] = TextDrawCreate(1.000000,1.000000," ");
		LableDraw[i] = TextDrawCreate(456.000000,160.000000," ");
		TextDrawAlignment(LableDraw[i],0);
		TextDrawBackgroundColor(LableDraw[i],0x000000ff);
		TextDrawFont(LableDraw[i],0);
		TextDrawLetterSize(LableDraw[i],1.000000,1.900000);
		TextDrawColor(LableDraw[i],0xffffffff);
		TextDrawSetOutline(LableDraw[i],1);
		TextDrawSetProportional(LableDraw[i],1);
		TextDrawSetShadow(LableDraw[i],1);
	}
	return 1;
}
hook OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
    new string[512];
	for(new h = 0; h < sizeof(HouseInfo); h++)
    {
        if(IsPlayerInRangeOfPoint(playerid,2.0,HouseInfo[h][hExteriorX],HouseInfo[h][hExteriorY],HouseInfo[h][hExteriorZ]))
        {
       		switch(HouseInfo[h][hOwned])
        	{
        		case 0:
         		{
          			format(string, sizeof(string), " ~r~Property For Sale!~n~ ~g~Value: ~w~$%d~n~ ~g~Level: ~w~%d~n~ ~g~Class: ~w~%s~n~ ~g~ID: ~w~%d~n~~n~ Type ~w~~g~/buyhouse ~w~to buy house ~n~~n~ ~g~Press ~r~Y ~w~to Enter.", HouseInfo[h][hValue], HouseInfo[h][hLevel], HouseInfo[h][hDescription], h);
            		CreateLableText(playerid,"Property",string);

				}
   				case 1:
     			{
					new price[50];
					if(HouseInfo[h][hValue] <= 1) price="Donated";
					else format(price, 50, "$%d", HouseInfo[h][hValue]);
    				switch(HouseInfo[h][hRentable])
       				{
          				case 0: format(string, sizeof(string), " ~g~Owner: ~w~%s~n~ ~g~Value: ~w~%s", HouseInfo[h][hOwnerName], price);
						case 1: format(string, sizeof(string), " ~g~Owner: ~w~%s~n~ ~g~Rent: ~w~$%d~n~~n~ Type ~b~/rentroom ~w~to~n~ rent.", HouseInfo[h][hOwnerName], HouseInfo[h][hRentFee]);
      				}
         			CreateLableText(playerid,"Property",string);
            	}
            }
        }
    }
    for(new b = 0; b < sizeof(Businesses); b++)
    {
        if(IsPlayerInRangeOfPoint(playerid,2.0,Businesses[b][bExtPos][0],Businesses[b][bExtPos][1],Businesses[b][bExtPos][2]))
        {
            switch(Businesses[b][bOwned])
            {
                case 0:
                {
					new btext[228], bstatus[128];
                    switch(Businesses[b][bStatus])
                    {
                        case 0: bstatus = "~r~CLOSED";
                    	case 1: bstatus = "~g~OPEN";
					}
					switch(Businesses[b][bType])
					{
					    case 1: btext = "Gas Station";
						case 2: btext = "Clothing Store";
						case 3: btext = "Restaurant";
						case 4: btext = "Gun Shop";
						case 5: btext = "New Car Dealership";
						case 6: btext = "Used Car Dealership";
						case 7: btext = "Mechanic";
						case 8: btext = "24/7";
						case 9: btext = "Bar";
						case 10: btext = "Club";
						case 11: btext = "Sex Shop";
						case 12: btext = "Gym";
						case 13: btext = "Casino";
						case 14: btext = "Fast Food";
						default: btext = "Undefined";
					}
                    format(string, sizeof(string), " %s~n~~n~ ~r~Business For Sale!~n~ ~b~Shop: ~w~%s~n~ ~g~Value: ~w~$%d~n~ ~g~ID: ~w~%d~n~~n~ Type ~b~/buybiz.", bstatus, btext, Businesses[b][bValue], b);
                    CreateLableText(playerid,"Business",string);
                }
                case 1:
                {
                    new btext[228], bstatus[128];
                    switch(Businesses[b][bStatus])
                    {
                    	case 1: bstatus = "OPEN";
						case 2: bstatus = "CLOSED";
					}
					switch(Businesses[b][bType])
					{
					    case 1: btext = "Gas Station";
						case 2: btext = "Clothing Store";
						case 3: btext = "Restaurant";
						case 4: btext = "Gun Shop";
						case 5: btext = "New Car Dealership";
						case 6: btext = "Used Car Dealership";
						case 7: btext = "Mechanic";
						case 8: btext = "24/7";
						case 9: btext = "Bar";
						case 10: btext = "Club";
						case 11: btext = "Sex Shop";
						case 12: btext = "Gym";
						case 13: btext = "Casino";
						case 14: btext = "Fast Food";
						default: btext = "Undefined";
					}
					//switch(Businesses[b][bGymType])
					if(Businesses[b][bType] != BUSINESS_TYPE_GYM)
    				{
                    	format(string, sizeof(string), " ~w~%s~n~ ~b~Shop: ~w~%s~n~ ~b~Owner:~w~%s~n~ ~b~ID: ~w~%d", Businesses[b][bName],btext,Businesses[b][bOwner],b);
   					}
					else
					{
                   		format(string, sizeof(string), " ~w~%s~n~ ~b~Shop: ~w~%s~n~ ~b~Owner:~w~%s~n~ ~b~Fee: ~w~$%d~n~ ~b~ID: ~w~%d", Businesses[b][bName],btext,Businesses[b][bOwner],Businesses[b][bGymEntryFee],b);
      				}
                    CreateLableText(playerid,"Business",string);
          		}
            }
        }
    }
    for(new g = 0; g < sizeof(GarageInfo); g++)
    {
        if(IsPlayerInRangeOfPoint(playerid,2.0,GarageInfo[g][gar_ExteriorX],GarageInfo[g][gar_ExteriorY],GarageInfo[g][gar_ExteriorZ]))
        {
			format(string, sizeof(string), " ~g~Owner: ~w~%s~n~ ~g~ID: ~w~%d~n~~n~ ~g~Press ~r~Y ~w~to Enter.", GarageInfo[g][gar_OwnerName], g);
 			CreateLableText(playerid,"Garage",string);
        }
    }
    for(new d = 0; d < sizeof(DDoorsInfo); d++)
    {
	    if(IsPlayerInRangeOfPoint(playerid,3.0,DDoorsInfo[d][ddExteriorX],DDoorsInfo[d][ddExteriorY],DDoorsInfo[d][ddExteriorZ]))
	    {
	        switch(DDoorsInfo[d][ddColor])
			{
	            case 1: format(string, sizeof(string), " ~r~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
	            case 2: format(string, sizeof(string), " ~r~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
	            case 3: format(string, sizeof(string), " ~r~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
	            case 4: format(string, sizeof(string), " ~r~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
	            case 5: format(string, sizeof(string), " ~r~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				case 6: format(string, sizeof(string), " ~g~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				case 7: format(string, sizeof(string), " ~g~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				case 8: format(string, sizeof(string), " ~g~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				case 9: format(string, sizeof(string), " ~b~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				case 10: format(string, sizeof(string), " ~b~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				case 11: format(string, sizeof(string), " ~p~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				case 12: format(string, sizeof(string), " ~p~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
				default: format(string, sizeof(string), " ~y~%s~n~ ~w~ID: %d ~n~ ~w~Press ~b~Y ~w~to go inside.", DDoorsInfo[d][ddDescription], d);
		       
   			}
      		CreateLableText(playerid,"Door",string);
		}
	}
	for(new a = 0; a < sizeof(ArrestPoints); a++)
    {
	    if(IsPlayerInRangeOfPoint(playerid,3.0,ArrestPoints[a][arrestPosX],ArrestPoints[a][arrestPosY],ArrestPoints[a][arrestPosZ]))
	    {
	    	format(string, sizeof(string), " ~w~ID: %d ~n~ ~w~Type ~b~/arrest", a);
	    	CreateLableText(playerid,"Arrest",string);
        }
    }
    if(IsPlayerInRangeOfPoint(playerid,2.0,2414.5132,1160.8452,2848.2695)) return CreateLableText(playerid,"Bank"," ~w~Press ~b~Y ~w~to view the menu.");
    if(IsPlayerInRangeOfPoint(playerid,2.0,2414.6257,1167.5598,2848.4333)) return CreateLableText(playerid,"Bank"," ~w~Press ~b~Y ~w~to view the menu.");
    return 1;
}

