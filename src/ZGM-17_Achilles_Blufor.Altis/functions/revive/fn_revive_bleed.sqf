/*
	Author: CreepPork_LV

	Description:
		Handles blood pool spawning for that extra effect.

	Parameters:
		_this select 0: OBJECT - Unit that the blood should appear for.

	Returns:
		Nothing
*/

params ["_unit"];

#define SMALL_BLOOD ["BloodSplatter_01_Medium_New_F"]
#define LARGE_BLOOD ["BloodPool_01_Large_New_F"]

// Create the pool
private _smallBloodPool = createVehicle [(selectRandom SMALL_BLOOD), [(getPosATL _unit) select 0, (getPosATL _unit) select 1, 0], [], 0, "CAN_COLLIDE"];

// Set a random direction for it
_smallBloodPool setDir (random 360);

// Follows terrain rotation
_smallBloodPool setVectorUp (surfaceNormal (getPosATL _smallBloodPool));

if (("AchillesRevive_BloodLossTimer" call BIS_fnc_getParamValue) > 0) then
{
	waitUntil {
		sleep 1;
		private _lifeState = lifeState _unit;
		!(_lifeState in ["DEAD", "DEAD-RESPAWN", "DEAD-SWITCHING", "INCAPACITATED"]) || {_unit getVariable ["Achilles_var_revive_bloodLevel", 1] < 0.5};
	};
}
else
{
	private _time = time;
	waitUntil {
		sleep 1; 
		time > _time + 180;
	};
};

// If the unit is no longer in revive mode.
if !(_unit getVariable ["Achilles_fnc_revive_active", false]) exitWith {};

private _largeBloodPool = createVehicle [(selectRandom LARGE_BLOOD), [0,0,0], [], 0, "CAN_COLLIDE"];
(lineIntersectsSurfaces [getPosASL _unit, (getPosASL _unit) vectorDiff [0,0,5], _unit] select 0) params 
[
	["_intersectPosASL", ATLToASL [getPos _unit, getPos _unit, 0]],
	["_surfaceNormal", surfaceNormal (getPos _largeBloodPool)]
];
_largeBloodPool setPosASL _intersectPosASL;
_largeBloodPool setDir (random 360);
_largeBloodPool setVectorUp _surfaceNormal;