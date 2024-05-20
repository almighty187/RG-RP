#include <YSI\y_hooks>

hook OnGameModeInit() {

	print("[Streamer] Loading Dynamic Pickups...");
	
	CreateDynamicPickup(1239, 23, -4429.944824, 905.032470, 987.078186, -1); // VIP Garage Travel
	CreateDynamicPickup(1239, 23, 757.3734,5.7227,1000.7012, -1); // Train Pos
	CreateDynamicPickup(1239, 23, 758.43,-78.0,1000.65, -1); // Train Pos (MALL GYM)
	CreateDynamicPickup(1240, 23, 1179.4012451172,-1331.5632324219,2423.0461425781, -1);// /healme//Old Healme: 2103.4998,2824.2568,-16.1672
	CreateDynamicPickup(1239, 23, 1169.7209472656,-1348.3218994141,2423.0461425781, -1);// /Old Insurance: 2086.4915,2826.7122,-16.1744
    CreateDynamicPickup(1210, 23, 63.973995, 1973.618774, -68.786064, -1); //Hitman Pickup
	CreateDynamicPickup(371, 23, 1544.2,-1353.4,329.4); //LS towertop
	CreateDynamicPickup(1239, 23, 2103.6714,-1785.5222,12.9849, -1); // Idlewood /getpizza
	CreateDynamicPickup(371, 23, 1536.0, -1360.0, 1150.0); // LS towertop
	CreateDynamicPickup(2485, 23, 2958.2200, -1339.2900, 5.2100, 1);// NGGShop - Car Shop
	CreateDynamicPickup(1239, 23, 2950.4014, -1283.0776, 4.6875, 1);// NGGShop - Plane Shop
	CreateDynamicPickup(1239, 23, 2974.7520, -1462.9265, 2.8184, 1);// NGGShop - Boat Shop
	CreateDynamicPickup(1314, 23, 2939.0134, -1401.2946, 11.0000, 1);// NGGShop - VIP Shop
	CreateDynamicPickup(1272, 23, 2938.2734, -1391.0596, 11.0000, 1);// NGGShop - House Shop
	CreateDynamicPickup(1239, 23, 2939.8442, -1411.2906, 11.0000, 1);// NGGShop - Misc Shop
	CreateDynamicPickup(1239, 23, 2927.5000, -1530.0601, 11.0000, 1);// NGGShop - ATM
	CreateDynamicPickup(1239, 23, 2958.0425, -1393.6724, 5.5500, 1);// NGGShop - Hotdog Stand
	CreateDynamicPickup(1241, 23, 2946.8672, -1484.9561, 11.0000, 1);// NGGShop - Healthcare
	CreateDynamicPickup(1239, 23, 2937.2878, -1357.2294, 11.0000, 1);// NGGShop - Gift Reset
	CreateDynamicPickup(1239, 23, -29.0583, -185.1300, 1003.5469, 1);// 24/7

	print("[Streamer] Dynamic Pickups have been loaded.");	
	return 1;
}
