
/*public Streamer_OnPluginError(error[]) {

 	if(strfind(error, "Streamer_GetIntData: Invalid", true) != -1) return 0;
 	return 1;
}*/
forward GOVDoorClose();
public GOVDoorClose()
{
	MoveDynamicObject(GOVDoor[0],1427.1683300,1597.3068800,18.5290100,2);
	MoveDynamicObject(GOVDoor[1],1427.1567400,1600.4644800,18.5290100,2);
}
forward CloseCellDoorLSPD();
public CloseCellDoorLSPD()
{
	MoveDynamicObject(LSPDCellDoor[0],1614.72595,1605.28540,11.08160,2);
}
forward FSDoorClose1();
public FSDoorClose1()
{
	MoveDynamicObject(FireStationDoor[0],1330.29980,-1311.07874,18.67140,4);
}
forward FSGarageClose6();
public FSGarageClose6()
{
	MoveDynamicObject(FireStationGarage[5],1332.57336,-1376.89954,14.49830,2);
	FireStationGarageDoor[5] = 0;
}
forward FSGarageClose5();
public FSGarageClose5()
{
	MoveDynamicObject(FireStationGarage[4],1332.52222,-1367.37610,14.49830,2);
	FireStationGarageDoor[4] = 0;
}
forward FSGarageClose4();
public FSGarageClose4()
{
	MoveDynamicObject(FireStationGarage[3],1332.57336,-1357.82019,14.49830,2);
	FireStationGarageDoor[3] = 0;
}
forward FSGarageClose3();
public FSGarageClose3()
{
	MoveDynamicObject(FireStationGarage[2],1293.34998, -1376.89954, 14.49830,2);
	FireStationGarageDoor[2] = 0;
	PlaySoundInArea(1153,1293.34998, -1376.89954, 14.49830,20.0);
}
forward FSGarageClose2();
public FSGarageClose2()
{
	MoveDynamicObject(FireStationGarage[1],1293.34998,-1367.37610,14.49830,2);
	FireStationGarageDoor[1] = 0;
	PlaySoundInArea(1153,1293.34998,-1367.37610,14.49830,20.0);
}
forward FSGarageClose1();
public FSGarageClose1()
{
	MoveDynamicObject(FireStationGarage[0],1293.34998,-1357.82019,14.49830,2);
	FireStationGarageDoor[0] = 0;
	PlaySoundInArea(1153,1293.34998,-1357.82019,14.49830,20.0);
}
forward HRightCloseDoor();
public HRightCloseDoor()
{
	MoveDynamicObject(HospitalDoor[0],2376.6257,2650.9097,8000.1216,4);
}
forward HLeftCloseDoor();
public HLeftCloseDoor()
{
	MoveDynamicObject(HospitalDoor[1],2387.8789,2651.0198,8000.1504,4);
}
forward CloseRightDoor();
public CloseRightDoor()
{
	MoveDynamicObject(rightmovedoor,1617.676,1594.660,9.776,4);
}
forward CloseLeftDoor();
public CloseLeftDoor()
{
	MoveDynamicObject(leftmovedoor,1617.656,1579.298,9.776,4);
}
forward DoorOpen(playerid);
public DoorOpen(playerid)
{
	  MoveDynamicObject(lspddoor1, 247.2763671875,72.536186218262,1002.640625, 3.5000);
	  MoveDynamicObject(lspddoor2, 244.0330657959,72.580932617188,1002.640625, 3.5000);
	  return 1;
}
forward DoorClose(playerid);
public DoorClose(playerid)
{
	  MoveDynamicObject(lspddoor1, 246.35150146484,72.547714233398,1002.640625, 3.5000);
	  MoveDynamicObject(lspddoor2, 245.03300476074,72.568511962891,1002.640625, 3.5000);
	  return 1;
}

forward CloseWestLobby();
public CloseWestLobby()
{
	MoveDynamicObject(westlobby1,239.71582031,116.09179688,1002.21502686,4);
	MoveDynamicObject(westlobby2,239.67968750,119.09960938,1002.21502686,4);
	return 1;
}

forward CloseEastLobby();
public CloseEastLobby()
{
	MoveDynamicObject(eastlobby1,253.14941406,110.59960938,1002.21502686,4);
	MoveDynamicObject(eastlobby2,253.18457031,107.59960938,1002.21502686,4);
	return 1;
}

forward CloseCage();
public CloseCage()
{
   	MoveDynamicObject(cage,-773.52050781,2545.62109375,10022.29492188,2);
	return 1;
}

forward CloseLocker();
public CloseLocker()
{
	MoveDynamicObject(locker1,267.29980469,112.56640625,1003.61718750,4);
	MoveDynamicObject(locker2,264.29980469,112.52929688,1003.61718750,4);
	return 1;
}

forward CloseEntranceDoor();
public CloseEntranceDoor()
{
    MoveDynamicObject(entrancedoor,-766.27539062,2536.58691406,10019.5,2);
	return 1;
}

forward CloseCCTV();
public CloseCCTV()
{
	MoveDynamicObject(cctv1,264.44921875,115.79980469,1003.61718750,4);
	MoveDynamicObject(cctv2,267.46875000,115.83691406,1003.61718750,4);
	return 1;
}

forward CloseChief();
public CloseChief()
{
	MoveDynamicObject(chief1,229.59960938,119.50000000,1009.21875000,4);
	MoveDynamicObject(chief2,232.59960938,119.53515625,1009.21875000,4);
	return 1;
}

forward CloseSASDNew1();
public CloseSASDNew1()
{
	MoveDynamicObject(SASDDoors[0], 14.92530, 53.51950, 996.84857, 4, 0.00000, 0.00000, 90.00000);
	return 1;
}

forward CloseSASDNew2();
public CloseSASDNew2()
{
	MoveDynamicObject(SASDDoors[1], 8.70370, 57.32530, 991.03699, 4, 0.00000, 0.00000, 270.00000);
	return 1;
}

forward CloseSASD1();
public CloseSASD1()
{
	MoveDynamicObject(sasd1A,2511.65332031,-1697.00976562,561.79223633,4);
	MoveDynamicObject(sasd1B,2514.67211914,-1696.97485352,561.79223633,4);
	return 1;
}

forward CloseSASD2();
public CloseSASD2()
{
	MoveDynamicObject(sasd2A,2516.87548828,-1697.01525879,561.79223633,4);
	MoveDynamicObject(sasd2B,2519.89257812,-1696.97509766,561.79223633,4);
	return 1;
}

forward CloseSASD3();
public CloseSASD3()
{
	MoveDynamicObject(sasd3A,2522.15600586,-1697.01550293,561.79223633,4);
	MoveDynamicObject(sasd3B,2525.15893555,-1696.98010254,561.79223633,4);
	return 1;
}

forward CloseSASD4();
public CloseSASD4()
{
	MoveDynamicObject(sasd4A,2511.84130859,-1660.08081055,561.79528809,4);
	MoveDynamicObject(sasd4B,2514.81982422,-1660.04650879,561.80004883,4);
	return 1;
}

forward CloseSASD5();
public CloseSASD5()
{
	MoveDynamicObject(sasd5A,2522.86059570,-1660.07177734,561.80206299,4);
	MoveDynamicObject(sasd5B,2519.84228516,-1660.10888672,561.80004883,4);
	return 1;
}

forward CloseFBILobbyLeft();
public CloseFBILobbyLeft()
{
	MoveDynamicObject(FBILobbyLeft,295.40136719,-1498.43457031,-46.13965225,4);
	return 1;
}

forward CloseFBILobbyRight();
public CloseFBILobbyRight()
{
	MoveDynamicObject(FBILobbyRight,302.39355469,-1521.62988281,-46.13965225,4);
	return 1;
}

forward CloseFBIPrivate();
public CloseFBIPrivate()
{
	MoveDynamicObject(FBIPrivate[0],299.29986572,-1492.82666016,-28.73300552,4);
	MoveDynamicObject(FBIPrivate[1],299.33737183,-1495.83911133,-28.73300552,4);
	return 1;
}

forward SFPDDoors(doorid, status);
public SFPDDoors(doorid, status)
{
	if(doorid == 0) // Chief
	{
		if(status == 0) MoveDynamicObject(SFPDHighCMDDoor[0], -1578.19397, 702.29370, 18.64510, 0.9);
		if(status == 1) MoveDynamicObject(SFPDHighCMDDoor[0], -1579.6340, 702.2937, 18.6451, 0.9);
	}
	if(doorid == 1) // Deputy Chief
	{
		if(status == 0) MoveDynamicObject(SFPDHighCMDDoor[1], -1578.26196, 696.84729, 18.64510, 0.9);
		if(status == 1) MoveDynamicObject(SFPDHighCMDDoor[1], -1579.7220, 696.8473, 18.6451, 0.9);
	}
	if(doorid == 2) // Commander
	{
		if(status == 0) MoveDynamicObject(SFPDHighCMDDoor[2], -1587.77795, 697.84589, 18.64510, 0.9);
		if(status == 1) MoveDynamicObject(SFPDHighCMDDoor[2], -1589.2380, 697.8459, 18.6451, 0.9);
	}
	if(doorid == 3) // Lobby 1
	{
		if(status == 0) MoveDynamicObject(SFPDLobbyDoor[0], -1602.26709, 704.99298, 12.85020, 0.9);
		if(status == 1) MoveDynamicObject(SFPDLobbyDoor[0], -1602.2671, 706.3130, 12.8502, 0.9);
	}
	if(doorid == 4) // Lobby 2
	{
		if(status == 0) MoveDynamicObject(SFPDLobbyDoor[1], -1598.17004, 702.68219, 12.85020, 0.9);
		if(status == 1) MoveDynamicObject(SFPDLobbyDoor[1], -1599.4900, 702.6822, 12.8502, 0.9);
	}
	return 1;
}
forward StopPlayAudio(playerid);
public StopPlayAudio(playerid)
{
    new Float:X, Float:Y, Float:Z;
	PlaySoundInArea(1154, X, Y, Z, 20.0);
}
