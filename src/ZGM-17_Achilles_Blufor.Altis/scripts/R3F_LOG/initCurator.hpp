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
