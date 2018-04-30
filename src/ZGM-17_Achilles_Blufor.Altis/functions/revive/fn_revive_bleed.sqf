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

private _smallBloodPool = createVehicle [(selectRandom SMALL_BLOOD), [(getPosATL _unit) select 0, (getPosATL _unit) select 1, 0], [], 0, "CAN_COLLIDE"];
_smallBloodPool setDir (random 360);
_smallBloodPool setVectorUp (surfaceNormal (getPosATL _smallBloodPool));

if (("AchillesRevive_BloodLossTimer" call BIS_fnc_getParamValue) > 0) then
{
	sleep ("AchillesRevive_BloodLossTimer" call BIS_fnc_getParamValue) / 2;
}
else
{
	sleep 180;
};

// If the unit is no longer in revive mode.
if !(_unit getVariable ["Achilles_fnc_revive_active", false]) exitWith {};

private _largeBloodPool = createVehicle [(selectRandom LARGE_BLOOD), [(getPosATL _unit) select 0, (getPosATL _unit) select 1, 0], [], 0, "CAN_COLLIDE"];
_largeBloodPool setDir (random 360);
_largeBloodPool setVectorUp (surfaceNormal (getPosATL _largeBloodPool));