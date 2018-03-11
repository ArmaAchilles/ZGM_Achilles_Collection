params ["_unit"];
if (surfaceIsWater getPos _unit) exitWith {_unit setDamage 1};

if (isPlayer _unit) then
{
	{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];
	[] call Achilles_fnc_revive_ppEffects;
};

if (_unit getVariable ["Achilles_fnc_revive_active", false]) exitWith {};
_unit setVariable ["Achilles_fnc_revive_active", true];

_unit setVariable ["Achilles_fnc_revive_side", side _unit];

moveOut _unit;
_unit setUnconscious true;
_unit setCaptive true;
1 fadeMusic 0.1;

(format ["%1 is unconscious!", name _unit]) remoteExecCall ["systemChat"];

[_unit] spawn Achilles_fnc_revive_handleAI;

[_unit] spawn Achilles_fnc_revive_bleed;
