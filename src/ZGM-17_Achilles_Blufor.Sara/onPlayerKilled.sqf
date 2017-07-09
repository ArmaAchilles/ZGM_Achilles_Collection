#include "paramDefault.hpp"

private _respawnDelay = ["PlayerRespawnDelay", DEFAULT_PLAYER_RESPAWN_DELAY] call BIS_fnc_getParamValue;
if(_respawnDelay != DEFAULT_PLAYER_RESPAWN_DELAY) then {setPlayerRespawnTime _respawnDelay};
