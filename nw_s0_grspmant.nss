//::///////////////////////////////////////////////
//:: Greater Spell Mantle by Alexander G.
//:://////////////////////////////////////////////
#include "nw_i0_spells"
#include "spell_dmg_inc"
#include "x2_inc_spellhook"
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
    effect eVis = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    float fDuration = TurnsToSeconds(3);
    fDuration = GetExtendSpell(fDuration);
    int nAbsorb = 0;
    string sElement = "Magi";

    nAbsorb = 50;

    //Don't use full Alchemite bonus
    SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);

    //Adjust the absorbtion based on spell focus
    nAbsorb = GetFocusDmg(OBJECT_SELF, nAbsorb, sElement);

    //Link Effects
    effect eAbsob = EffectSpellLevelAbsorption(9, nAbsorb);
    effect eLink = EffectLinkEffects(eVis, eAbsob);
    eLink = EffectLinkEffects(eLink, eDur);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_SPELL_MANTLE, FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    RemoveEffectsFromSpell(oTarget, SPELL_SPELL_MANTLE);
    RemoveEffectsFromSpell(oTarget, SPELL_LESSER_SPELL_MANTLE);
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

    DoClassMechanic("Buff", "Single", 0, oTarget);
}

