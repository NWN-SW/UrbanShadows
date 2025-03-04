//::///////////////////////////////////////////////
// Divine Shield by Alexander G.
//::///////////////////////////////////////////////

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
    float fDuration = TurnsToSeconds(10);
    fDuration = GetExtendSpell(fDuration);
    int nAmount =  5;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eBonus;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    eBonus = EffectSavingThrowIncrease(SAVING_THROW_ALL, nAmount);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eDur = EffectLinkEffects(eDur, eBonus);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    DoClassMechanic("Buff", "Single", 0, oTarget);
}
