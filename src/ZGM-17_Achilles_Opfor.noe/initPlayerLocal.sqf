#include "paramDefault.hpp"

private _is_curator = (str player == "bis_curatorUnit");

// mission params init
private _respawnDelay = ["PlayerRespawnDelay", DEFAULT_PLAYER_RESPAWN_DELAY] call BIS_fnc_getParamValue;
if(_respawnDelay != DEFAULT_PLAYER_RESPAWN_DELAY) then {setPlayerRespawnTime _respawnDelay};

if (_is_curator) then
{
	// set random position for curator camera
	waitUntil {not isNull curatorCamera and {not isNil {bis_curator getVariable "CAM_POS_ATL"}}};
	_cam_pos = bis_curator getVariable "CAM_POS_ATL";
	_cam_pos set [2, 50];
	curatorCamera setPosATL _cam_pos;
	curatorCamera setDir random 360;

	#include "scripts\R3F_LOG\initCurator.hpp"
} else
{
	if (isMultiplayer) then
	{
		[] execVM "scripts\soldier_tracker\QS_icons.sqf";
	};
	execVM "scripts\R3F_LOG\init.sqf";
};

