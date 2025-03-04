//::///////////////////////////////////////////////
//:: Vine Growth OnEnter by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    //Declare major variables
    effect eEntangle = EffectVisualEffect(VFX_DUR_ENTANGLE);
    object oCreator = GetAreaOfEffectCreator();
    int bValid;

    object oTarget = GetEnteringObject();

    //Spell Focus bonus DC
    string sElement = "Acid";
    int nReduction = GetFocusReduction(oCreator, sElement);

    if(GetIsReactionTypeHostile(oTarget, oCreator))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(oCreator, SPELL_ENTANGLE));
        //Make SR check
        if(!GetHasSpellEffect(SPELL_ENTANGLE, oTarget))
        {
            int nDuration = GetFortDamage(oTarget, nReduction, 80);
            effect eHold = EffectMovementSpeedDecrease(nDuration);
            //Link Entangle and Hold effects
            effect eLink = EffectLinkEffects(eHold, eEntangle);
            eLink = TagEffect(eLink, "DRUID_ENTANGLE_EFFECT");

           //Apply linked effects
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(999));
        }
    }
}
