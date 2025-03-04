//::///////////////////////////////////////////////
//:: Emergency Beacon
//:: By Alexander Gates
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////

#include "x2_inc_switches"
void main()
{
    //ORB OF RECALL
    //Declare major variables
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oWP = GetWaypointByTag("tp_recall");
    location lWP = GetLocation(oWP);
    location lPC = GetLocation(oPC);
    string sTag = GetTag(oItem);
    string sArea = GetTag(GetArea(oPC));
    effect ePortal = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);

    //Area compare
    if(sArea != "Hell_1" && sArea != "TheEnd_WZ" && sArea != "PLAYER_PRISON")
    {
        //Make sure the PC isn't in combat and has at least 10k gold
        if(sTag == "EmergencyBeacon1")
        {
            //VFX
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lPC);
            //Teleport
            AssignCommand(oPC, ActionJumpToObject(oWP));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lWP);
        }
    }
    else
    {
        SendMessageToPC(oPC, "Your beacon fizzles. It doesn't seem to work in this place.");
    }
}
