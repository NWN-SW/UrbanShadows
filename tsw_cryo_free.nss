//::///////////////////////////////////////////////
//:: Freeze by Alexander G.
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
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(1094);

    effect eLink = EffectLinkEffects(eDur2, eDur);
    eLink = EffectLinkEffects(eLink, eParal);

    //Spell Focus bonus DC
    string sElement = "Cold";
    int nReduction = GetFocusReduction(OBJECT_SELF, sElement);
    fDuration = GetReflexDuration(oTarget, nReduction, fDuration);

    if(GetIsReactionTypeHostile(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Apply paralyze effect and VFX impact
        if(!GetHasSpellEffect(GetSpellId(), oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }

    //Class mechanics
    DoClassMechanic("Control", "Single", 0, oTarget);
    DoClassMechanic("Cold", "Single", 0, oTarget);
}
