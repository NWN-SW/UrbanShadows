//::///////////////////////////////////////////////
// Guidance by Alexander G.

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
    float fDuration = GetExtendSpell(30.0);
    effect eDread = EffectRunScript("", "", "tsw_dread_run", 3.0);
    effect eVis = EffectVisualEffect(1099);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eDur = EffectLinkEffects(eDur, eDread);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the bonuses and the VFX impact
    if(!GetIsReactionTypeHostile(oTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);
    }

    DoClassMechanic("Control", "Single", 0, oTarget);
    DoClassMechanic("Buff", "Single", 0, oTarget);
}
