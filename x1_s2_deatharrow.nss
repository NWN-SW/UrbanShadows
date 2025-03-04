//::///////////////////////////////////////////////
//:: x1_s2_deatharrow
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Seeker Arrow
     - creates an arrow that automatically hits target.
     - At level 4 the arrow does +2 magic damage
     - at level 5 the arrow does +3 magic damage

     - normal arrow damage, based on base item type

     - Must have shortbow or longbow in hand.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_itemprop"
#include "spell_dmg_inc"

void main()
{
    int nBonus = nBonus = ArcaneArcherCalculateBonus();

    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetLevelByClass(29, OBJECT_SELF);
    effect eVis = EffectVisualEffect(234);
    effect eVisFail = EffectVisualEffect(203);
    effect eAC = EffectACDecrease(4);

    if (GetIsObjectValid(oTarget) == TRUE)
    {
        // * Roll Touch Attack
        int nTouch = TouchAttackRanged(oTarget, TRUE);
        if (nTouch > 0)
        {
            int nDamage = ArcaneArcherDamageDoneByBow((nTouch == 2));
            if (nDamage > 0)
            {
                effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,IPGetDamagePowerConstantFromNumber(nBonus));
                effect eMagic = EffectDamage(nBonus, DAMAGE_TYPE_MAGICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);

                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

                //Roll damage for each target
                int nMetaMagic;
                string sElement = "Dark";
                nDamage = nDamage + GetNinthLevelDamage(oTarget, nCasterLvl, nMetaMagic, "Single");

                //Adjust the damage based on the Reflex Save, Evasion, and Improved Evasion.
                int nDC = GetSpellSaveDC();
                int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
                nDC = nDC + nBonusDC;
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                nDamage = GetFortDamage(oTarget, nDC, nDamage);
                effect eDeath = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisFail, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, RoundsToSeconds(nCasterLvl));
            }
        }
    }
}

