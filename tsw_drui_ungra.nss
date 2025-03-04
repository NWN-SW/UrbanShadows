//::///////////////////////////////////////////////
//:: Untamed Growth OnEnter by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    //Declare major variables
    effect eEntangle = EffectVisualEffect(VFX_DUR_AURA_PULSE_GREEN_BLACK);
    effect eImpact = EffectVisualEffect(VFX_IMP_ACID_L);
    object oCreator = GetAreaOfEffectCreator();
    int bValid;
    float fDuration = GetExtendSpell(30.0);

    object oTarget = GetEnteringObject();
    int nCheck = GetLocalInt(oTarget, "DRUID_UNTAMTED_CHECK");

    //Spell Focus bonus DC
    string sElement = "Acid";
    int nReduction = GetFocusReduction(oCreator, sElement);

    if(GetIsReactionTypeHostile(oTarget, oCreator) && nCheck != 1)
    {
        //Fire cast spell at event for the specified target
        fDuration = GetFortDuration(oTarget, nReduction, fDuration);
        SignalEvent(oTarget, EventSpellCastAt(oCreator, GetSpellId()));
        effect eHold = EffectMovementSpeedDecrease(50);
        int nAmount = GetHighestAbilityModifier(oCreator);
        effect eSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, nAmount);
        //Link Entangle and Hold effects
        effect eLink = EffectLinkEffects(eHold, eEntangle);
        eLink = EffectLinkEffects(eLink, eSaves);

       //Apply linked effects
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
       SetLocalInt(oTarget, "DRUID_UNTAMTED_CHECK", 1);
    }
}
