#define CUSTOM_RESPAWN_INVENTORY
#include "\a3\Missions_F_Curator\MPScenarios\MP_ZGM_m11.Altis\initServer.sqf"

// set default respawn loadouts
private _worldName = toLower worldName;
switch (true) do {
    case (_worldName in ["altis", "stratis", "malden"]): {
        [east, ["o_soldier_sl_f", "o_soldier_f", "o_soldier_ar_f", "o_soldier_gl_f", "o_soldier_m_f", "o_soldier_lat_f", "o_medic_f", "o_engineer_f"]] call BIS_fnc_setRespawnInventory;
        [west, ["b_soldier_sl_f", "b_soldier_f", "b_soldier_ar_f", "b_soldier_gl_f", "b_soldier_m_f", "b_soldier_lat_f", "b_medic_f", "b_engineer_f"]] call BIS_fnc_setRespawnInventory;
        [independent, ["i_soldier_sl_f", "i_soldier_f", "i_soldier_ar_f", "i_soldier_gl_f", "i_soldier_m_f", "i_soldier_lat2_f", "i_medic_f", "i_engineer_f"]] call BIS_fnc_setRespawnInventory;
    };
    case (_worldName == "tanoa"): {
        [east, ["o_t_soldier_sl_f", "o_t_soldier_f", "o_t_soldier_ar_f", "o_t_soldier_gl_f", "o_t_soldier_m_f", "o_t_soldier_lat_f", "o_t_medic_f", "o_t_engineer_f"]] call BIS_fnc_setRespawnInventory;
        [west, ["b_t_soldier_sl_f", "b_t_soldier_f", "b_t_soldier_ar_f", "b_t_soldier_gl_f", "b_t_soldier_m_f", "b_t_soldier_lat_f", "b_t_medic_f", "b_t_engineer_f"]] call BIS_fnc_setRespawnInventory;
        [independent, ["i_c_soldier_para_2_f", "i_c_soldier_para_1_f", "i_c_soldier_para_4_f", "i_c_soldier_para_6_f", "i_c_soldier_para_5_f", "i_c_soldier_para_3_f", "i_c_soldier_para_8_f"]] call BIS_fnc_setRespawnInventory;
    };
    case (_worldName == "enoch"): {
        [east, ["o_r_soldier_tl_f", "o_r_soldier_ar_f", "o_r_soldier_gl_f", "o_r_soldier_m_f", "o_r_soldier_lat_f", "o_r_medic_f", "o_r_patrol_soldier_engineer_f"]] call BIS_fnc_setRespawnInventory;
        [west, ["b_w_soldier_sl_f", "b_w_soldier_f", "b_w_soldier_ar_f", "b_w_soldier_gl_f", "b_w_soldier_m_f", "b_w_soldier_lat_f", "b_w_medic_f", "b_w_engineer_f"]] call BIS_fnc_setRespawnInventory;
        [independent, ["i_e_soldier_sl_f", "i_e_soldier_f", "i_e_soldier_ar_f", "i_e_soldier_gl_f", "i_e_soldier_m_f", "i_e_soldier_lat2_f", "i_e_medic_f", "i_e_engineer_f"]] call BIS_fnc_setRespawnInventory;
    };
    case (_worldName in ["desert_e", "takistan", "mountains_acr", "zargabad"]): {
        [east, ["rhs_vdv_des_sergeant", "rhs_vdv_des_rifleman", "rhs_vdv_des_machinegunner", "rhs_vdv_des_grenadier", "rhs_vdv_des_marksman", "rhs_vdv_des_at", "rhs_vdv_des_medic", "rhs_vdv_des_engineer"]] call BIS_fnc_setRespawnInventory;
        [west, ["rhsusf_usmc_marpat_d_squadleader", "rhsusf_usmc_marpat_d_rifleman_m4", "rhsusf_usmc_marpat_d_autorifleman", "rhsusf_usmc_marpat_d_grenadier", "rhsusf_usmc_marpat_d_marksman", "rhsusf_usmc_marpat_d_smaw", "rhsusf_navy_marpat_d_medic", "rhsusf_usmc_marpat_d_engineer"]] call BIS_fnc_setRespawnInventory;
        [independent, ["rhsgref_cdf_un_squadleader", "rhsgref_cdf_un_rifleman", "rhsgref_cdf_un_machinegunner", "rhsgref_cdf_un_grenadier", "rhsgref_cdf_un_grenadier_rpg", "rhsgref_cdf_un_medic", "rhsgref_cdf_un_engineer"]] call BIS_fnc_setRespawnInventory;
    };
    default {
        [east, ["rhs_vmf_flora_sergeant", "rhs_vmf_flora_rifleman", "rhs_vmf_flora_machinegunner", "rhs_vmf_flora_grenadier", "rhs_vmf_flora_marksman", "rhs_vmf_flora_at", "rhs_vmf_flora_medic", "rhs_vmf_flora_engineer"]] call BIS_fnc_setRespawnInventory;
        [west, ["rhsusf_usmc_marpat_wd_squadleader", "rhsusf_usmc_marpat_wd_rifleman_m4", "rhsusf_usmc_marpat_wd_autorifleman", "rhsusf_usmc_marpat_wd_grenadier", "rhsusf_usmc_marpat_wd_marksman", "rhsusf_usmc_marpat_wd_smaw", "rhsusf_navy_marpat_wd_medic", "rhsusf_usmc_marpat_wd_engineer"]] call BIS_fnc_setRespawnInventory;
        [independent, ["rhsgref_cdf_reg_squadleader", "rhsgref_cdf_reg_rifleman", "rhsgref_cdf_reg_machinegunner", "rhsgref_cdf_reg_grenadier", "rhsgref_cdf_reg_marksman", "rhsgref_cdf_reg_grenadier_rpg", "rhsgref_cdf_reg_medic", "rhsgref_cdf_reg_engineer"]] call BIS_fnc_setRespawnInventory;
    };
};

// set random respawn position onshore (if no Zeus player is present in mission start)
waitUntil {!isNull bis_curator};
private _worldRadius = worldSize / 2;
private _default_respawn_pos = (selectBestPlaces [[_worldRadius, _worldRadius], _worldRadius, "(1 - waterDepth)", 100, 1]) select 0 select 0;
_default_respawn_pos set [2, 0];
bis_curator setPosATL _default_respawn_pos;
bis_curator setVariable ["CAM_POS_ATL", _default_respawn_pos, true];
