//::///////////////////////////////////////////////
//:: Door Portal
//:: By Alexander Gates
//:://////////////////////////////////////////////

#include "x2_inc_switches"
void main()
{
    //Hell Portal
    //Declare major variables
    object oPC = GetPCSpeaker();
    object oWP = GetWaypointByTag("WP_Door_Portal");
    location lWP = GetLocation(oWP);
    location lPC = GetLocation(oPC);
    effect ePortal = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    effect ePara = EffectParalyze();

    //VFX
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oPC, 3.8);
    //Teleport
    DelayCommand(4.0, AssignCommand(oPC, ActionJumpToObject(oWP)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lWP);
}
