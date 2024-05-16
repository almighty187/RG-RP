#include <YSI\y_hooks>

#define		DIALOG_LOCATE			(5200)
#define		DIALOG_LOCATELIST1		(5201)
#define		DIALOG_LOCATELIST2		(5202)
#define		DIALOG_LOCATELIST3		(5203)
#define		DIALOG_LOCATETURFS		(5204)
#define		DIALOG_LOCATEPOINTS		(5205)
#define		DIALOG_LOCATELISTC		(5206)

GetClosestBusiness(playerid, type)
{
	new
	    Float:distance[2] = {99999.0, 0.0},
	    index = -1;

    for(new i; i < MAX_BUSINESSES; i++)
	{
		if(IsValidBusinessID(i) && Businesses[i][bType] == type)
		{
			distance[1] = GetPlayerDistanceFromPoint(playerid, Businesses[i][bExtPos][0], Businesses[i][bExtPos][1], Businesses[i][bExtPos][2]);

			if(distance[0] > distance[1])
			{
			    distance[0] = distance[1];
			    index = i;
			}
		}
	}

	return index;
}
LocateMethod(playerid, params[])
{
	if(isnull(params))
	{
	    SendClientMessage(playerid, COLOR_GREY, "Null Error - failed to locate properly - contact a developer.");
	    return 1;
	}
	if(!strcmp(params, "dmv", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1784.9786,-1720.8746,13.5446, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of DMV.");
	}
	else if(!strcmp(params, "cityhall", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1481.0574,-1772.0535,18.7958, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the City Hall.");
	}
	else if(!strcmp(params, "allsaints", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1172.1243,-1323.2010,15.4027, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of All Saints hospital.");
	}
	else if(!strcmp(params, "county", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 2034.3092,-1402.3984,17.2961, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of County General hospital.");
	}
	else if(!strcmp(params, "bank", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1457.1743,-1011.5291,26.8438, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Bank.");
	}
	else if(!strcmp(params, "vip", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1310.30, -1368.20, 13.55, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the VIP lounge.");
	}
	else if(!strcmp(params, "pizzaman", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 2101.3096, -1810.1814, 13.5547, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Pizza Boy job.");
	}
	else if(!strcmp(params, "whore", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 2101.3096, -1810.1814, 13.5547, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Courier job.");
	}
	else if(!strcmp(params, "fisherman", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 2101.3096, -1810.1814, 13.5547, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Fisherman job.");
	}
	else if(!strcmp(params, "bodyguard", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 2101.3096, -1810.1814, 13.5547, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Bodyguard job.");
	}
	else if(!strcmp(params, "weapondealer", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1365.4233,-1276.1392,13.5469, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Weapons Dealer job.");
	}
	else if(!strcmp(params, "mechanic", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1530.3984, -1562.7521, 13.5469, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Mechanic job.");
	}
	else if(!strcmp(params, "miner", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1530.3984, -1562.7521, 13.5469, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Miner job.");
	}
    else if(!strcmp(params, "sweeper", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1530.3984, -1562.7521, 13.5469, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Sweeper job.");
	}
	else if(!strcmp(params, "taxidriver", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1808.7800, -1887.6000, 13.4104, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Taxi Driver job.");
	}
	else if(!strcmp(params, "lawyer", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1808.7800, -1887.6000, 13.4104, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Lawyer job.");
	}
	else if(!strcmp(params, "detective", true))
	{
	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, 1546.4595,-1674.4731,13.5728, 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the Detective job.");
	}
	else if(!strcmp(params, "supermarket", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_STORE);

	    if(businessid == -1)
	    {
	        return SendClientMessage(playerid, COLOR_GREY, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest supermarket.");
	}
	else if(!strcmp(params, "gunshop", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_GUNSHOP);

	    if(businessid == -1)
	    {
	        return SendClientMessage(playerid, COLOR_GREY, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest gun shop.");
	}
	else if(!strcmp(params, "clothesshop", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_CLOTHING);

	    if(businessid == -1)
	    {
	        return SendClientMessage(playerid, COLOR_GREY, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest clothes shop.");
	}
	else if(!strcmp(params, "gym", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_GYM);

	    if(businessid == -1)
	    {
	        return SendServerMessage(playerid, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest gym.");
	}
	else if(!strcmp(params, "restaurant", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_RESTAURANT);

	    if(businessid == -1)
	    {
	        return SendServerMessage(playerid, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest restaurant.");
	}
	else if(!strcmp(params, "gasstation", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_GASSTATION);

	    if(businessid == -1)
	    {
	        return SendServerMessage(playerid, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest gas station.");
	}
	else if(!strcmp(params, "club", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_CLUB);

	    if(businessid == -1)
	    {
	        return SendServerMessage(playerid, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest club/bar.");
	}
	else if(!strcmp(params, "dealership", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_NEWCARDEALERSHIP);

	    if(businessid == -1)
	    {
	        return SendServerMessage(playerid, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest dealership.");
	}
	else if(!strcmp(params, "casino", true))
	{
	    new businessid = GetClosestBusiness(playerid, BUSINESS_TYPE_CASINO);

	    if(businessid == -1)
	    {
	        return SendServerMessage(playerid, "There are no businesses of this type to be found.");
	    }

	    gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
	    SetPlayerCheckpoint(playerid, Businesses[businessid][bExtPos][0], Businesses[businessid][bExtPos][1], Businesses[businessid][bExtPos][2], 3.0);
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of the closest casino.");
	}
	else
	{
	    for(new x = 0; x < MAX_LOCATIONS; x++)
		{
			if(!strcmp(params, LocationInfo[x][locName], true))
			{
		    	gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
		    	SetPlayerCheckpoint(playerid, LocationInfo[x][locPosX], LocationInfo[x][locPosY], LocationInfo[x][locPosZ], 3.0);
		    	SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of %s", LocationInfo[x][locName]);
		    	break;
			}
   			if(x == MAX_LOCATIONS - 1)
		    {
      			SendClientMessageEx(playerid, COLOR_GREY, "Unable to locate '%s'. Contact an administrator!", params);
      			break;
		    }
		}
	    /*SendClientMessage(playerid, COLOR_SYNTAX, "USAGE: /locate [option]");
	    SendClientMessage(playerid, COLOR_SYNTAX, "Business Types: Supermarket, GunShop, ClothesShop, Gym, Restaurant, AdAgency, Club, ToolShop");
	    SendClientMessage(playerid, COLOR_SYNTAX, "General Locations: DMV, Bank, Paintball, Casino, VIP, Smuggledrugs, MatPickup1, MatPickup2");
		SendClientMessage(playerid, COLOR_SYNTAX, "General Locations: Dealership, AirDealer, BoatDealer, MatFactory1, MatFactory2, Heisenbergs");
        SendClientMessage(playerid, COLOR_SYNTAX, "Scripted Jobs: Pizzaman, Courier, Fisherman, Bodyguard, WeaponDealer, Mechanic, Miner, Sweeper");
        SendClientMessage(playerid, COLOR_SYNTAX, "Scripted Jobs: TaxiDriver, DrugDealer, Lawyer, Detective, Thief");*/

	}
	return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

	// Crash Bug Fix
 	if(strfind(inputtext, "%", true) != -1)
  	{
  	    SendErrorMessage(playerid, "Invalid Character, please try again.");
		return 1;
	}

	switch(dialogid)
	{
		case DIALOG_LOCATE:
		{
  			if(response)
      		{
				switch(listitem)
				{
				    case 0: // JOBS
				    {
				    	//ShowPlayerDialogEx(playerid, DIALOG_LOCATELIST1, DIALOG_STYLE_LIST, "GPS - Select Destination", "Pizza Boy\nBodyguard\nWeapon Dealer\nMechanic\nTaxi Driver\nDrug Dealer\nLawyer\nDetective", "Select", "Close");
				    	//Map_ShowJobs(playerid, listitem);
				    	for(new i; i < MAX_JOBTYPES; ++i)
						{
							format(szMiscArray, sizeof(szMiscArray), "%s%s\n", szMiscArray, JobName[i]);
						}
						return ShowPlayerDialogEx(playerid, DIALOG_LOCATELIST1, DIALOG_STYLE_LIST, "San Andreas | Map | Jobs", szMiscArray, "Select", "Back");
				    }
				    case 1: // STORES
				    {
				    	ShowPlayerDialogEx(playerid, DIALOG_LOCATELIST2, DIALOG_STYLE_LIST, "GPS - Select Destination", "24/7\nAmmunation\nClothing Store\nGym\nRestaurant\nGas Station\nClub\nCar Dealership\nCasino", "Select", "Close");
				    }
				    case 2: // GENERAL LOCATIONS
				    {
				    	ShowPlayerDialogEx(playerid, DIALOG_LOCATELIST3, DIALOG_STYLE_LIST, "GPS - Select Destination", "DMV\nBank\nVIP\nLS City Hall\nCounty Hospital\nAll Saints", "Select", "Close");
				    }
					case 3: // Find Turfs
					{
					    new string[34 * MAX_TURFS];
					    for(new x = 0; x < MAX_TURFS; x++)
						{
						    if(TurfWars[x][twMinX]) {
					    		strcat(string, TurfWars[x][twName]);
								strcat(string, "\n");
							}
						}
						if(strlen(string) > 2) {
							ShowPlayerDialogEx(playerid, DIALOG_LOCATETURFS, DIALOG_STYLE_LIST, "GPS - Select Destination", string, "Select", "Close");
						} else {
						    ShowPlayerDialogEx(playerid, -1, DIALOG_STYLE_MSGBOX, "GPS - Signal Lost", "Unable to locate any new locations.", "Cancel", "");
						}
					}
					case 4: // Find Points
					{
					    new string[34 * MAX_POINTS];
					    for(new x = 0; x < MAX_POINTS; x++)
						{
						    if(strcmp(DynPoints[x][poName], "NULL", true) != 0) {
					    		strcat(string, DynPoints[x][poName]);
								strcat(string, "\n");
							}
						}
						if(strlen(string) > 2) {
							ShowPlayerDialogEx(playerid, DIALOG_LOCATEPOINTS, DIALOG_STYLE_LIST, "GPS - Select Destination", string, "Select", "Close");
						} else {
						    ShowPlayerDialogEx(playerid, -1, DIALOG_STYLE_MSGBOX, "GPS - Signal Lost", "Unable to locate any new locations.", "Cancel", "");
						}
					}

					case 5: // More locations
					{
					    new string[MAX_LOCATIONS*34];
						for(new x = 0; x < MAX_LOCATIONS; x++)
						{
						    if(LocationInfo[x][locExists]) {
					    		strcat(string, LocationInfo[x][locName]);
								strcat(string, "\n");
							}
						}
						if(strlen(string) > 2) {
							ShowPlayerDialogEx(playerid, DIALOG_LOCATELISTC, DIALOG_STYLE_LIST, "GPS - Select Destination", string, "Select", "Close");
						} else {
						    ShowPlayerDialogEx(playerid, -1, DIALOG_STYLE_MSGBOX, "GPS - Signal Lost", "Unable to locate any new locations.", "Cancel", "");
						}
					}
				}
      		}
		}
		/*case DIALOG_LOCATELIST1: //if(response) return Map_ShowJobs(playerid, listitem);
		{
			if(response)
			{ //return 1;
			
				switch(listitem)
				{
	   				case 0:
					{
						for(new i; i < MAX_JOBTYPES; ++i)
						{
							format(szMiscArray, sizeof(szMiscArray), "%s%s\n", szMiscArray, JobName[i]);
						}
						return ShowPlayerDialogEx(playerid, DIALOG_LOCATELIST1, DIALOG_STYLE_LIST, "San Andreas | Map | Jobs", szMiscArray, "Select", "Back");
					}
				}
			}
		}*/
		case DIALOG_LOCATELIST1: if(response) return Map_ShowJobs(playerid, listitem);
		case DIALOG_LOCATELIST2:
		{
		    if(response)
			{
			    switch(listitem)
			    {
				    case 0:
						LocateMethod(playerid,"Supermarket");
				    case 1:
				        LocateMethod(playerid,"GunShop");
				    case 2:
				        LocateMethod(playerid,"ClothesShop");
				    case 3:
				        LocateMethod(playerid,"Gym");
				    case 4:
				        LocateMethod(playerid,"Restaurant");
				    case 5:
				        LocateMethod(playerid,"gasstation");
				    case 6:
				        LocateMethod(playerid,"Club");
				    case 7:
				        LocateMethod(playerid,"dealership");
					case 8:
				        LocateMethod(playerid,"casino");
				}
			}
		}
		case DIALOG_LOCATELIST3:
		{
		    if(response)
			{
			    switch(listitem)
			    {
                    case 0:
						LocateMethod(playerid,"DMV");
                    case 1:
						LocateMethod(playerid,"Bank");
                    case 2:
						LocateMethod(playerid,"VIP");
                    case 3:
						LocateMethod(playerid,"cityhall");
                    case 4:
						LocateMethod(playerid,"county");
                    case 5:
						LocateMethod(playerid,"allsaints");
				}
			}
		}
		case DIALOG_LOCATELISTC:
		{
		    if(response)
		    {
				LocateMethod(playerid, inputtext);
		    }
		}
		case DIALOG_LOCATETURFS:
		{
			if(response)
			{
				if(TurfWars[listitem][twMinX])
			    {
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
					SetPlayerCheckpoint(playerid, TurfWars[listitem][twMinX], TurfWars[listitem][twMinY], 14.0, 3.0);
					SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of %s.", TurfWars[listitem][twName]);
				}	
			}
		}
		case DIALOG_LOCATEPOINTS:
		{
		    if(response)
			{
			    if(DynPoints[listitem][poPos][0])
			    {
	                gPlayerCheckpointStatus[playerid] = CHECKPOINT_MISC;
				    SetPlayerCheckpoint(playerid, DynPoints[listitem][poPos][0], DynPoints[listitem][poPos][1], DynPoints[listitem][poPos][2], 3.0);
				    SendClientMessageEx(playerid, COLOR_LIGHTBLUE, "** Checkpoint marked at the location of %s.", DynPoints[listitem][poName]);
			    }
			}
		}
	}
	return 0;
}
CMD:mygps(playerid, params[])
{
	if(isnull(params))
	{
	    return ShowPlayerDialogEx(playerid, DIALOG_LOCATE, DIALOG_STYLE_LIST, "GPS - Select Destination", "Job Locations\nNearest Businesses\nGeneral Locations\nFind Turfs\nFind Points\nMore Locations", "Select", "Close");
	}
	else
	{
	    LocateMethod(playerid, params);
	}
	return 1;
}
