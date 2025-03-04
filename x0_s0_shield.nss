//::///////////////////////////////////////////////
//Shield by Alexander G.

#include "NW_I0_SPELLS"
#include "spell_dmg_inc"
#include "x2_inc_spellhook"
#include "tsw_class_func"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
    object oTarget = OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    int nAmount =  GetCasterLevel(OBJECT_SELF);
    nAmount = 4;

    effect eArmor = EffectACIncrease(nAmount, AC_SHIELD_ENCHANTMENT_BONUS);
    //effect eArmor = EffectDamageReduction(12, DAMAGE_POWER_PLUS_FIVE, 50);
    effect eSpell = EffectSpellImmunity(SPELL_MAGIC_MISSILE);
    effect eDur = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);

    effect eLink = EffectLinkEffects(eArmor, eDur);
    eLink = EffectLinkEffects(eLink, eSpell);

    int nDuration = 10;
    float fDuration = TurnsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);

    //Fire spell cast at event for target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 417, FALSE));

    RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());

    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);

    DoClassMechanic("Buff", "Single", 0, oTarget);
}



