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

	// Get nearby units that can revive
	// unit has to be alive, not a player, friendly and medic
	private _candidateUnits = (nearestObjects [getPos _unit, ["Man"], 300]) select {_x != _unit and {alive _x} and {lifeState _x != "INCAPACITATED"} and {not isPlayer _x} and {[_unitSide, side _x] call BIS_fnc_sideIsFriendly} and {"Medikit" in (items _x)}};
	// prefer helpers of the unit's group
	private _candidateUnits = (_candidateUnits arrayIntersect (units group _unit)) + _candidateUnits;
	if !(_candidateUnits isEqualTo []) then
	{
		// send the helper AI
		_candidateUnits params ["_helper"];
		_helper setVariable ["achilles_var_revive_AIhelperOnTheWay", true, true];
		[_helper, _unit] remoteExec ["Achilles_fnc_revive_handleReviveByAI", _helper];
		waitUntil { sleep 1; !(_helper getVariable ["achilles_var_revive_AIhelperOnTheWay", false] and {alive _helper}) };
	};
	// wait till none helps the unit
};