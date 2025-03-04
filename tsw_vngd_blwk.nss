//::///////////////////////////////////////////////
//:: Bulwark by Alexander G.
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

    if(GetHasSpellEffect(893))
    {
        SendMessageToPC(OBJECT_SELF, "Bulwark is already active.");
        return;
    }

    //Declare major variables
    effect eStone;
    effect eVis = EffectVisualEffect(228, FALSE, 0.9);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink;
    object oTarget = GetSpellTargetObject();
    int nAmount = GetHighestAbilityModifier(OBJECT_SELF) * 20;
    float fDuration = GetExtendSpell(120.0);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Define the damage reduction effect
    eStone = EffectDamageReduction(20, DAMAGE_POWER_PLUS_TWENTY, nAmount);
    //Link the effects
    eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eDur);

    //Apply the linked effects.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

    //Class mechanics
    DoMartialMechanic("Tactic", "Single", 0, OBJECT_SELF);
    DoClassMechanic("Buff", "Single", 0, OBJECT_SELF);
}
