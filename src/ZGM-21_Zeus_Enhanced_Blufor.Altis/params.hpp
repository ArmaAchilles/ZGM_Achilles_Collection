class Params
{
	class PlayerEditingAreaSize
	{
		title = "$STR_A3_MP_ZGM_m11.Altis_Params_PlayerEditingAreaSize";
		values[] = {0,100,200,500,1000};
		texts[] = {"Unrestricted",100,200,500,1000};
		default = 0;
	};
	
	class GuerFriendly
	{
		title = "$STR_DISP_INTEL_EDIT_GUERILLA";
		values[] = {-1,1,0,2};
		texts[] = {
			"$STR_DISP_INTEL_NONE_FRIENDLY",
			"$STR_DISP_INTEL_WEST_FRIENDLY",
			"$STR_DISP_INTEL_EAST_FRIENDLY",
			"$STR_DISP_INTEL_BOTH_FRIENDLY"
		};
		default = DEFAULT_GUERFRIENDLY;
		function = "BIS_fnc_paramGuerFriendly";
	};
	
	class PlayerRespawnDelay
	{
		title = "Player Respawn Delay [s]";
		values[] = {6,8,10,20,30,45,60};
		default = DEFAULT_PLAYER_RESPAWN_DELAY;
	};
};
