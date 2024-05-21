#define YSI_NO_HEAP_MALLOC
#define YSI_NO_MODE_CACHE
#define YSI_NO_OPTIMISATION_MESSAGE
#define YSI_NO_VERSION_CHECK

#include <a_samp>
#include <streamer>
#include <YSI\y_iterate>

public OnFilterScriptExit()
{
    foreach(new i : Player)
	{
	    if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0) TogglePlayerControllable(i, false);
	}
	return 1;
}

public OnFilterScriptInit()
{
    foreach(new i : Player)
	{
	    if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0) TogglePlayerControllable(i, false);
	}
	// Add mapping below

	new Float: fPlayerPos[3];
	
	foreach(new i : Player)
	{
	    if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0)
		{
			GetPlayerPos(i, fPlayerPos[0], fPlayerPos[1], fPlayerPos[2]);
			Streamer_UpdateEx(i, fPlayerPos[0], fPlayerPos[1], fPlayerPos[2]);
			//SetPlayerPos(i, fPlayerPos[0], fPlayerPos[1], fPlayerPos[2] + 2.5);
			//TogglePlayerControllable(i, true);
			CallRemoteFunction("Player_StreamPrep", "ifffi", i, fPlayerPos[0], fPlayerPos[1], fPlayerPos[2], 2500);
		}
	}
	// Headroom for static objects - streamed limits are completely independent (cause of old crashing)
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 965);
	return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) // Calling Fix by Winterfield - Do not remove
{
	CallRemoteFunction("OnPlayerEditGate", "iddffffff", playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
}
/*
public OnPlayerConnect(playerid)
{
	return 1;
}
*/