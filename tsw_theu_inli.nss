//::///////////////////////////////////////////////
// Might by Alexander G.
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
    float fDuration = GetExtendSpell(30.0);
    int nAmount =  GetHighestAbilityModifier(OBJECT_SELF) * 5;
    effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    effect eBonus;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    eBonus = EffectDamage(nAmount, DAMAGE_TYPE_POSITIVE);
    effect eDur = EffectVisualEffect(1067);
    effect eHeal = EffectHeal(nAmount * 2);

    //Apply the armor bonuses and the VFX impact
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBonus, oTarget);
    SetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT", 1);
    DelayCommand(12.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
    DelayCommand(fDuration, DeleteLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT"));

    DoClassMechanic("Buff", "Single", 0, oTarget);
}
