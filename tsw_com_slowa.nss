//////////////////////////////////////////////////
//Commander slow aura onEnter
///////////////////////////////////////////////////

#include "spell_dmg_inc"

void main()
{
    //Declare major variables
    object oPC = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();

    if(!GetIsReactionTypeHostile(oTarget, oPC))
    {
        return;
    }

    //Alchemite block
    //Get Alchemite
    string sElement = "Soni";
    int nReduction = GetFocusReduction(oPC, sElement);

    //Negative Effects
    effect eVis = EffectVisualEffect(VFX_IMP_STARBURST_RED);
    int nSlowAmount = GetFortDamage(oTarget, nReduction, 50);
    effect eSlow;

    //Add a tag to the effect for removal later
    eSlow = TagEffect(eSlow, "Commander_Slow_Effect");

    //Get Stack
    int nStack = GetLocalInt(oTarget, "COMMANDER_SLOW_STACK");

    if(GetIsObjectValid(oTarget) && GetIsReactionTypeHostile(oTarget, oPC) && LineOfSightObject(GetAreaOfEffectCreator(), oTarget))
    {
        if(nStack == 0)
        {
            eSlow = EffectMovementSpeedDecrease(nSlowAmount);
            eSlow = TagEffect(eSlow, "Commander_Slow_Effect");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, TurnsToSeconds(2));
        }
        nStack = nStack + 1;
        SetLocalInt(oTarget, "COMMANDER_SLOW_STACK", nStack);
    }

    //Battle Brother Section
    int nSlowBrother = GetLocalInt(oTarget, "COMMANDER_SLOW_BROTHER");
    int nBattleBrother = GetLocalInt(oTarget, "BATTLE_BROTHER");

    effect eBrotherVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eBrotherSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, 10);

    //Make the effect supernatural
    eBrotherSaves = SupernaturalEffect(eBrotherSaves);
    //Add a tag to the effect for removal later
    eBrotherSaves = TagEffect(eBrotherSaves, "Commander_Slow_Brother");

    if(GetIsObjectValid(oTarget) && nBattleBrother == 1)
    {
        if(nSlowBrother == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBrotherVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBrotherSaves, oTarget, TurnsToSeconds(60));
        }
        nSlowBrother = nSlowBrother + 1;
        SetLocalInt(oTarget, "COMMANDER_SLOW_BROTHER", nSlowBrother);
    }

}

