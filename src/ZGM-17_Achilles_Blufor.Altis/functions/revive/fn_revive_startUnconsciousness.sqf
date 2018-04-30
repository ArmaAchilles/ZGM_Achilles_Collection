// Disclaimer: this function has to be executed in the unscheduled environment to make sure it only gets executed once
params ["_unit"];

// exit if the function was already called
if (_unit getVariable ["Achilles_fnc_revive_active", false]) exitWith {};

if (surfaceIsWater getPos _unit) exitWith {_unit setDamage 1};

// If the vehicle the unit was in, was destroyed then kill the unit (who will survive that?).
if (vehicle _unit != _unit && {!alive (vehicle _unit)}) exitWith {_unit setDamage 1};

if (isPlayer _unit) then
{
	{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction"];
	[] call Achilles_fnc_revive_ppEffects;
};


_unit setVariable ["Achilles_fnc_revive_active", true];
_unit setVariable ["Achilles_fnc_revive_side", side _unit];

moveOut _unit;
_unit setUnconscious true;
_unit setCaptive true;
1 fadeMusic 0.1;

(format ["%1 is unconscious!", name _unit]) remoteExecCall ["systemChat"];

if (("AchillesRevive_AIRevive" call BIS_fnc_getParamValue) == 1) then
{
	[_unit] spawn Achilles_fnc_revive_handleAI;
};

if (("AchillesRevive_Bleeding" call BIS_fnc_getParamValue) == 1) then
{
	[_unit] spawn Achilles_fnc_revive_bleed;
};

if (("AchillesRevive_BloodLossTimer" call BIS_fnc_getParamValue) > 0) then
{
	_unit setVariable ["Achilles_var_revive_bloodLevel", 1];
	[_unit] spawn Achilles_fnc_revive_bloodLoss;
};