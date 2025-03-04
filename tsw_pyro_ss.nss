//::///////////////////////////////////////////////
//:: Smokescreen by Alexander G.

#include "nw_i0_spells"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
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

    object oTarget = GetSpellTargetObject();

    //Declare major variables
    int nDuration = 5;
    int nLimit = 100;
    effect eStone = EffectDamageReduction(30, DAMAGE_POWER_PLUS_TWENTY, nLimit);
    effect eAC = EffectACIncrease(4);
    effect eVis = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eFlashy = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eEyes = EffectVisualEffect(VFX_EYES_ORG_HUMAN_MALE);
    if(GetGender(OBJECT_SELF) == GENDER_FEMALE)
    {
        eEyes = EffectVisualEffect(VFX_EYES_ORG_HUMAN_FEMALE);
    }
    //Link the visual and the damage reduction effect
    effect eLink = EffectLinkEffects(eStone, eVis);
    eLink = EffectLinkEffects(eLink, eEyes);
    eLink = EffectLinkEffects(eLink, eAC);
    //Enter Metamagic conditions
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    float fDuration = TurnsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);

    RemoveEffectsFromSpell(oTarget, GetSpellId());
    //Apply the linked effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFlashy, oTarget);

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}
