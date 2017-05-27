params ["_unit", "_caller"];

_unit setVariable ["Achilles_revive_var_dragged", _caller, true];
{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];

_unit attachTo [_caller, [0, 1, 0.08]];
[_unit,180] remoteExec ["setDir",_unit];

[_unit,"AinjPpneMrunSnonWnonDb"] remoteExec ["switchMove",0];
_caller forceWalk true;
_caller playAction "grabDrag";

_action_id =
[
	_caller,				
	format ["Drop %1", name _unit],	
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",			
	"true",	
	"true",	
	{},		
	{},		
	{
		private _unit = _this select 3 select 0;
		_unit setVariable ["Achilles_revive_var_dragged", nil, true];
	},
	{},
	[_unit],
	0.1,
	22,
	false,
	false
] call BIS_fnc_holdActionAdd;

[_unit, _caller, _action_id] spawn
{
	params ["_unit", "_caller", "_action_id"];
	waitUntil
	{
		sleep 0.1;
		isNil {_unit getVariable "Achilles_revive_var_dragged"} or {isNil {_unit getVariable "Achilles_revive_var_unconscious"}} or {not alive _unit} or {not isNil {_caller getVariable "Achilles_revive_var_unconscious"}} or {not alive _caller}
	};
	[_unit, _caller, _action_id] call Achilles_revive_fnc_drop;
};