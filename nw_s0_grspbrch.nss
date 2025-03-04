//::///////////////////////////////////////////////
//Greater Spell Breach by Alexander.
//Sets target Spell Failure to 75% for 12 seconds.
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "tsw_class_func"
#include "spell_dmg_inc"

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


    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;

    effect eEffect = EffectSpellFailure(75);
    effect eVis = EffectVisualEffect(VFX_IMP_BREACH);
    effect eLink = EffectLinkEffects(eEffect, eVis);

    int nReduction = GetFocusReduction(OBJECT_SELF, "Magi");

    float fDuration = GetExtendSpell(10.0);
    float fFinalDuration = GetWillDuration(oTarget, nReduction, fDuration);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fFinalDuration);

    DoClassMechanic("Debuff", "Single", 0, oTarget);
}
