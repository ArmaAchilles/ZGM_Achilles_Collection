params ["_unit"];
if (surfaceIsWater getPos _unit) exitWith {_unit setDamage 1};

if (isPlayer _unit) then
{
	{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];
	[] call Achilles_fnc_revive_ppEffects;
};

moveOut _unit;
_unit setUnconscious true;
_unit setCaptive true;
1 fadeMusic 0.1;
(format ["%1 is unconscious!", name _unit]) remoteExecCall ["systemChat"];
