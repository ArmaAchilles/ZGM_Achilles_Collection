params ["_unit", ["_doKill",false,[false]]];

if (isPlayer _unit) then 
{
	{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
};
_unit setUnconscious false;
_unit setCaptive false;
1 fadeMusic 1;
_unit playMoveNow "AmovPpneMstpSrasWrflDnon";

// variable clean up
if (not isNil {_unit getVariable "Achilles_var_revive_getRevived"}) then
{
	_unit setVariable ["Achilles_var_revive_getRevived", nil, true];
};
if (not isNil {_unit getVariable "Achilles_var_revive_dragged"}) then
{
	_unit setVariable ["Achilles_var_revive_dragged", nil, true];
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