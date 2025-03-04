//::///////////////////////////////////////////////
//Quivering Palm by Alexander G.
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_itemprop"
#include "spell_dmg_inc"

void main()
{
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_MONK, OBJECT_SELF);
    effect eVis = EffectVisualEffect(234);
    effect eVisFail = EffectVisualEffect(203);

    if (GetIsObjectValid(oTarget) == TRUE)
    {
        // * Roll Touch Attack
        int nTouch = TouchAttackMelee(oTarget, TRUE);
        if (nTouch > 0)
        {
            int nDamage = nCasterLvl;
            if (nDamage > 0)
            {
                effect eMagic = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);

                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

                //Roll damage for each target
                int nMetaMagic;
                nDamage = nDamage + GetNinthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");

                //Adjust the damage based on the Reflex Save, Evasion, and Improved Evasion.
                int nDC = 30 + nCasterLvl + GetAbilityModifier(ABILITY_WISDOM);
                nDamage = GetFortDamage(oTarget, nDC, nDamage);
                effect eDeath = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisFail, oTarget);
            }
        }
    }
}

