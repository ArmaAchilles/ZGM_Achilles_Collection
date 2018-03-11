params ["_unit"];

[
	_unit,				
	format ["Revive %1",name _unit],
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",			
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",			
	"_this distance _target < 2 and {""Medikit"" in backpackItems _this} and {isNull (_target getVariable [""Achilles_var_revive_dragged"", objNull])} and {_this == _target getVariable [""Achilles_var_revive_getRevived"", _this]} and {lifeState _target == ""INCAPACITATED""}",
	"""Medikit"" in backpackItems _caller and {lifeState _target == ""INCAPACITATED""}",
	{
		params ["_unit", "_caller"];
		private ["_relpos", "_offset", "_dir"];
		
		_unit setVariable ["Achilles_var_revive_getRevived", _caller, true];
		{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];
		
		_relpos = _caller worldToModel position _unit;
		if((_relpos select 0) < 0) then
		{
			_offset = [-0.2,0.7,0]; 
			_dir = 90;
		} else 
		{
			_offset = [0.2,0.7,0]; 
			_dir = 270;
		};
		_unit attachTo [_caller, _offset];
		[_unit, _dir] remoteExecCall ["setDir", _unit];
		
		_caller playAction "medicStart";
		Achilles_var_revive_animEH = _caller addEventHandler ["AnimDone", {(_this select 0) playAction "medicStart"}];
	},		
	{},		
	{
		params ["_unit", "_caller"];
		
		[_unit, false] remoteExecCall ["Achilles_fnc_revive_endUnconsciousness", _unit];
		(format ["%1 revived %2!", name _caller, name _unit]) remoteExecCall ["systemChat"];
		_caller removeEventHandler ["AnimDone", Achilles_var_revive_animEH];
		_caller playAction "medicStop";
		_unit setVariable ["Achilles_var_revive_getRevived", nil, true];
		{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
		detach _unit;
	},
	{
		params ["_unit", "_caller"];
		
		_caller removeEventHandler ["AnimDone", Achilles_var_revive_animEH];
		Achilles_var_revive_animEH = nil;
		_caller playAction "medicStop";
		_unit setVariable ["Achilles_var_revive_getRevived", nil, true];
		{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
		detach _unit;
	},
	[],
	20,
	21,
	false,
	false
] call BIS_fnc_holdActionAdd;

[
	_unit,				
	format ["Drag %1", name _unit],
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",			
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",			
	"_this distance _target < 2 and {isNull (_target getVariable [""Achilles_var_revive_getRevived"", objNull])} and {isNull (_target getVariable [""Achilles_var_revive_dragged"", objNull])} and {lifeState _target == ""INCAPACITATED""}",
	"lifeState _target == ""INCAPACITATED""",
	{},		
	{},		
	{
		params ["_unit", "_caller"];
		[_unit, _caller] call Achilles_fnc_revive_drag;
	},
	{},
	[],
	0.1,
	10,
	false,
	false
] call BIS_fnc_holdActionAdd;