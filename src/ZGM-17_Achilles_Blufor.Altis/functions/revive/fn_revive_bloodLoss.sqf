/*
	Author: CreepPork_LV

	Description:
		Handles a timer of how long the unit should be alive for. Roughly simulates blood loss.

	Parameters:
		_this select 0: OBJECT - Unit that the timer should be applied to.

	Returns:
		Nothing
*/

params ["_unit"];

sleep ("AchillesRevive_BloodLossTimer" call BIS_fnc_getParamValue);

if !(_unit getVariable ["Achilles_fnc_revive_active", false]) exitWith {};

[_unit, true] call Achilles_fnc_revive_endUnconsciousness;