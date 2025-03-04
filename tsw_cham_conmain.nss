#include "spell_dmg_inc"

//Vincere
void DoChampHeal(object oCaster)
{
    int nCheck = GetLocalInt(oCaster, "CHAMPION_CONFIRMA");
    if(nCheck != 1)
    {
        return;
    }

    //Effect variables
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
    string sElement = "Holy";
    int nAmount = GetHighestAbilityModifier(oCaster);
    effect eHeal = EffectHeal(nAmount);

    //Do heal
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCaster);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oCaster);
}
