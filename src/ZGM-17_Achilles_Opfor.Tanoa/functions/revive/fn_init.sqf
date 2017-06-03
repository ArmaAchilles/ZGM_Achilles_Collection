params ["_unit"];
if (not local _unit) exitWith {};
bis_revive_ppColor = ppEffectCreate ["ColorCorrections", 1632];
bis_revive_ppVig = ppEffectCreate ["ColorCorrections", 1633];
bis_revive_ppBlur = ppEffectCreate ["DynamicBlur", 525];

_unit addEventHandler ["HandleDamage", 
{
	params ["_unit", "_selection", "_handler"];
	
	if (_handler >= 0.999) then
	{
		if (_selection in ["","body","head"] and {not (_unit getVariable ["Achilles_revive_var_unconscious",false])}) then 
		{
			[_unit] call Achilles_revive_fnc_startUnconsciousness;
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
		"_target getVariable [""Achilles_revive_var_unconscious"", false] and {_this == _target}",	
		"_target getVariable [""Achilles_revive_var_unconscious"", false] and {_caller == _target}",	
		{},		
		{},		
		{
			params ["_unit"];
			
			[_unit, true] call Achilles_revive_fnc_endUnconsciousness;	
		},
		{},
		[],
		3,
		20,
		false,
		true
	] call BIS_fnc_holdActionAdd;
};

[
	_unit,				
	format ["Revive %1",name _unit],
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",			
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",			
	"_this distance _target < 2 and {""Medikit"" in backpackItems _this} and {isNull (_target getVariable [""Achilles_revive_var_dragged"", objNull])} and {_this == _target getVariable [""Achilles_revive_var_getRevived"", _this]} and {_target getVariable [""Achilles_revive_var_unconscious"", false]} and {alive _target}",
	"""Medikit"" in backpackItems _caller and {_target getVariable [""Achilles_revive_var_unconscious"",false]} and {alive _target}",
	{
		params ["_unit", "_caller"];
		private ["_relpos", "_offset", "_dir"];
		
		_unit setVariable ["Achilles_revive_var_getRevived", _caller, true];
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
		[_unit, _dir] remoteExec ["setDir", _unit];
		
		_caller playAction "medicStart";
		Achilles_revive_var_animEH = _caller addEventHandler ["AnimDone", {(_this select 0) playAction "medicStart"}];
	},		
	{},		
	{
		params ["_unit", "_caller"];
		
		[_unit, false] remoteExecCall ["Achilles_revive_fnc_endUnconsciousness", _unit];
		(format ["%1 revived %2!", name _caller, name _unit]) remoteExecCall ["systemChat"];
		_caller removeEventHandler ["AnimDone", Achilles_revive_var_animEH];
		_caller playAction "medicStop";
		_unit setVariable ["Achilles_revive_var_getRevived", nil, true];
		{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
		detach _unit;
	},
	{
		params ["_unit", "_caller"];
		
		_caller removeEventHandler ["AnimDone", Achilles_revive_var_animEH];
		_caller playAction "medicStop";
		_unit setVariable ["Achilles_revive_var_getRevived", nil, true];
		{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
		detach _unit;
	},
	[],
	20,
	21,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _unit];

[
	_unit,				
	format ["Drag %1", name _unit],
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",			
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",			
	"_this distance _target < 2 and {isNull (_target getVariable [""Achilles_revive_var_getRevived"", objNull])} and {_this == _target getVariable [""Achilles_revive_var_dragged"", _this]} and {_target getVariable [""Achilles_revive_var_unconscious"", false]} and {alive _target}",	
	"_target getVariable [""Achilles_revive_var_unconscious"",false] and {alive _target}",
	{},		
	{},		
	{
		params ["_unit", "_caller"];
		[_unit, _caller] call Achilles_revive_fnc_drag;
	},
	{},
	[],
	0.1,
	10,
	false,
	false
] remoteExec ["BIS_fnc_holdActionAdd", 0,_unit];