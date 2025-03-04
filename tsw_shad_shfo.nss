#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    effect eVis = EffectVisualEffect(1018);
    effect eVis2 = EffectVisualEffect(1021);
    effect eDur = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eRun = EffectRunScript("", "", "tsw_shadform_run", 6.0);
    int nAmount = GetHighestAbilityModifier(OBJECT_SELF) * 10;
    float fDuration = GetExtendSpell(120.0);
    //Define the damage reduction effect
    effect eShield = EffectDamageReduction(50, DAMAGE_POWER_PLUS_TWENTY, nAmount);
    //Link the effects
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eRun);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, OBJECT_SELF);

    //Class mechanics
    DoMartialMechanic("Guile", "Single", 0, OBJECT_SELF);
    DoClassMechanic("Buff", "Single", 0, OBJECT_SELF);
}
