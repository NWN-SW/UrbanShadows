//::///////////////////////////////////////////////
//:: Cosmic Shield by Alexander G.
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


    object oTarget = GetSpellTargetObject();

    //Cancel if alternate version still exists
    if(GetHasSpellEffect(931, oTarget))
    {
        SendMessageToPC(OBJECT_SELF, "Target already has Cosmic Aegis.");
        return;
    }

    //Declare major variables
    float fDuration = TurnsToSeconds(10);
    fDuration = GetExtendSpell(fDuration);
    int nLimit = GetHighestAbilityModifier(OBJECT_SELF);
    nLimit = nLimit * 10;
    int nAmount = 20;

    effect eMag = EffectDamageResistance(DAMAGE_TYPE_MAGICAL, nAmount, nLimit);
    effect eDiv = EffectDamageResistance(DAMAGE_TYPE_DIVINE, nAmount, nLimit);
    //effect ePos = EffectDamageResistance(DAMAGE_TYPE_POSITIVE, nAmount, nLimit);
    effect eNeg = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, nAmount, nLimit);
    effect eDur = EffectVisualEffect(1066);
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH_WARD);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_BUFFER, FALSE));

    //Link Effects
    effect eLink = EffectLinkEffects(eMag, eDiv);
    //eLink = EffectLinkEffects(eLink, ePos);
    eLink = EffectLinkEffects(eLink, eNeg);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    DoClassMechanic("Buff", "Single", 0, oTarget);
}

