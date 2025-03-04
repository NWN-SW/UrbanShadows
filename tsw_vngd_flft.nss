//::///////////////////////////////////////////////
//:: Final Fortress by Alexander G.
//:://////////////////////////////////////////////

#include "nw_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "x2_inc_spellhook"

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
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(495);

    effect eSlow = EffectMovementSpeedDecrease(99);
    object oTarget = GetSpellTargetObject();
    int nAmount = GetHighestAbilityModifier(OBJECT_SELF) * 20;
    float fDuration = GetExtendSpell(18.0);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Apply the linked effects.
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, OBJECT_SELF, fDuration);

    //Plot Flag
    SetPlotFlag(OBJECT_SELF, 1);
    DelayCommand(fDuration, SetPlotFlag(OBJECT_SELF, 0));

    //Class mechanics
    DoMartialMechanic("Tactic", "Single", 0, OBJECT_SELF);
}
