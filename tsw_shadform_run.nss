#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    int nAmount = GetHighestAbilityModifier(OBJECT_SELF);
    effect eHeal = EffectHeal(nAmount);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_MIND);
    int nCheck = GetLocalInt(OBJECT_SELF, "SHADOW_IN_DARKNESS");

    if(nCheck != 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    }
}
