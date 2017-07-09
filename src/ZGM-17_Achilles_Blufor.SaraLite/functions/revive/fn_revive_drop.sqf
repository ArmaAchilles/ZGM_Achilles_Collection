params ["_unit", "_caller", "_action_id"];

if (not isNil {_unit getVariable "Achilles_var_revive_dragged"}) then 
{
	_unit setVariable ["Achilles_var_revive_dragged", nil, true];
};
{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];

detach _unit;

if (lifeState _unit == "INCAPACITATED") then 
{
	[_unit, "AinjPpneMstpSnonWrflDb_release"] remoteExec ["switchMove",0];
};
_caller forceWalk false;
if (lifeState _caller in ["HEALTHY", "INJURED"]) then 
{
	_caller playMove "amovpknlmstpsraswrfldnon";
};

_caller removeAction _action_id;