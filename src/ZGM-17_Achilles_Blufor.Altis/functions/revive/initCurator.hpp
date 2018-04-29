[
	"Revive",
	"Enable Revive for AI",
	{
		private _units = [param [1, objNull, [objNull]]];
		
		if (isNull (_units select 0)) then
		{
			_units = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
		};
		if (isNil "_units") exitWith {};
		if (count _units == 0) exitWith {["No unit selected!"] call Achilles_fnc_showZeusErrorMessage};
		
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
		["Revive enabled!"] call Ares_fnc_showZeusMessage;
	}
] call Ares_fnc_RegisterCustomModule;

[
	"Revive",
	"Toggle Unconscious",
	{
		private _units = [param [1, objNull, [objNull]]];
		
		if (isNull (_units select 0)) then
		{
			_units = [localize "STR_AMAE_UNITS"] call Achilles_fnc_SelectUnits;
		};
		if (isNil "_units") exitWith {};
		if (count _units == 0) exitWith {["No unit selected!"] call Achilles_fnc_showZeusErrorMessage};
		
		{
            // If is in revive mode
            if (lifeState _x == "INCAPACITATED") then
            {
                if (local _x) then
                {
                    [_x] call Achilles_fnc_revive_endUnconsciousness;
                }
                else
                {
                    [_x] remoteExecCall ["Achilles_fnc_revive_endUnconsciousness", _x];
                };
            }
            // If is NOT in revive mode
            else
            {
                if (local _x) then
                {
                    [_x] call Achilles_fnc_revive_startUnconsciousness;
                }
                else
                {
                    [_x] remoteExecCall ["Achilles_fnc_revive_startUnconsciousness", _x];
                };
            };
		} forEach _units;
		["Conciseness toggled!"] call Ares_fnc_showZeusMessage;
	}
] call Ares_fnc_RegisterCustomModule;