class Params
{
	class PlayerEditingAreaSize
	{
		title = $STR_A3_MP_ZGM_m11.Altis_Params_PlayerEditingAreaSize;
		values[] = {0,100,200,500,1000};
		texts[] = {"Unrestricted",100,200,500,1000};
		default = 0;
	};
	
	class GuerFriendly
	{
		title = $STR_DISP_INTEL_EDIT_GUERILLA;
		values[] = {-1,1,0,2};
		texts[] = {
			$STR_DISP_INTEL_NONE_FRIENDLY,
			$STR_DISP_INTEL_WEST_FRIENDLY,
			$STR_DISP_INTEL_EAST_FRIENDLY,
			$STR_DISP_INTEL_BOTH_FRIENDLY
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
	
	class AchillesRevive
	{
		title = "Achilles Revive System";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = DEFAULT_CAN_REVIVE;
	};

    class AchillesRevive_Bleeding
    {
        title = "Achilles Revive - Bleeding (Decorative)";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = DEFAULT_CAN_REVIVE_BLEED;
    };

    class AchillesRevive_AIRevive
    {
        title = "Achilles Revive - AI Revive (Experimental!)";
		values[] = {1,0};
		texts[] = {"Enabled","Disabled"};
		default = DEFAULT_CAN_REVIVE_AI;
    };

    class AchillesRevive_BloodLossTimer
    {
        title = "Achilles Revive - Blood Loss Timer";
		values[] = {0, 10, 30, 60, 120, 180, 240, 300};
		texts[] = {"Disabled","10 seconds", "30 seconds", "1 minute", "2 minutes", "3 minutes", "4 minutes", "5 minutes"};
		default = DEFAULT_CAN_REVIVE_BLOOD_LOSS_TIMER;
    };

	class R3fLogEnabledByDefault
	{
		title = "R3F Logistics Enabled";
		values[] = {1,0};
		texts[] = {"Yes","No"};
		default = DEFAULT_R3F_LOG_ENABLED_BY_DEFAULT;
	};
};