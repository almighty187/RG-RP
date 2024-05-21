#include <a_samp>
#include <streamer>

public OnFilterScriptInit()
{
	// Add mapping below

	// Headroom for static objects - streamed limits are completely independent (cause of old crashing)
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 965);
}

public OnPlayerConnect(playerid)
{
	RemoveBuildingsFromPlayer(playerid);
	return 1;
}

stock RemoveBuildingsFromPlayer(playerid)
{
	if(GetPVarInt(playerid, "BuildingRemoved") == 0)
	{
		// Added removed objects below

		SetPVarInt(playerid, "BuildingRemoved", 1);
	}
	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) // Calling Fix by Winterfield - Do not remove
{
	CallRemoteFunction("OnPlayerEditGate", "iddffffff", playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
}