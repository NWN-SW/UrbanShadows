//::///////////////////////////////////////////////
//:: Predator's Cowl by Alexander G.
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
    effect eStone;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink;
    int nAmount = GetHighestAbilityModifier(OBJECT_SELF) * 2;
    float fDuration = GetExtendSpell(60.0);
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Define the damage resistance effects
    effect eVis = EffectVisualEffect(1019);
    effect eVis2 = EffectVisualEffect(963);
    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, nAmount);
    effect eCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, nAmount);
    effect eElec = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, nAmount);
    effect eAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, nAmount);
    effect eNega = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nAmount);
    effect eMagi = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, nAmount);
    effect eSoni = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, nAmount);
    effect eDivi = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, nAmount);
    effect eSlas = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, nAmount);
    effect ePier = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, nAmount);
    effect eBlud = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, nAmount);

    eLink = EffectLinkEffects(eFire, eCold);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eNega);
    eLink = EffectLinkEffects(eLink, eMagi);
    eLink = EffectLinkEffects(eLink, eSoni);
    eLink = EffectLinkEffects(eLink, eDivi);
    eLink = EffectLinkEffects(eLink, eSlas);
    eLink = EffectLinkEffects(eLink, ePier);
    eLink = EffectLinkEffects(eLink, eBlud);

    //Apply the linked effects.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    DelayCommand(2.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);

    //Sound Effects
    PlaySoundByStrRef(16778140, FALSE);

    //Class mechanics
    DoMartialMechanic("Tactic", "Single", 0, OBJECT_SELF);
    DoClassMechanic("Buff", "Single", 0, OBJECT_SELF);
}
