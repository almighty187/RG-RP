////////////////////////////////////////////
///////////////                        /////
/////////////// This is made by N0FeaR /////
/////////////// DO NOT REMOVE THIS     /////
////////////////////////////////////////////
#include <YSI\y_hooks>

hook OnPlayerEnterCheckpoint(playerid)
{
    if(GetPVarInt(playerid, "pPaperRun") >= 1)
	{
		if(IsInPaperBike(GetPlayerVehicleID(playerid)))
		{
			if(GetPVarInt(playerid, "pPaperStage") <= 4)
			{
		    	TogglePlayerControllable(playerid, false);
		    	GameTextForPlayer(playerid, "~W~LOADING...", 5000, 4);
		    	SetTimerEx("PaperJobLoad", 4000, false, "i", playerid);
			}
			else if(GetPVarInt(playerid, "pPaperStage") >= 5)
			{
			    new value = 500+random(500);

		    	SetVehicleToRespawn(GetPlayerVehicleID(playerid));

		    	DeletePVar(playerid, "pPaperRun");
       			DeletePVar(playerid, "pPaperStage");

       			DisablePlayerCheckpoint(playerid);

       			GivePlayerCash(playerid, value);

       			format(szMiscArray, sizeof(szMiscArray), "You have completed your paper run and earned $%s.", number_format(value));
				SendClientMessageEx(playerid, COLOR_WHITE, szMiscArray);
			}
		}
		else SendErrorMessage(playerid, "You must be on Mountain bike!");
	}
 	return 1;
}

CMD:paperrun(playerid, params[])
{
	if(PlayerInfo[playerid][pJob] == 5 || PlayerInfo[playerid][pJob2] == 5 || PlayerInfo[playerid][pJob3] == 5)
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if(IsInPaperBike(vehicleid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	    {
	        if(GetPVarInt(playerid, "pPaperRun") <= 0)
	        {
	        	if(CheckPointCheck(playerid)) cmd_killcheckpoint(playerid, params);

                SetPVarInt(playerid, "pPaperRun", 1);
                DeletePVar(playerid, "pPaperStage");
                SetPVarInt(playerid, "pPaperPath", random(5));

                SendServerMessage(playerid, "You have started a paper run, make your way to your first destination.");
                AdvancePaperJob(playerid);
 			}
	        else return SendErrorMessage(playerid, "You are already on a paper run!");
	    }
	    else return SendErrorMessage(playerid, "You must be on Mountain bike to start the job!");
	}
	else SendErrorMessage(playerid, "You are not a Paper Boy!");
	return 1;
}

AdvancePaperJob(playerid)
{
    switch(GetPVarInt(playerid, "pPaperPath"))
    {
        case 0:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 805.4839,-1058.2368,24.3222, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 874.7229,-983.2000,35.4573, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 914.3572,-999.2832,37.6942, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1422.4210,-1552.9374,13.1449, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1398.5776,-1581.8378,13.1560, 4.0);

		    }
		}
		case 1:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 951.4673,-978.8049,38.4598, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1050.8234,-1047.9172,31.4130, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1171.2419,-1073.8776,27.4339, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1323.5900,-1558.3086,13.1392, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1287.3334,-1581.9384,13.1538, 4.0);
		    }
		}
		case 2:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1194.1915,-1133.8517,23.4960, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1366.0441,-1280.5546,13.1522, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1367.4510,-1319.2455,13.1488, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1217.4142,-1580.2505,13.0999, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1173.1482,-1564.3854,13.1489, 4.0);

		    }
		}
		case 3:
  		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1408.1993,-1386.9165,13.1698, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1389.4108,-1440.1152,13.3170, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1519.3158,-1448.1532,13.1402, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1155.9686,-1507.4510,15.3930, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1152.3940,-1457.2120,15.5892, 4.0);

		    }
		}
		case 4:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1446.1365,-1426.8724,13.1530, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1461.3047,-1469.8700,13.1643, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1449.0889,-1540.6141,13.1563, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 1052.8242,-1417.8198,13.1460, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 1023.0935,-1389.5673,12.9438, 4.0);
		    }
		}
		case 5:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1513.5356,-1564.7639,13.1759, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1536.7657,-1669.2133,12.9814, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1488.4386,-1766.6492,13.1507, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 910.6768,-1384.2383,13.1217, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 815.9489,-1388.3882,13.2339, 4.0);
		    }
		}
		case 6:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1575.2687,-1820.0454,13.1204, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1561.2257,-1853.3564,13.1639, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1682.3429,-1834.7040,13.1525, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 788.7341,-1435.3622,13.1519, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 776.1613,-1510.1405,13.1510, 4.0);

		    }
		}
		case 7:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1828.9103,-1842.1254,13.1891, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1848.8959,-1925.4718,13.1459, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1913.7893,-1924.9354,13.1413, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 779.5870,-1572.0197,13.1332, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 689.9198,-1594.3705,13.7078, 4.0);

		    }
		}
		case 8:
		{
		    switch(GetPVarInt(playerid, "pPaperStage"))
		    {
		        case 0: SetPlayerCheckpoint(playerid, 1978.5759,-1996.5696,13.1479, 4.0);
		        case 1: SetPlayerCheckpoint(playerid, 1894.3496,-2058.5894,13.1449, 4.0);
		        case 2: SetPlayerCheckpoint(playerid, 1803.7946,-2120.3755,13.1633, 4.0);
		        case 3: SetPlayerCheckpoint(playerid, 650.6998,-1579.6278,15.0564, 4.0);
		        case 4: SetPlayerCheckpoint(playerid, 507.9031,-1359.0020,15.5589, 4.0);
		    }
		}
    }
	return 1;
}

forward PaperJobLoad(playerid);
public PaperJobLoad(playerid)
{
	SetPVarInt(playerid, "pPaperStage", GetPVarInt(playerid, "pPaperStage")+1);

    TogglePlayerControllable(playerid, true);

    if(GetPVarInt(playerid, "pPaperStage") != 5)
    {
        new string[128];
    	AdvancePaperJob(playerid);
		format(string, sizeof(string), "{FF8000}** {C2A2DA}%s throws a newspaper at the side of the establishment.", GetPlayerNameEx(playerid));
		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else
	{
	    SetPlayerCheckpoint(playerid, 762.8881,-1031.4021,23.9630, 4.0); // return to hq
	    SendServerMessage(playerid, "You're out of paper, make your way back to headquarters.");
	}
    return 1;
}
