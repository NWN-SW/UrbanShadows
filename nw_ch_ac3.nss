//::///////////////////////////////////////////////
//:: Associate: End of Combat End by Alexander G.
//:://////////////////////////////////////////////
#include "X0_INC_HENAI"
#include "X2_inc_spellhook"

void main()
{
    if (!GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT"))
        { // set variables on target for mounted combat
            DeleteLocalInt(OBJECT_SELF,"bX3_LAST_ATTACK_PHYSICAL");
            DeleteLocalInt(OBJECT_SELF,"nX3_HP_BEFORE");
            DeleteLocalInt(OBJECT_SELF,"bX3_ALREADY_MOUNTED_COMBAT");
        } // set variables on target for mounted combat

    if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       HenchmenCombatRound(OBJECT_INVALID);
    }


    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }

    // Check if concentration is required to maintain this creature
    X2DoBreakConcentrationCheck();

    //Shadow of Death damage pulse
    if(GetTag(OBJECT_SELF) == "ShadowOfDeath")
    {
        ExecuteScript("tsw_necr_shdbrst");
    }
}

