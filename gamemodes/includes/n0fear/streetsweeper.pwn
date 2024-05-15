#include <YSI\y_hooks>

hook OnPlayerEnterCheckpoint(playerid)
{
    if(GetPVarInt(playerid, "pSweeperRun") >= 1)
	{
		if(IsInSweeperCar(GetPlayerVehicleID(playerid)))
		{
			if(GetPVarInt(playerid, "pSweeperStage") <= 4)
			{
		    	TogglePlayerControllable(playerid, false);
		    	//GameTextForPlayer(playerid, "~W~LOADING...", 5000, 4);
		    	SetTimerEx("SweeperJobLoad", 0, false, "i", playerid);
			}
			else if(GetPVarInt(playerid, "pSweeperStage") >= 5)
			{
			    new value = 350+random(350);

		    	SetVehicleToRespawn(GetPlayerVehicleID(playerid));

		    	DeletePVar(playerid, "pSweeperRun");
       			DeletePVar(playerid, "pSweeperStage");

       			DisablePlayerCheckpoint(playerid);

       			GivePlayerCash(playerid, value);

       			format(szMiscArray, sizeof(szMiscArray), "You have completed your sweeper run and earned $%s.", number_format(value));
				SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
			}
		}
		else SendErrorMessage(playerid, "You must be on Mountain bike!");
	}
 	return 1;
}

CMD:sweeprun(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == 10 || PlayerInfo[playerid][pJob2] == 10 || PlayerInfo[playerid][pJob3] == 10)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsInSweeperCar(vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        if(GetPVarInt(playerid, "pSweeperRun") <= 0)
	        {
	        	if(CheckPointCheck(playerid)) cmd_killcheckpoint(playerid, params);

                SetPVarInt(playerid, "pSweeperRun", 1);
                DeletePVar(playerid, "pSweeperStage");
                SetPVarInt(playerid, "pSweeperPath", random(5));

                SendServerMessage(playerid, "You have started a sweeper run, make your way to your first destination.");
                AdvanceSweeperJob(playerid);
 			}
	        else return SendErrorMessage(playerid, "You are already on a sweeper run!");
	    }
	    else return SendErrorMessage(playerid, "You must be in Sweeper car to start the job!");
	}
	else SendErrorMessage(playerid, "You are not a Street Sweeper!");
	return 1;
}

AdvanceSweeperJob(playerid)
{
    switch(GetPVarInt(playerid, "pSweeperPath"))
    {
        case 0:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1595.1052,-1870.5671,13.4269, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1571.9523,-1819.4336,13.4246, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1551.3260,-1730.5820,13.4252, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1532.0776,-1653.8649,13.4246, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1522.8647,-1590.5067,13.4236, 4.0);

		    }
		}
		case 1:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1467.0149,-1590.3712,13.4246, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1438.7471,-1543.7001,13.4133, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1457.5648,-1444.8993,13.4270, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1457.9678,-1346.6843,13.4247, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1457.0049,-1235.2194,13.4250, 4.0);
		    }
		}
		case 2:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1465.1953,-1162.8553,23.7467, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1547.5579,-1163.8867,23.9481, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1932.9868,-1138.6798,25.1824, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1638.6577,-1164.2731,23.9381, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1744.3297,-1164.9761,23.6706, 4.0);

		    }
		}
		case 3:
  		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1800.8989,-1178.0505,23.6852, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1869.4014,-1159.9260,23.7271, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1932.9868,-1138.6798,25.1824, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 2037.0686,-1137.7787,24.3242, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 2064.4150,-1202.4824,23.7941, 4.0);

		    }
		}
		case 4:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 2066.0974,-1260.8798,23.8621, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 2066.6521,-1319.8008,23.8621, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 2089.9651,-1386.1841,23.8668, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 2109.3987,-1462.9137,23.8744, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 2110.7954,-1538.1327,24.2450, 4.0);
		    }
		}
		case 5:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 2110.7957,-1615.4230,23.5719, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 2082.7737,-1774.1697,13.4239, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 2078.4014,-1844.9423,13.4245, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 2079.6714,-1914.6610,13.3914, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 2010.3566,-1929.3427,13.3672, 4.0);
		    }
		}
		case 6:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1976.8147,-1929.6732,13.4246, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1964.7052,-1867.6276,13.4246, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1965.1771,-1797.9658,13.4248, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1936.0574,-1776.2825,13.4249, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1944.4742,-1719.2789,13.4295, 4.0);

		    }
		}
		case 7:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1943.9652,-1651.2876,13.4246, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1914.8950,-1610.3400,13.4246, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1825.7026,-1610.6970,13.4192, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1724.7396,-1591.4119,13.4103, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1688.4008,-1625.4951,13.4246, 4.0);

		    }
		}
		case 8:
		{
		    switch(GetPVarInt(playerid, "pSweeperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1687.5635,-1685.4110,13.4246, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1650.2660,-1729.6528,13.4245, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1553.7750,-1783.5990,13.5888, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1516.2820,-1870.6813,13.4246, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1428.7806,-1881.8756,13.4242, 4.0);
		    }
		}
    }
	return 1;
}

forward SweeperJobLoad(playerid);
public SweeperJobLoad(playerid)
{
	SetPVarInt(playerid, "pSweeperStage", GetPVarInt(playerid, "pSweeperStage")+1);

    TogglePlayerControllable(playerid, true);

    if(GetPVarInt(playerid, "pSweeperStage") != 5)
    {
    	AdvanceSweeperJob(playerid);
	}
	else
	{
	    SetPlayerCheckpoint(playerid, 1619.8906,-1888.1641,13.2668, 4.0); // return to hq
	    SendClientMessageEx(playerid, COLOR_WHITE, "You're done, make your way back to headquarters.");
	}
    return 1;
}
