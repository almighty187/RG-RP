timer Fix_PlayerInVehicleCheck[3000](playerid) {

	if(IsPlayerInAnyVehicle(playerid) && PlayerInfo[playerid][pMechSkill] < 400) {

		TogglePlayerControllable(playerid, true);
		RemovePlayerFromVehicle(playerid);
		SendClientMessageEx(playerid, COLOR_LIGHTRED, "[SERVER]: Please do not exploit this again.");
		TogglePlayerControllable(playerid, false);
	}
}

CMD:fix(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 7 || PlayerInfo[playerid][pJob2] == 7 || PlayerInfo[playerid][pJob3] == 7 ||
	(PlayerInfo[playerid][pBusiness] != INVALID_BUSINESS_ID && Businesses[PlayerInfo[playerid][pBusiness]][bType] == BUSINESS_TYPE_MECHANIC && InBusiness(playerid) == PlayerInfo[playerid][pBusiness]))
	{
    	new string[32 + MAX_PLAYER_NAME];
        if(IsPlayerInAnyVehicle(playerid))
		{
		    SendErrorMessage(playerid, "You can not repair while inside the vehicle.");
		    return 1;
		}

  		if(gettime() < PlayerInfo[playerid][pMechTime])
		{
  			format(string, sizeof(string), "You must wait %d seconds!", PlayerInfo[playerid][pMechTime]-gettime());
     		SendClientMessageEx(playerid, COLOR_GRAD1,string);
     		return 1;
     	}
     	else if(GetPVarType(playerid, "IsInArena"))
		{
			SendErrorMessage(playerid, "You can't do this right now, you are in an arena!");
			return 1;
		}
		else if(GetPVarInt(playerid, "EventToken"))
		{
			SendErrorMessage(playerid, "You can't use this while in an event.");
			return 1;
		}
		else if(GetPVarType(playerid, "PlayerCuffed") || GetPVarInt(playerid, "pBagged") >= 1 || GetPVarType(playerid, "Injured") || GetPVarType(playerid, "IsFrozen"))
		{
			return SendErrorMessage(playerid, "You can't not do this while cuffed!");
		}
		else if(GetPVarType(playerid, "FixVehicleTimer"))
		{
			return SendErrorMessage(playerid, "You are already fixing a vehicle!");
		}
  		else
		{
			new closestcar = GetClosestCar(playerid);

  			if(IsPlayerInRangeOfVehicle(playerid, closestcar, 10.0))
  			{
				new engine,lights,alarm,doors,bonnet,boot,objective;
				new level = PlayerInfo[playerid][pMechSkill];
				GetVehicleParamsEx(closestcar,engine,lights,alarm,doors,bonnet,boot,objective);
				if(!IsABike(closestcar) && !IsAPlane(closestcar)) {
					if(bonnet == VEHICLE_PARAMS_OFF || bonnet == VEHICLE_PARAMS_UNSET)
					{
						SendClientMessageEx(playerid, COLOR_GRAD1, "The vehicle hood must be opened in order to repair it.");
						return 1;
					}
				}
    			if(level >= 400)
    			{
    				SetTimerEx("FixVehicle", 2000, false, "ii", playerid, closestcar); // Fixes the crash bug.
    			} 
    			else 
    			{
    				format(string, sizeof(string), "* %s has began repairing the vehicle.", GetPlayerNameEx(playerid));
    				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					SetPVarInt(playerid, "FixVehicleTimer", SetTimerEx("FixVehicle", 15000, false, "ii", playerid, closestcar));
					TogglePlayerControllable(playerid, 0);
					PlayAnimEx(playerid, "MISC", "Plunger_01", 4.1, 1, 1, 1, 1, 1, 1);
					PlayerInfo[playerid][pAnimUse] = 1;
    			}
				defer Fix_PlayerInVehicleCheck(playerid);
			}
			else return SendErrorMessage(playerid, "You are not close enough to any vehicle.");
  		}
    }
    else return SendErrorMessage(playerid, "You are not a Mechanic!" );
    return 1;
}

forward FixVehicle(playerid, vehicleid);
public FixVehicle(playerid, vehicleid)
{
	TogglePlayerControllable(playerid, 1);
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
	ClearAnimationsEx(playerid);
	SetPlayerSkin(playerid, GetPlayerSkin(playerid));
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	PlayerInfo[playerid][pAnimUse] = 0;
	PlayerInfo[playerid][pMechTime] = gettime()+60;
	SetVehicleHealth(vehicleid, 1000.0);
	Vehicle_Armor(vehicleid);
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(GetVehicleModel(vehicleid) == 481 && GetVehicleModel(vehicleid) == 509 && GetVehicleModel(vehicleid) == 510)
	{
		SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
		arr_Engine{vehicleid} = 1;
	}
	format(szMiscArray, sizeof(szMiscArray), "* %s has repaired the vehicle.", GetPlayerNameEx(playerid));
	ProxDetector(30.0, playerid, szMiscArray, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	DeletePVar(playerid, "FixVehicleTimer");
}

CMD:mechduty(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 7 || PlayerInfo[playerid][pJob2] == 7 || PlayerInfo[playerid][pJob3] == 7)
	{
        if(GetPVarInt(playerid, "MechanicDuty") == 1)
		{
            SendServerMessage(playerid, "* You are now off duty from your Car Mechanic job and will not receive calls anymore.");
			SetPVarInt(playerid, "MechanicDuty", 0);
            Mechanics -= 1;
        }
        else if(GetPVarInt(playerid, "MechanicDuty") == 0)
		{
            if (TransportDuty[playerid] != 0) return SendClientMessageEx(playerid,COLOR_GREY,"You need to get off duty as a transport driver first.");
            SendServerMessage(playerid, "* You are now on duty with your Car Mechanic job and will receive calls from people in need.");
			SetPVarInt(playerid, "MechanicDuty", 1);
            ++Mechanics;
        }
    }
    else SendErrorMessage(playerid, "You are not a mechanic!");
    return 1;
}

CMD:nos(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 7 || PlayerInfo[playerid][pJob2] == 7 || PlayerInfo[playerid][pJob3] == 7) {
        if(IsPlayerInAnyVehicle(playerid)) {
			if(GetPVarInt(playerid, "EventToken")) {
				return SendClientMessageEx(playerid, COLOR_GRAD1, "You can't use this while in an event.");
			}
   			if(GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), GetVehicleComponentType(1010)) != 1010 && GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), GetVehicleComponentType(1009)) != 1009 && GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), GetVehicleComponentType(1008)) != 1008)
   			{
            	if(!IsPlayerInInvalidNosVehicle(playerid))
				{
                	new string[128];
                	new nostogive;
               		new level = PlayerInfo[playerid][pMechSkill];
 		 			if(level >= 0 && level < 50) { nostogive = 1009; }
    		 		else if(level >= 50 && level < 100) { nostogive = 1009; }
         			else if(level >= 100 && level < 200) { nostogive = 1008; }
                	else if(level >= 200 && level < 400) { nostogive = 1008; }
                	else if(level >= 400) { nostogive = 1010; }
                	AddVehicleComponent(GetPlayerVehicleID(playerid),nostogive);
                	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
                	format(string, sizeof(string), "* %s added nitrous injection to the vehicle.", GetPlayerNameEx(playerid));
                	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            	}
            	else SendErrorMessage(playerid, "Nitrous injection cannot be installed on this vehicle.");
			 }
			 else SendErrorMessage(playerid, "This vehicle already has nitrous.");
        }
        else SendErrorMessage(playerid, "You're not in a vehicle.");
    }
    else SendErrorMessage(playerid, "You are not a Mechanic!" );
    return 1;
}

CMD:hyd(playerid, params[])
{
    if(PlayerInfo[playerid][pJob] == 7 || PlayerInfo[playerid][pJob2] == 7 || PlayerInfo[playerid][pJob3] == 7)
	{
        if(IsPlayerInAnyVehicle(playerid))
		{
			if(IsPlayerInInvalidNosVehicle(playerid) || (DynVeh[GetPlayerVehicleID(playerid)] != -1 && DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_igID] != INVALID_GROUP_ID && arrGroupData[DynVehicleInfo[DynVeh[GetPlayerVehicleID(playerid)]][gv_igID]][g_iGroupType] != GROUP_TYPE_CRIMINAL)) return SendClientMessageEx(playerid, COLOR_WHITE, "Hydraulics cannot be installed in this vehicle.");
			if(gettime() < PlayerInfo[playerid][pServiceTime]) return SendClientMessage(playerid, COLOR_GREY, "You must wait 20 seconds before using this command again.");
			new string[128];
			PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1087);
			format(string, sizeof(string), "* %s added hydraulics to the vehicle.", GetPlayerNameEx(playerid));
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			PlayerInfo[playerid][pServiceTime] = gettime()+20;
        }
        else return SendErrorMessage(playerid, "You're not in a vehicle.");
    }
    else return SendErrorMessage(playerid, "You are not a Mechanic!");
    return 1;
}
