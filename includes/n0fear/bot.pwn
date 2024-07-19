////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>

new
//Bot system
	BotBus,
	BotBus2,
	BotLoad,
	BotTrain,
    BotPlane;

new Float:BusRoutes[28][6] = {
{1350.2276611328,-1869.5209960938,13.826066970825,0.0,0.0,239.99998474121},
{1837.0421142578,-2172.9685058594,13.826066970825,0.0,0.0,269.99996948242},
{2182.8854980469,-2190.3354492188,13.826066970825,0.0,0.0,316.0},
{2220.4458007813,-1957.7052001953,13.823386192322,0.0,0.0,356.0},
{2224.1484375,-1708.9302978516,13.890753746033,0.0,0.0,354.0},
{2058.5971679688,-1605.7132568359,13.826066970825,0.0,0.0,92.0},
{1858.2003173828,-1424.5092773438,13.841691970825,0.0,0.0,0.0},
{2030.6745605469,-1142.4306640625,24.917530059814,0.0,0.0,270.0},
{2234.5964355469,-1227.1840820313,24.250940322876,0.0,0.0,269.99996948242},
{2376.4799804688,-1390.6400146484,24.300043106079,0.0,0.0,269.99996948242},
{2557.3110351563,-1462.2960205078,24.283411026001,0.0,0.0,0.0},
{2548.5556640625,-1177.6486816406,60.95011138916,356.0,0.0,92.0},
{2249.0288085938,-1134.791015625,26.605863571167,0.0,0.0,76.0},
{1844.115234375,-1174.1911621094,24.107316970825,0.0,0.0,90.0},
{1483.59375,-1027.5123291016,24.092540740967,0.0,0.0,90.0},
{981.81512451172,-1032.8107910156,30.734930038452,358.0,0.0,90.0},
{790.91650390625,-1349.9647216797,13.826066970825,0.0,0.0,180.0},
{910.57019042969,-1541.0939941406,13.833879470825,0.0,0.0,180.0},
{1043.40002441,-1603.50000000,13.80000019,0.00000000,0.00000000,0.00000000},
{1163.09997559,-1412.59997559,13.80000019,0.00000000,0.00000000,269.99996948},
{1364.19995117,-1261.80004883,13.80000019,0.00000000,0.00000000,0.00000000},
{1464.30004883,-1040.59997559,24.10000038,0.00000000,0.00000000,269.99996948},
{1447.90002441,-1391.80004883,13.80000019,0.00000000,0.00000000,180.00000000},
{1482.90002441,-1599.00000000,13.80000019,0.00000000,0.00000000,269.99996948},
{1924.50000000,-1618.69995117,13.80000019,0.00000000,0.00000000,269.99996948},
{1955.19995117,-1902.30004883,13.80000019,0.00000000,0.00000000,180.00000000},
{1816.59997559,-2137.19995117,13.80000019,0.00000000,0.00000000,179.99993896},
{1468.09997559,-1865.90002441,13.80000019,0.00000000,0.00000000,92.00000000}
};
hook OnGameModeInit()
{
	//Bots
	BotLoad=0, LoadBots(0);
	BotBus = AddStaticVehicleEx(431,1172.5,-1795.5,13.1,0.0, -1, -1, VEHICLERESPAWNTIME);
	BotBus2 = AddStaticVehicleEx(431,1181.4955,-1798.0479,13.5006,359.7428, -1, -1, VEHICLERESPAWNTIME);
	BotTrain = AddStaticVehicleEx(538,-1942.0443,183.1388,25.5979,354.8794, -1, -1, VEHICLERESPAWNTIME);
	BotPlane = AddStaticVehicleEx(592,2057.9417,-2485.7690,14.7389,90.7354,1,1,VEHICLERESPAWNTIME);
	SetTimer("OneMinTimer", 60000, 1);
	for(new h = 0; h < sizeof(BusRoutes); h++)
	{
	    CreateDynamic3DTextLabel("{FFFFFF}[{FFFF00}Bus Stop{FFFFFF}]",0xFFFFFFFF,BusRoutes[h][0], BusRoutes[h][1], BusRoutes[h][2]+0.50, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, 100.0);
        CreateDynamicObject(1257, BusRoutes[h][0], BusRoutes[h][1], BusRoutes[h][2], BusRoutes[h][3], BusRoutes[h][4], BusRoutes[h][5], 0);
        CreateDynamicPickup(1239, 1, BusRoutes[h][0], BusRoutes[h][1], BusRoutes[h][2]-0.2);
        CreateDynamicMapIcon(BusRoutes[h][0], BusRoutes[h][1], BusRoutes[h][2], 8, COLOR_YELLOW);
	}
}
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(IsPlayerNPC(playerid)) return 1;
	switch(newstate)
	{
		case PLAYER_STATE_DRIVER:
		{
		    new idcar = GetPlayerVehicleID(playerid);
		    if(idcar == BotBus && !IsPlayerNPC(playerid) && GetPVarInt(playerid, "Admin") < 10)
		    {
				KickEx(playerid);
				RemovePlayerFromVehicle(IsNPC("BusDriver"));
				return PutPlayerInVehicle(IsNPC("BusDriver"),BotBus,0);
		    }
		    if(idcar == BotBus2 && !IsPlayerNPC(playerid) && GetPVarInt(playerid, "Admin") < 10)
		    {
				KickEx(playerid);
				RemovePlayerFromVehicle(IsNPC("BusDriver2"));
				return PutPlayerInVehicle(IsNPC("BusDriver2"),BotBus2,0);
		    }
		    if(idcar == BotTrain && !IsPlayerNPC(playerid) && GetPVarInt(playerid, "Admin") < 10)
		    {
				KickEx(playerid);
				RemovePlayerFromVehicle(IsNPC("Trainbot"));
				return PutPlayerInVehicle(IsNPC("Trainbot"),BotTrain,0);
		    }
		    if(idcar == BotPlane && !IsPlayerNPC(playerid) && GetPVarInt(playerid, "Admin") < 10)
		    {
				KickEx(playerid);
				RemovePlayerFromVehicle(IsNPC("airplanebot"));
				return PutPlayerInVehicle(IsNPC("airplanebot"),BotPlane,0);
		    }
    	}
   		case PLAYER_STATE_PASSENGER:
		{
	    	if(GetPlayerVehicleID(playerid) == BotBus || GetPlayerVehicleID(playerid) == BotBus2)
			{
				if(GetPlayerMoney(playerid) >= 3)
	   			{
					GivePlayerMoney(playerid,-3);
	    			GameTextForPlayer(playerid, "~r~-$3.", 5000, 1);
	    		}
			    else
			    {
	  				SendClientMessage(playerid,COLOR_WHITE,"The bus driver kicked you off the bus because you could not afford the 3$ fare.");
	      			RemovePlayerFromVehicle(playerid);
    			}
  			}
			if(GetPlayerVehicleID(playerid) == BotTrain)
			{
				if(GetPlayerMoney(playerid) >= 50)
	   			{
					GivePlayerMoney(playerid,-50);
	    			GameTextForPlayer(playerid, "~r~-$50.", 5000, 1);
	    		}
			    else
			    {
	  				SendClientMessage(playerid,COLOR_WHITE,"The train driver kicked you off the train because you could not afford the 50$ fare.");
	      			RemovePlayerFromVehicle(playerid);
    			}
   			}
		}
	}
	return 1;
}
hook OnPlayerRequestClass(playerid,classid)
{
	if(IsPlayerNPC(playerid))
	{
	    if(strcmp(GetPlayerNameEx(playerid),"BusDriver",true) == 0) SetSpawnInfo(playerid,69,20,1172.5,-1795.5,13.1,0.0,-1,-1,-1,-1,-1,-1), PutPlayerInVehicle(playerid,BotBus,0), SetPlayerColor(playerid, COLOR_WHITE);
		if(strcmp(GetPlayerNameEx(playerid),"BusDriver2",true) == 0) SetSpawnInfo(playerid,69,20,1181.4955,-1798.0479,13.5006,359.7428,-1,-1,-1,-1,-1,-1), PutPlayerInVehicle(playerid,BotBus2,0), SetPlayerColor(playerid, COLOR_WHITE);
		if(strcmp(GetPlayerNameEx(playerid),"Trainbot",true) == 0) SetSpawnInfo(playerid,69,253,-1941.9301,185.4146,25.7109,355.1588,-1,-1,-1,-1,-1,-1), PutPlayerInVehicle(playerid,BotTrain,0), SetPlayerColor(playerid, COLOR_WHITE);
		if(strcmp(GetPlayerNameEx(playerid),"airplanebot",true) == 0) SetSpawnInfo(playerid,69,20,2057.9417,-2485.7690,14.7389,90.7354,-1,-1,-1,-1,-1,-1), PutPlayerInVehicle(playerid,BotPlane,0), SetPlayerColor(playerid, COLOR_WHITE);
    }
	return 1;
}
forward OneMinTimer();
public OneMinTimer()
{
	if(GetPlayerVehicleID(IsNPC("BusDriver")) != BotBus)
	{
 		RemovePlayerFromVehicle(IsNPC("BusDriver"));
		PutPlayerInVehicle(IsNPC("BusDriver"),BotBus,0);
	}
	if(GetPlayerVehicleID(IsNPC("BusDriver2")) != BotBus2)
	{
 		RemovePlayerFromVehicle(IsNPC("BusDriver2"));
		PutPlayerInVehicle(IsNPC("BusDriver2"),BotBus2,0);
	}
	if(GetPlayerVehicleID(IsNPC("Trainbot")) != BotTrain)
	{
 		RemovePlayerFromVehicle(IsNPC("Trainbot"));
   		PutPlayerInVehicle(IsNPC("Trainbot"),BotTrain,0);
	}
	if(GetPlayerVehicleID(IsNPC("airplanebot")) != BotPlane)
	{
 		RemovePlayerFromVehicle(IsNPC("airplanebot"));
  		PutPlayerInVehicle(IsNPC("airplanebot"),BotPlane,0);
	}
	return 1;
}
forward LoadBots(number);
public LoadBots(number)
{
	if(number == 255) return 0;
	switch(BotLoad)
	{
	    case 0:
	    {
	        printf("Bots loading, beginning...");
	        SetTimerEx("LoadBots", 2000, false, "i", 0);
	        BotLoad++;
	    }
	    case 1:
	    {
	        printf("Loading Bot Number 1");
	        ConnectNPC("BusDriver","busroute");
	        SetTimerEx("LoadBots", 2000, false, "i", 0);
	        BotLoad++;
	    }
	    case 2:
	    {
	        printf("Loading Bot Number 2");
	        ConnectNPC("BusDriver2","busroute2");
	        SetTimerEx("LoadBots", 2000, false, "i", 0);
	        BotLoad++;
		}
		case 3:
  		{
  			printf("Loading Bot Number 3");
	        ConnectNPC("Trainbot","train_lv");
	        SetTimerEx("LoadBots", 2000, false, "i", 0);
	        BotLoad++;
     	}
		case 4:
		{
			printf("Loading Bot Number 4");
	        ConnectNPC("airplanebot","airplanebot");
	        BotLoad=0;
	        printf("Bots loading, ended.");
	    }
	}
	return true;
}
stock IsNPC(name[])
{
	new sendername[MAX_PLAYER_NAME];
    for(new i=0; i<MAX_PLAYERS; i++)
    {
	    if(IsPlayerNPC(i))
        {
            format(sendername, sizeof(sendername), "%s", GetPlayerNameEx(i));
            if(strcmp(sendername,name,true) == 0) return i;
        }
    }
    return INVALID_PLAYER_ID;
}

CMD:fixbots(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 2) return SendErrorMessage(playerid,"You are not authorized to use this CMD.");
    {
        RemovePlayerFromVehicle(IsNPC("BusDriver"));
        RemovePlayerFromVehicle(IsNPC("BusDriver2"));
        RemovePlayerFromVehicle(IsNPC("Trainbot"));
        PutPlayerInVehicle(IsNPC("BusDriver"),BotBus,0);
        PutPlayerInVehicle(IsNPC("BusDriver2"),BotBus2,0);
        PutPlayerInVehicle(IsNPC("Trainbot"),BotTrain,0);
    }
	return 1;
}

