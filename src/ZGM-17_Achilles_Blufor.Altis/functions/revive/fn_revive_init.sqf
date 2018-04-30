params ["_unit"];
if (not local _unit) exitWith {};
bis_revive_ppColor = ppEffectCreate ["ColorCorrections", 1632];
bis_revive_ppVig = ppEffectCreate ["ColorCorrections", 1633];
bis_revive_ppBlur = ppEffectCreate ["DynamicBlur", 525];

// variable clean up
if (not isNil {_unit getVariable "Achilles_var_revive_getRevived"}) then
{
	_unit setVariable ["Achilles_var_revive_getRevived", nil, true];
};
if (not isNil {_unit getVariable "Achilles_var_revive_dragged"}) then
{
	_unit setVariable ["Achilles_var_revive_dragged", nil, true];
};

// In case player pressed Respawn on the main menu, we check if he is already in revive and move him out of it.
if (_unit getVariable ["Achilles_fnc_revive_active", false]) then {[_unit, false, false] call Achilles_fnc_revive_endUnconsciousness};

_unit addEventHandler ["HandleDamage",
{
	params ["_unit", "_selection", "_handler", "_", "_", "_", "_instigator"];

	if (_handler >= 0.999) then
	{
		if (_selection in ["","body","head"]) then
		{
			private _lifeState = lifeState _unit;
			if !(_lifeState in ["DEAD", "DEAD-RESPAWN", "DEAD-SWITCHING", "INCAPACITATED"]) then
			{
				// unit gets unconscious
				[_unit] call Achilles_fnc_revive_startUnconsciousness;
			}
			else
			{
				// unit loses blood
				if (("AchillesRevive_BloodLossTimer" call BIS_fnc_getParamValue) > 0 || ("AchillesRevive_Bleeding" call BIS_fnc_getParamValue) == 0) then
				{
					private _blood = _unit getVariable ["Achilles_var_revive_bloodLevel", 1];
					_unit setVariable ["Achilles_var_revive_bloodLevel", _blood + 0.999 - _handler];

					_unit setVariable ["Achilles_var_revive_handleDamage", [time, _instigator]];
				};
			};
		};
		_handler = 0.999;
	};
	_handler;
}];

if (isPlayer _unit) then
{
	[
		_unit,
		"Respawn",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa",
		"lifeState _target == ""INCAPACITATED"" and {_this == _target}",
		"lifeState _target == ""INCAPACITATED"" and {_caller == _target}",
		{},
		{},
		{
			params ["_unit"];

			[_unit, true] call Achilles_fnc_revive_endUnconsciousness;
		},
		{},
		[],
		3,
		20,
		false,
		true
	] call BIS_fnc_holdActionAdd;
};

private _id = [_unit] remoteExecCall ["Achilles_fnc_revive_addActions", 0, _unit];
_unit setVariable ["Achilles_var_revive_actionJipId", _id];