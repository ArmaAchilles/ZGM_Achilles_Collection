[
	"Mission: R3F Logistics",
	"Enable/Disable objects",
	{
		private _objects = [param [1, objNull, [objNull]]];
		
		private _dialogResults =
		[
			"Disable R3F Logistics",
			[
				["Disabled", ["true","false"]]
			]
		] call Ares_fnc_showChooseDialog;
		
		if (count _dialogResults == 0) exitWith {};
		private _disabled = if (_dialogResults select 0 == 0) then {true} else {false};
		
		if (isNull (_objects select 0)) then
		{
			_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
		};
		if (isNil "_objects") exitWith {};
		if (count _objects == 0) exitWith {["Error: No object selected"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
		
		{
			_x setVariable ["R3F_LOG_disabled", _disabled, true];
		} forEach _objects;
		
		[objNull, format ["Changed R3F Logistics Status of %1 objects", count _objects]] call bis_fnc_showCuratorFeedbackMessage;
	}
] call Ares_fnc_RegisterCustomModule;

/*
[
	"Mission: R3F Logistics",
	"Create factory",
	{
		private _object = param [1, objNull, [objNull]];
		if (isNull _object) exitWith {["Error: No object selected"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
		
		private _types = ["LIGHT", "MEDIUM", "FULL"];
		private _dialogResults =
		[
			"Create R3F Factory",
			[
				["Type", _types, 2],
				["Credit", "", "50000"]
			]
		] call Ares_fnc_showChooseDialog;
		
		if (count _dialogResults == 0) exitWith {};
		private _type = _types select (_dialogResults select 0);
		private _credit = parseNumber (_dialogResults select 1);
		[[_object, _credit, nil, _type], "scripts\R3F_LOG\USER_FUNCT\init_creation_factory.sqf"] remoteExecCall ["execVM", 0, _object];
		
		[objNull, format ["Created a new  %1 factory with %2 credit", _type, _credit]] call bis_fnc_showCuratorFeedbackMessage;
	}
] call Ares_fnc_RegisterCustomModule;
[
	"Extras: R3F Logistics",
	"Change factory credits",
	{
		private _object = param [1, objNull, [objNull]];
		if (isNull _object) exitWith {["Error: No object selected"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
		private _credit = _object getVariable "R3F_LOG_CF_credits";
		if (isNil "_credit") exitWith {["Error: Object is not a factory"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
		
		private _dialogResults =
		[
			"Change factory credits",
			[
				["Credit", "", str _credit, true]
			]
		] call Ares_fnc_showChooseDialog;
		
		if (count _dialogResults == 0) exitWith {};
		private _credit = parseNumber (_dialogResults select 0);
		_object setVariable ["R3F_LOG_CF_credits", _credit, true];
		
		[objNull, format ["Changed factory credit value to %1", _credit]] call bis_fnc_showCuratorFeedbackMessage;
	}
] call Ares_fnc_RegisterCustomModule;
*/
