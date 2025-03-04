#include "tsw_class_func"
#include "spell_dmg_inc"

void main()
{
    effect eBuff = EffectDamageIncrease(5);
    effect eRegen = EffectRegenerate(2, 1.0);

    effect eAura = EffectVisualEffect(553);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);

    effect eLink = EffectLinkEffects(eBuff, eAura);

    float fDuration = GetExtendSpell(30.0);
    float fDuration2 = GetExtendSpell(15.0);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, fDuration2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, "Single", 0, OBJECT_SELF);
}
