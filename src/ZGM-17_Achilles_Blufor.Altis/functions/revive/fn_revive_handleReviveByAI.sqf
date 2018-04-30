/*
	Author: CreepPork_LV, modified by Kex

	Description:
		Handles AI behaviour for reviving other units.

	Parameters:
		_this select 0: OBJECT - The helper AI.
		_this select 1: OBJECT - Unit that the AI should help.

	Returns:
		Nothing
*/

params ["_helper", "_unit"];

// Move to the downed unit
_helper commandMove (getPos _unit);

// Display message
(format ["%1 (AI) is coming to the rescue of %2!", name _helper, name _unit]) remoteExecCall ["systemChat"];

// Wait until the unit has made it to him OR he is dead OR he failed to move to the downed unit
waitUntil {sleep 1; unitReady _helper || {!alive _helper} || {lifeState _unit != "INCAPACITATED"}};

// If the unit was killed in the waitUnitl we skip this unit
// If the unit is 2.5 meters nearby
if (alive _helper && {lifeState _unit == "INCAPACITATED"} && {lifeState _helper != "INCAPACITATED"} && {(_unit distance2D _helper) <= 2.5} && {isNull (_unit getVariable ["Achilles_var_revive_dragged", objNull])} && {isNull (_unit getVariable ["Achilles_var_revive_getRevived", objNull])}) then
{
	// Do revive
	private ["_offset", "_dir"];
	
	_unit setVariable ["Achilles_var_revive_getRevived", _helper, true];
	
	private _relpos = _helper worldToModel position _unit;
	if((_relpos select 0) < 0) then
	{
		_offset = [-0.2,0.7,0]; 
		_dir = 90;
	} else 
	{
		_offset = [0.2,0.7,0];
		_dir = 270;
	};
	_unit attachTo [_helper, _offset];
	[_unit, _dir] remoteExecCall ["setDir", _unit];
	[_helper, "KNEEL_TREAT_1", false] call Achilles_fnc_ambientAnim;

	// Stop the AI from moving
	doStop _helper;

	// Wait 20 seconds for reviving
	sleep 20;

	// Stop reviving
	[_unit, false] remoteExecCall ["Achilles_fnc_revive_endUnconsciousness", _unit];

	(format ["%1 revived %2!", name _helper, name _unit]) remoteExecCall ["systemChat"];

	[_helper, "TERMINATE"] call Achilles_fnc_ambientAnim;

	_unit setVariable ["Achilles_var_revive_getRevived", nil, true];
	detach _unit;

	// Return AI back to his squad
	_helper doFollow (leader _helper);

	// Exit script because the unit has been revived
	if (true) exitWith {};
};
// release of helper duty
_helper setVariable ["achilles_var_revive_AIhelperOnTheWay", nil, true];