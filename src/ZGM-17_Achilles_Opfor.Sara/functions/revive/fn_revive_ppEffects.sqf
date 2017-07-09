bis_revive_ppColor ppEffectAdjust [1,1,0.15,[0.3,0.3,0.3,0],[0.3,0.3,0.3,0.3],[1,1,1,1]];
bis_revive_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[1,1,0,0,0,0.2,1]];
bis_revive_ppBlur ppEffectAdjust [0];
{_x ppEffectCommit 0; _x ppEffectEnable true; _x ppEffectForceInNVG true} forEach [bis_revive_ppColor, bis_revive_ppVig, bis_revive_ppBlur];

[] spawn
{
	scriptName "bis_fnc_reviveBleedOut: PP effect control";

	while {lifeState player == "INCAPACITATED"} do
	{
		private _blood = player getVariable ["Achilles_var_revive_bloodLevel", 1];

		private _bright = 0.2 + (0.1 * _blood);
		bis_revive_ppColor ppEffectAdjust [1,1, 0.15 * _blood,[0.3,0.3,0.3,0],[_bright,_bright,_bright,_bright],[1,1,1,1]];
		private _intense = 0.6 + (0.4 * _blood);
		bis_revive_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[_intense,_intense,0,0,0,0.2,1]];
		private _blur = 0.7 * (1 - _blood);
		bis_revive_ppBlur ppEffectAdjust [_blur];

		{_x ppEffectCommit 1} forEach [bis_revive_ppColor, bis_revive_ppVig, bis_revive_ppBlur];
		uiSleep 1;
	};

	bis_revive_ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0, 0, 0, 1],[0,0,0,0]];
	bis_revive_ppVig ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0, 0, 0, 1],[0,0,0,0]];
	bis_revive_ppBlur ppEffectAdjust [0];

	{_x ppEffectCommit 1} forEach [bis_revive_ppColor, bis_revive_ppVig, bis_revive_ppBlur];
	sleep 1;
	{_x ppEffectEnable false} forEach [bis_revive_ppColor, bis_revive_ppVig, bis_revive_ppBlur];
};