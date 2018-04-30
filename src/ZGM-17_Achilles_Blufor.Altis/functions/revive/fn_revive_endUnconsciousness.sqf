// Disclaimer: this function has to be executed in the unscheduled environment to make sure it only gets executed once
params ["_unit", ["_doKill",false,[false]], ["_animate", true, [true]]];

// exit if the function was already called
if !(_unit getVariable ["Achilles_fnc_revive_active", true]) exitWith {};

if (isPlayer _unit) then 
{
	{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
};
_unit setUnconscious false;
_unit setCaptive false;
1 fadeMusic 1;
if (_animate) then
{
	_unit playMoveNow "AmovPpneMstpSrasWrflDnon";
};

// variable clean up
if (not isNil {_unit getVariable "Achilles_var_revive_getRevived"}) then
{
	_unit setVariable ["Achilles_var_revive_getRevived", nil, true];
};

if (not isNil {_unit getVariable "Achilles_var_revive_dragged"}) then
{
	_unit setVariable ["Achilles_var_revive_dragged", nil, true];
};

if (!isNil { _unit getVariable "Achilles_fnc_revive_active" }) then
{
	_unit setVariable ["Achilles_fnc_revive_active", nil, true];
};

if (!isNil { _unit getVariable "Achilles_fnc_revive_side" }) then
{
	_unit setVariable ["Achilles_fnc_revive_side", nil, true];
};

if (!isNil { _unit getVariable "Achilles_var_revive_bloodLevel" }) then
{
	_unit setVariable ["Achilles_var_revive_bloodLevel", nil, true];
};

if (!isNil { _unit getVariable "Achilles_var_revive_handleDamage" }) then
{
	_unit setVariable ["Achilles_var_revive_handleDamage", nil, true];
};

private _id = _unit getVariable ["Achilles_var_revive_actionJipId", ""];
if (_id != "") then {remoteExecCall ["", _id]};
_unit setVariable ["Achilles_var_revive_actionJipId", nil];

if (_doKill) then
{
	_unit setDamage 1;
} else
{
	_unit setDamage 0;
};