//::///////////////////////////////////////////////
//:: Anima Infusion
//:: By Alexander Gates
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "tsw_faction_func"

void main()
{
    //Med Kit
    //Declare major variables
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sTag = GetTag(oItem);

    int nAmount = 100;
    effect eHealing = EffectVisualEffect(VFX_FNF_NATURES_BALANCE); //nice
    effect eHeal = EffectHeal(nAmount);

    //Leave if not medkit.
    if(sTag != "AnimaInfusion1")
    {
        return;
    }

    //Make sure player has the cost
    int nGold = GetGold(oPC);
    if(nGold < 2500)
    {
        SendMessageToPC(oPC, "You need more gold or reputation to use this item.");
        return;
    }

    int nCheck = TakeReputation(oPC, 2);
    if(nCheck == 0)
    {
        SendMessageToPC(oPC, "You need more gold or reputation to use this item.");
        return;
    }

    //Make sure the heal amount is more than zero.
    if(sTag == "AnimaInfusion1")
    {
        //VFX
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealing, oTarget);
        //Heal
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);

        //Remove Gold
        AssignCommand(oPC, TakeGoldFromCreature(2500, oPC, TRUE));
    }
}
