//::///////////////////////////////////////////////
//Elemental Shield by Alexander G.
//:://////////////////////////////////////////////
#include "nw_i0_spells"
#include "tsw_class_func"
#include "x2_inc_spellhook"
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


    //Declare major variables
    object oTarget = GetSpellTargetObject();

    //Cancel if alternate version still exists
    if(GetHasSpellEffect(932, oTarget))
    {
        SendMessageToPC(OBJECT_SELF, "Target already has Elemental Aegis.");
        return;
    }

    float fDuration = TurnsToSeconds(10);
    fDuration = GetExtendSpell(fDuration);
    int nLimit = GetHighestAbilityModifier(OBJECT_SELF);
    nLimit = nLimit * 10;
    int nAmount = 20;

    effect eCold = EffectDamageResistance(DAMAGE_TYPE_COLD, nAmount, nLimit);
    effect eFire = EffectDamageResistance(DAMAGE_TYPE_FIRE, nAmount, nLimit);
    effect eAcid = EffectDamageResistance(DAMAGE_TYPE_ACID, nAmount, nLimit);
    effect eSonic = EffectDamageResistance(DAMAGE_TYPE_SONIC, nAmount, nLimit);
    effect eElec = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, nAmount, nLimit);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_ELEMENTS);
    effect eVis = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Link Effects
    effect eLink = EffectLinkEffects(eCold, eFire);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eSonic);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    DoClassMechanic("Buff", "Single", 0, OBJECT_SELF);
}
