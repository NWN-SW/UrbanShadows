//////////////////////////////////////////////////
//Commander debuff aura onEnter
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

    //Negative Effects
    effect eVis = EffectVisualEffect(VFX_IMP_STARBURST_RED);
    effect eAC = EffectACDecrease(5);
    effect eDmg = EffectDamageDecrease(2);
    effect eAttack = EffectAttackDecrease(2);
    effect eLink = EffectLinkEffects(eAC, eDmg);
    eLink = EffectLinkEffects(eLink, eAttack);

    //Make the effect supernatural
    eLink = SupernaturalEffect(eLink);
    //Add a tag to the effect for removal later
    eLink = TagEffect(eLink, "Commander_Debuff_Effect");

    //Get Stack
    int nStack = GetLocalInt(oTarget, "COMMANDER_DEBUFF_STACK");

    if(GetIsObjectValid(oTarget) && GetIsReactionTypeHostile(oTarget, oPC))
    {
        if(nStack == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(60));
        }
        nStack = nStack + 1;
        SetLocalInt(oTarget, "COMMANDER_DEBUFF_STACK", nStack);
    }

    //Battle Brother Section
    int nDebuffBrother = GetLocalInt(oTarget, "COMMANDER_DEBUFF_BROTHER");
    int nBattleBrother = GetLocalInt(oTarget, "BATTLE_BROTHER");

    effect eBrotherVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eBrotherAC = EffectACIncrease(2);
    effect eBrotherATK = EffectAttackIncrease(2);
    effect eBrotherDMG = EffectDamageIncrease(2, DAMAGE_TYPE_POSITIVE);
    effect eBrotherLink = EffectLinkEffects(eBrotherAC, eBrotherATK);
    eBrotherLink = EffectLinkEffects(eBrotherLink, eBrotherDMG);

    //Make the effect supernatural
    eBrotherLink = SupernaturalEffect(eBrotherLink);
    //Add a tag to the effect for removal later
    eBrotherLink = TagEffect(eBrotherLink, "Commander_Debuff_Brother");

    if(GetIsObjectValid(oTarget) && nBattleBrother == 1)
    {
        if(nDebuffBrother == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBrotherVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(60));
        }
        nDebuffBrother = nDebuffBrother + 1;
        SetLocalInt(oTarget, "COMMANDER_DEBUFF_BROTHER", nDebuffBrother);
    }

    //Break stealth
    if(GetStealthMode(GetAreaOfEffectCreator()) == 1)
    {
        SetActionMode(GetAreaOfEffectCreator(), ACTION_MODE_STEALTH, FALSE);
    }

}

