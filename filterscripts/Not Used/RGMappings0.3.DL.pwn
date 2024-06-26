#include <a_samp>
#include <streamer>
#include <YSI\y_iterate>

public OnFilterScriptInit()
{
    print("[Streamer] Loading 0.3.DL Dynamic Objects...");
   	CreateDynamicObject(-2044,2150.1335400,-1727.7409700,14.4860000,0.0000000,0.0000000,90.0000000); // Idlewood gas
	CreateDynamicObject(-2043,1995.0156300,-1198.3515600,21.1093800,0.0000000,0.0000000,0.0000000); // Glen Park 2
	CreateDynamicObject(-2042, 1914.03125, -1198.32813, 19.59375, 0.000000, 0.000000, 0.000000); // Glen Park 1
	CreateDynamicObject(-2041, 2222.99219, -1162.60156, 30.03906, 0.000000, 0.000000, 0.000000); // Jefferson Motel
	//CreateDynamicObject(-2038, 2317.51563, -1639.94531, 18.24219, 0.000000, 0.000000, 0.000000); // Ganton Bar Building
	//CreateDynamicObject(-2039, 2318.14844, -1645.46094, 20.17969, 0.000000, 0.000000, 0.000000); // Ganton Bar Sign
	//CreateDynamicObject(-2040, 2318.17188, -1645.46094, 20.17969, 0.000000, 0.000000, 0.000000); // Ganton Bar Windows
	CreateDynamicObject(-20029, 1938.09, -1789.227, 13.489, 0.000000, 0.000000, -175.300000, -1, -1, -1, 100.0); // Sprunk gas station
	CreateDynamicObject(-2036, 1834.1796900, -1844.0781300, 12.5703100, 0.000000, 0.000000, 90.300000);// 24/7 Store left door
	CreateDynamicObject(-2037, 1834.1796900, -1841.0625000, 12.5703100, 0.000000, 0.000000, 89.600000);// 24/7 Store right door
	CreateDynamicObject(-2035, 1315.3671900, -887.4687500, 41.7031300, 0.000000, 0.000000, 0.000000);// 24/7 Store Mullaholland
	CreateDynamicObject(-2034, 1845.7890600, -1855.6484400, 15.9843800, 0.000000, 0.000000, 0.000000); // 24/7 Store Unity
	CreateDynamicObject(-2031, 2265.612, -1677.887, 17.59, 0.000000, 0.000000, 0.000000); // Binco Temple
	CreateDynamicObject(-2030, 2112.878, -1797.031, 19.317, 0.000000, 0.000000, 0.000000); // Pizza Stack
	CreateDynamicObject(-20028, -1857.496582, 2653.477539, 2.589298, 0.000000, 0.000000, 90.000000);
	CreateDynamicObject(-20028, -1857.522827, 2685.821533, 2.589298, 0.000000, 0.000000, 90.000000);
    CreateDynamicObject(-20028, -1867.691894, 2664.840576, 2.589298, 0.000000, 0.000000, -90.000000);
	CreateDynamicObject(-20028, -1867.705932, 2676.008300, 2.589298, 0.000000, 0.000000, -90.000000);
	CreateDynamicObject(-20028, 1477.8000000, -1709.2000000, 12.3000000, 0.0000000, 0.0000000, 180.0000000);
	CreateDynamicObject(-20029, 1471.004, -1723.58, 18.093, 0.0000000, 0.0000000, 0.0000000);
 	CreateDynamicObject(-20029, 2325.949,-1644.961,14.917,0.0000000,0.0000000,0.0000000);
 	CreateDynamicObject(-20028, 2275.983398, -1675.115234, 14.365900, 0.000000, 0.000000, 90.000000);
	CreateDynamicObject(-20028,1699.6041260,-2201.1948242,38.3802719,0.0000000,0.0000000,0.2500000, .interiorid = 4, .worldid = 45, .streamdistance = 100);
	print("[Streamer] Dynamic 0.3.DL Objects has been loaded.");
	return 1;
}

