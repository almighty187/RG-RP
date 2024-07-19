#include <YSI\y_hooks>



#define 	red             	"{FF0000}"
#define     grey                "{AFAFAF}"
#define     green   	    	"{00FF00}"
new playerCar[MAX_PLAYERS];

hook OnGameModeInit()
{
	Airplanes = LoadModelSelectionMenu("VehicleSpawner/Airplane.txt");
	Bikes = LoadModelSelectionMenu("VehicleSpawner/Bike.txt");
	Boats = LoadModelSelectionMenu("VehicleSpawner/Boat.txt");
	Convertible = LoadModelSelectionMenu("VehicleSpawner/Convertible.txt");
	Helicopters = LoadModelSelectionMenu("VehicleSpawner/Helicopter.txt");
	Industrials = LoadModelSelectionMenu("VehicleSpawner/Industrial.txt");
	Lowrider = LoadModelSelectionMenu("VehicleSpawner/Lowrider.txt");
	OffRoad = LoadModelSelectionMenu("VehicleSpawner/OffRoad.txt");
	PublicService = LoadModelSelectionMenu("VehicleSpawner/PublicService.txt");
	RC = LoadModelSelectionMenu("VehicleSpawner/RC.txt");
	Saloon = LoadModelSelectionMenu("VehicleSpawner/Saloon.txt");
	Sports = LoadModelSelectionMenu("VehicleSpawner/Sport.txt");
	StationWagon = LoadModelSelectionMenu("VehicleSpawner/StationWagon.txt");
	Trailer = LoadModelSelectionMenu("VehicleSpawner/Trailer.txt");
	Unique = LoadModelSelectionMenu("VehicleSpawner/Unique.txt");
	return 1;
}
CMD:veh(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 4 || PlayerInfo[playerid][pASM] >= 1) {

		ShowPlayerDialog(playerid, DIALOG_VEHICLES, DIALOG_STYLE_LIST, ""red"Vehicle Category", ""green"Airplane\n"green"Bike\n"green"Boat\n"green"Convertible\n"green"Helicopter\n"green"Industrial\n"green"Lowrider\n"green"Off Road\n"green"Public Service\n"green"RC\n"green"Saloon\n"green"Sport\n"green"Station Wagon\n"green"Trailer\n"green"Unique", "Select", "Close");
		return 1;
	}
	else SendErrorMessage(playerid,"You are not authorized to use this CMD.");
	return 1;
}
//CMD:car(playerid, params[]) return cmd_v(playerid, params);
hook OnPlayerModelSelection(playerid, response, listid, modelid)
{
	new VW, INT;
    if(listid == Airplanes || listid == Bikes || listid == Boats || listid == Convertible || listid == Helicopters || listid == Industrials || listid == Lowrider || listid == OffRoad || listid == PublicService || listid == RC || listid == Saloon || listid == Sports || listid == StationWagon || listid == Trailer || listid == Unique)
    {
        if(response)
        {
            DestroyVehicle(playerCar[playerid]);
            new Float:pos[4], color[2];
			GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			GetPlayerFacingAngle(playerid, pos[3]);
			color[0] = random(256);
			color[1] = random(256);
			playerCar[playerid] = CreateVehicle(modelid, pos[0], pos[1], pos[2]+2.0, pos[3], color[0], color[1], -1);
			VW = GetPlayerVirtualWorld(playerid);
    		INT = GetPlayerInterior(playerid);
    		SetVehicleVirtualWorld(playerCar[playerid], VW);
    		LinkVehicleToInterior(playerCar[playerid], INT);
			PutPlayerInVehicle(playerid, playerCar[playerid], 0);
			SendClientMessage(playerid, 0xFF0000FF, ""red"[Vehicle] "grey"Vehcile Spawned.");

        }
        else SendClientMessage(playerid, 0xFF0000FF, ""red"[Vehicle] "grey"Canceled selection.");
        return 1;
    }
    return 1;
}



