#define CUSTOM_RESPAWN_INVENTORY
#include "\a3\Missions_F_Curator\MPScenarios\MP_ZGM_m11.Altis\initServer.sqf"

// set default respawn loadouts
if (worldName == "Tanoa") then
{
	[east, ["o_t_soldier_sl_f", "o_t_soldier_f", "o_t_soldier_ar_f", "o_t_soldier_gl_f", "o_t_soldier_m_f", "o_t_soldier_lat_f", "o_t_medic_f"]] call bis_fnc_setrespawninventory;
	[west, ["b_t_soldier_sl_f", "b_t_soldier_f", "b_t_soldier_ar_f", "b_t_soldier_gl_f", "b_t_soldier_m_f", "b_t_soldier_lat_f", "b_t_medic_f"]] call bis_fnc_setrespawninventory;
	[independent, ["I_C_Soldier_Para_2_F", "i_c_soldier_para_1_f", "I_C_Soldier_Para_4_F", "I_C_Soldier_Para_6_F", "I_C_Soldier_Para_5_F", "I_C_Soldier_Para_3_F"]] call bis_fnc_setrespawninventory;
} else {
	[east, ["o_soldier_sl_f", "o_soldier_f", "o_soldier_ar_f", "o_soldier_gl_f", "o_soldier_m_f", "o_soldier_lat_f", "o_medic_f"]] call bis_fnc_setrespawninventory;
	[west, ["b_soldier_sl_f", "b_soldier_f", "b_soldier_ar_f", "b_soldier_gl_f", "b_soldier_m_f", "b_soldier_lat_f", "b_medic_f"]] call bis_fnc_setrespawninventory;
	[independent, ["i_soldier_sl_f", "i_soldier_f", "i_soldier_ar_f", "i_soldier_gl_f", "i_soldier_m_f", "i_soldier_lat_f", "i_medic_f"]] call bis_fnc_setrespawninventory;
};

// set random respawn position onshore (if no Zeus player is present in mission start)
waitUntil {!isNull bis_curator};
private _worldRadius = worldSize / 2;
private _default_respawn_pos = (selectBestPlaces [[_worldRadius, _worldRadius], _worldRadius, "(1 - waterDepth)", 100, 1]) select 0 select 0;
_default_respawn_pos set [2, 0];
bis_curator setPosATL _default_respawn_pos;
bis_curator setVariable ["CAM_POS_ATL", _default_respawn_pos, true];
