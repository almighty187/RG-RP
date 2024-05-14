CMD:tow(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new
			carid = GetPlayerVehicleID(playerid);

		if(IsATowTruck(carid))
		{
			new
				closestcar = GetClosestCar(playerid, carid);

			foreach(new i: Player)
			{
				if(arr_Towing[i] == closestcar || (GetPlayerVehicleID(i) == closestcar && GetPlayerState(i) == 2)) return SendErrorMessage(playerid, "You can't tow a vehicle which is occupied, or in tow.");
			}

			if(GetDistanceToCar(playerid,closestcar) <= 8 && !IsTrailerAttachedToVehicle(carid)) {
				foreach(new i: Player)
				{
					if(IsAPlane(closestcar) || IsABike(closestcar) || IsASpawnedTrain(closestcar) || IsATrain(closestcar) || IsAHelicopter(closestcar)) {
						return SendServerMessage(playerid, "You cannot tow this type of vehicle.");
					}
					if(GetPlayerVehicle(i, closestcar) != -1) {

						new
							hKey;

						if(((hKey = PlayerInfo[i][pPhousekey]) != INVALID_HOUSE_ID) && IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[hKey][hExteriorX], HouseInfo[hKey][hExteriorY], HouseInfo[hKey][hExteriorZ])
						||((hKey = PlayerInfo[i][pPhousekey2]) != INVALID_HOUSE_ID) && IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[hKey][hExteriorX], HouseInfo[hKey][hExteriorY], HouseInfo[hKey][hExteriorZ])
						||((hKey = PlayerInfo[i][pPhousekey3]) != INVALID_HOUSE_ID) && IsPlayerInRangeOfPoint(playerid, 50.0, HouseInfo[hKey][hExteriorX], HouseInfo[hKey][hExteriorY], HouseInfo[hKey][hExteriorZ])) {
							return SendServerMessage(playerid, "This vehicle doesn't need to be towed.");
						}
						RemoveVehicleFromMeter(closestcar);
						arr_Towing[playerid] = closestcar;
						SendServerMessage(playerid, "This vehicle is available for impounding.");
						return AttachTrailerToVehicle(closestcar,carid);
					}
				}	
				SendServerMessage(playerid, "This vehicle has no registration, it is available for impounding.");
				AttachTrailerToVehicle(closestcar,carid);
				arr_Towing[playerid] = closestcar;
				RemoveVehicleFromMeter(closestcar);
				return 1;
			}
		}
		else if(IsAAircraftTowTruck(carid)) //Tug
		{
			new
				closestcar = GetClosestCar(playerid, carid);
				
			foreach(new i: Player)
			{
				if(arr_Towing[i] == closestcar || (GetPlayerVehicleID(i) == closestcar && GetPlayerState(i) == 2)) return SendClientMessageEx(playerid, COLOR_GREY, "You can't tow a vehicle which is occupied, or in tow.");
			}
			
			if(GetDistanceToCar(playerid,closestcar) <= 8 && !IsTrailerAttachedToVehicle(carid))
			{
				foreach(new i: Player)
				{
					if(IsAPlane(closestcar))
					{
						if(GetPlayerVehicle(i, closestcar) != -1)
						{
							RemoveVehicleFromMeter(closestcar);
							arr_Towing[playerid] = closestcar;
							SendServerMessage(playerid, "This vehicle is available for impounding.");
							return AttachTrailerToVehicle(closestcar,carid);
						}
					}
					else return SendErrorMessage(playerid, "You can only tow aircrafts with this vehicle!");
				}	
				SendServerMessage(playerid, "This vehicle has no registration, it is available for impounding.");
				AttachTrailerToVehicle(closestcar,carid);
				arr_Towing[playerid] = closestcar;
				RemoveVehicleFromMeter(closestcar);
			}
		}
		else SendErrorMessage(playerid, "You are not authorized to tow with this vehicle.");
	}
	else SendErrorMessage(playerid, "You need to be inside a vehicle to use this command!");
	return 1;
}

CMD:untow(playerid, params[])
{
	if(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
	{
		SendServerMessage(playerid, "You have unhooked the vehicle that you were towing.");
		arr_Towing[playerid] = INVALID_VEHICLE_ID;
		DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
	}
	else SendErrorMessage(playerid, "You are currently not towing anything.");
	return 1;
}
