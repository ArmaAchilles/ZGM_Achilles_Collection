params ["_unit", ["_doKill",false,[false]]];

if (isPlayer _unit) then 
{
	{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];
};
_unit setUnconscious false;
_unit setCaptive false;
1 fadeMusic 1;
_unit playMoveNow "AmovPpneMstpSrasWrflDnon";

_unit setVariable ["Achilles_revive_var_unconscious",nil,true];
if (not isNil {_unit getVariable "Achilles_revive_var_getRevived"}) then
{
	_unit setVariable ["Achilles_revive_var_getRevived", nil, true];
};
if (not isNil {_unit getVariable "Achilles_revive_var_dragged"}) then
{
	_unit setVariable ["Achilles_revive_var_dragged", nil, true];
};

if (_doKill) then
{
	_unit setDamage 1;
} else
{
	_unit setDamage 0;
};