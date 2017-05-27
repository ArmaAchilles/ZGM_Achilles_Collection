params ["_unit", "_caller", "_action_id"];

if (not isNil {_unit getVariable "Achilles_revive_var_dragged"}) then {_unit setVariable ["Achilles_revive_var_dragged", nil, true]};
{inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];

detach _unit;

if (not isNil {_unit getVariable "Achilles_revive_var_unconscious"}) then {[_unit, "AinjPpneMstpSnonWrflDb_release"] remoteExec ["switchMove",0]};
_caller forceWalk false;
if (isNil {_caller getVariable "Achilles_revive_var_unconscious"}) then {_caller playMove "amovpknlmstpsraswrfldnon"};

_caller removeAction _action_id;