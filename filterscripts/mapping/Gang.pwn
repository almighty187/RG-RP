#include <a_samp>
#include <streamer>
#include <YSI\y_iterate>

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
			CallRemoteFunction("Player_StreamPrep", "ifffi", i, fPlayerPos[0], fPlayerPos[1], fPlayerPos[2], 2500);
		}
	}
	return 1;
}

public OnFilterScriptExit()
{
	foreach(new i : Player)
	{
		if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0) TogglePlayerControllable(i, false);
	}
	return 1;
}