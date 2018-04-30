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

if !(_unit getVariable ["Achilles_fnc_revive_active", false]) exitWith {};

private _rate = 1 / ("AchillesRevive_BloodLossTimer" call BIS_fnc_getParamValue);

while {lifeState _unit == "INCAPACITATED"} do
{
	uiSleep 1;
	private _blood = _unit getVariable ["Achilles_var_revive_bloodLevel", 1];
	_blood = _blood - _rate;

	if (_blood < 0.01) then
	{
		// trick to switch to unscheduled env
		isNil {[_unit, true] call Achilles_fnc_revive_endUnconsciousness};
		[format ["%1 bled out", name _unit]] remoteExecCall ["systemChat", 0];
	}
	else
	{
		_unit setVariable ["Achilles_var_revive_bloodLevel", _blood];
	};
};
