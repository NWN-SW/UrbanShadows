//::///////////////////////////////////////////////
//:: Town Portal / Recall
//:: pc_recall
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
    effect ePortal = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    int nGold = GetGold(oPC);

    //Get 1% of Gold
    int nGoldTake = nGold / 100;
    if(nGoldTake < 1)
    {
        nGoldTake = 1;
    }

    //Area compare
    if(sArea != "Hell_1" && sArea != "TheEnd_WZ" && sArea != "PLAYER_PRISON")
    {
        //Make sure the PC isn't in combat and has at least 10k gold
        if(!GetIsInCombat(oPC) && sTag == "OrbofRecall")
        {
            //VFX
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lPC);
            //Teleport
            DelayCommand(2.0, AssignCommand(oPC, ActionJumpToObject(oWP)));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lWP);
            //Remove Gold
            AssignCommand(oPC, TakeGoldFromCreature(nGoldTake, oPC, TRUE));

        }
        else if(GetIsInCombat(oPC) && sTag == "OrbofRecall")
        {
            SendMessageToPC(oPC, "You cannot recall while in combat.");
        }
    }
    else
    {
        SendMessageToPC(oPC, "Your recall stone flickers. It doesn't seem to work in this place.");
    }
}
