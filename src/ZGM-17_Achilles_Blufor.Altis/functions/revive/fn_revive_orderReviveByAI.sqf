/*
	Author: CreepPork_LV, modified by Kex

	Description:
		Sends requests to AI for a revive.

	Parameters:
		_this select 0: OBJECT - Unit that the AI should help.

	Returns:
		Nothing
*/

params ["_unit"];

// Get unit previous side so enemies don't revive hostiles.
private _unitSide = _unit getVariable ["Achilles_fnc_revive_side", west];

// While unit is down
while {lifeState _unit == "INCAPACITATED"} do
{
	// Timeout for performance
	sleep 2;

	// Get nearby units
	private _nearUnits = (getPos _unit) nearObjects ["Man", 300];

	// Foreach unit
	{
		// If unit is alive, not a player, friendly and medic
		if (alive _x and {not isPlayer _x} and {[_unitSide, side _x] call BIS_fnc_sideIsFriendly} and {"Medikit" in (items _x)}) then
		{
			[_x, _unit] remoteExec ["Achilles_fnc_revive_handleReviveByAI", _x];
		};
	} forEach _nearUnits;
};