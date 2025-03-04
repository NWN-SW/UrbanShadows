//::///////////////////////////////////////////////
//:: Medical Kit
//:: pc_med_kit
//:: By Alexander Gates
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "tsw_get_martial"

void main()
{
    //Med Kit
    //Declare major variables
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sTag = GetTag(oItem);
    int nAmount = GetSkillRank(4, oPC, FALSE);
    int nClassTotal = GetMartialLevel(oPC);

    nAmount = nClassTotal + nAmount * 3;
    effect eHealing = EffectVisualEffect(69); //nice
    effect eHeal = EffectHeal(nAmount);

    //Leave if not medkit.
    if(sTag != "Medical_Kit")
    {
        return;
    }

    //Check how many they've used today.
    int nUsed = GetLocalInt(oPC, "MEDKIT_USES");
    if(nUsed >= 2)
    {
        SendMessageToPC(oPC, "You are out of medical supplies for today. Replenish them by resting.");
        return;
    }

    //Make sure the heal amount is more than zero.
    if(sTag == "Medical_Kit" && nAmount > 0)
    {
        //VFX
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealing, oTarget);
        //Heal
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        //Set Counter
        nUsed = nUsed + 1;
        SetLocalInt(oPC, "MEDKIT_USES", nUsed);
    }
    else if(nAmount < 1)
    {
        SendMessageToPC(oPC, "Your Heal skill is too low.");
    }
}
