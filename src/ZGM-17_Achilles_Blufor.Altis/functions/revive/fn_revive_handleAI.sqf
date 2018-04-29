/*
	Author: CreepPork_LV

	Description:
		Handles AI behaviour for reviving other units.

	Parameters:
		_this select 0: OBJECT - Unit that the AI should help.

	Returns:
		Nothing
*/

params ["_unit"];

// Get unit previous side so enemies don't revive hostiles.
private _unitSide = _unit getVariable ["Achilles_fnc_revive_side", west];

// While unit is down
while {lifeState _unit == "INCAPACITATED"} do
{
	// Timeout for performance
	sleep 2;

	// Get nearby units
	private _nearUnits = (getPos _unit) nearObjects ["Man", 300];

	// Foreach unit
	{
		// If unit is alive
		if (alive _x) then
		{
			// If unit is friendly
			if ([_unitSide, side _x] call BIS_fnc_sideIsFriendly) then
			{
				// If unit is a medic
				if ("Medikit" in (items _x)) then
				{
					// If the unit is not a player
					if !(_x in allPlayers) then
					{
						// Move to the downed unit
						_x moveTo (getPos _unit);
						_x doMove (getPos _unit);

						// Display message
						(format ["%1 (AI) is coming to the rescue of %2!", name _x, name _unit]) remoteExecCall ["systemChat"];

						// Wait until the unit has made it to him OR he is dead OR he failed to move to the downed unit
						waitUntil {sleep 1; moveToCompleted _x || !alive _x || moveToFailed _x};

						// If the unit was killed in the waitUnitl we skip this unit
						if (alive _x && !moveToFailed _x) then
						{
							// If the unit is 2.5 meters nearby
							if ((_x distance2D _unit) <= 2.5) then
							{
								// Do revive
								private ["_offset", "_dir"];
								
								_unit setVariable ["Achilles_var_revive_getRevived", _x, true];
								{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];
								
								private _relpos = _x worldToModel position _unit;
								if((_relpos select 0) < 0) then
								{
									_offset = [-0.2,0.7,0]; 
									_dir = 90;
								} else 
								{
									_offset = [0.2,0.7,0];
									_dir = 270;
								};
								_unit attachTo [_x, _offset];
								[_unit, _dir] remoteExecCall ["setDir", _unit];
								
								_x playAction "medicStart";
								private _animEH = _x addEventHandler ["AnimDone", {(_this select 0) playAction "medicStart"}]; // This is not reliable for AI

								// Stop the AI from moving
								doStop _x;

								// Wait 20 seconds for reviving
								sleep 20;

								// Stop reviving
								[_unit, false] remoteExecCall ["Achilles_fnc_revive_endUnconsciousness", _unit];

								(format ["%1 revived %2!", name _x, name _unit]) remoteExecCall ["systemChat"];

								_x removeEventHandler ["AnimDone", _animEH];
								_x playAction "medicStop";

								_unit setVariable ["Achilles_var_revive_getRevived", nil, true];
								{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
								detach _unit;

								// Return AI back to his squad
								_x doFollow (leader _x);

								// Exit script because the unit has been revived
								if (true) exitWith {};
							};
						};
					};
				};
			};
		};
	} forEach _nearUnits;
};