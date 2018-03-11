[
	"Extras: AI",
	"Initialize Revive",
	{
		private _units = [param [1, objNull, [objNull]]];
		
		if (isNull (_units select 0)) then
		{
			_units = [localize "STR_UNIT"] call Achilles_fnc_SelectUnits;
		};
		if (isNil "_units") exitWith {};
		if (count _units == 0) exitWith {["Error: No unit selected!"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};
		
		{
			if (not isPlayer _x and {not (_x getVariable ["Achilles_var_revive_initialized", false])}) then
			{
				_x setVariable ["Achilles_var_revive_initialized", true];
				if (local _x) then
				{
					[_x] call Achilles_fnc_revive_init;
				} else
				{
					[_x] remoteExecCall ["Achilles_fnc_revive_init", _x];
				};
			};
		} forEach _units;
		[objNull, "Revive initialized!"] call bis_fnc_showCuratorFeedbackMessage;
	}
] call Ares_fnc_RegisterCustomModule;