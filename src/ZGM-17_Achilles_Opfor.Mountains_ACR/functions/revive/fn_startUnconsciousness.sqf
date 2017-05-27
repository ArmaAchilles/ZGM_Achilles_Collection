params ["_unit"];
if (surfaceIsWater getPos _unit) exitWith {_unit setDamage 1};
_unit setVariable ["Achilles_revive_var_unconscious",true,true];

if (isPlayer _unit) then
{
	{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];
	[] call achilles_revive_fnc_ppEffects;
};

moveOut _unit;
_unit setUnconscious true;
_unit setCaptive true;
1 fadeMusic 0.1;
(format ["%1 is unconscious!", name _unit]) remoteExecCall ["systemChat"];