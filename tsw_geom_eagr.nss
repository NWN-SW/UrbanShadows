//::///////////////////////////////////////////////
//:: Earthgrab by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    float fDuration = GetExtendSpell(12.0);
    effect eParal = EffectMovementSpeedDecrease(99);
    effect eVis = EffectVisualEffect(VFX_COM_HIT_ACID);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_STONEHOLD);

    effect eLink = EffectLinkEffects(eDur2, eDur);
    eLink = EffectLinkEffects(eLink, eParal);
    eLink = EffectLinkEffects(eLink, eVis);

    //Spell Focus bonus DC
    string sElement = "Acid";
    int nReduction = GetFocusReduction(OBJECT_SELF, sElement);
    fDuration = GetReflexDuration(oTarget, nReduction, fDuration);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLD_PERSON));

        //Apply paralyze effect and VFX impact
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    }

    //Class mechanics
    DoClassMechanic("Control", "Single", 0, oTarget);
    DoClassMechanic("Earth", "Single", 0, oTarget);
}
