//::///////////////////////////////////////////////
//:: Light of Redemption by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{

    object oTarget = GetSpellTargetObject();
    int nHeal = GetHighestAbilityModifier(OBJECT_SELF) * 5;

    if(GetArea(oTarget) != GetArea(OBJECT_SELF))
    {
        return;
    }

    //Buff heal bonus on Alchemite
    int nBonus = GetFocusDmg(OBJECT_SELF, 0, "Holy");
    nBonus = nBonus / 5;
    if(nBonus < 1)
    {
        nBonus = 1;
    }

    nHeal = nHeal + nBonus;

    effect eVis = EffectVisualEffect(974);
    effect eHeal = EffectHeal(nHeal);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);

    //Class mechanics
    DoClassMechanic("Buff", "Single", nHeal, oTarget, OBJECT_SELF, 1, 1);

    //Use Anima
    int nAnima = UseAnima(OBJECT_SELF, GetSpellId());
}

