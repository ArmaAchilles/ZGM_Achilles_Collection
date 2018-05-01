#include "\a3\Missions_F_Curator\MPScenarios\MP_ZGM_m11.Altis\initServer.sqf"

// set random respawn position onshore (if no Zeus player is present in mission start)
waitUntil {not isNull bis_curator};
private _worldcenter = [configfile >> "CfgWorlds" >> worldName, "centerPosition", [15000,15000,0]] call BIS_fnc_returnConfigEntry;
private _worldsize = [configfile >> "CfgWorlds" >> worldName, "mapSize", 30000] call BIS_fnc_returnConfigEntry;
private _default_respawn_pos = (selectBestPlaces [_worldcenter, _worldsize, "(1 - waterDepth)", 100, 1]) select 0 select 0;
_default_respawn_pos set [2, 0];
bis_curator setPosATL _default_respawn_pos;
bis_curator setVariable ["CAM_POS_ATL", _default_respawn_pos, true];

execVM "scripts\R3F_LOG\init.sqf";