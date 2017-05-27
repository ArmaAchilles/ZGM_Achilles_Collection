#include "paramDefault.hpp"

params ["_unit", "_old_body"];

private _canRevive = ["AchillesRevive", DEFAULT_CAN_REVIVE] call BIS_fnc_getParamValue;
if (_canRevive == 1) then
{
	if (not isNil {_old_body getVariable "Achilles_revive_var_unconscious"}) then
	{
		_unit call Achilles_revive_fnc_endUnconsciousness;
	};
	deleteVehicle _old_body;
	[_unit] call Achilles_revive_fnc_init;
};