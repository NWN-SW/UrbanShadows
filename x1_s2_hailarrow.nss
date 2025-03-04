//::///////////////////////////////////////////////
//:: x1_s2_hailarrow
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    One arrow per arcane archer level at all targets

    GZ SEPTEMBER 2003
        Added damage penetration

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
#include "x0_i0_spells"
#include "spell_dmg_inc"
// GZ: 2003-07-23 fixed criticals not being honored
void DoAttack(object oTarget)
{
    int nBonus = ArcaneArcherCalculateBonus();
    int nDamage;
    // * Roll Touch Attack
    int nTouch = TouchAttackRanged(oTarget, TRUE);
    if (nTouch > 0)
    {

        //Roll damage for each target
        int nMetaMagic;
        int nDamage = GetSixthLevelDamage(oTarget, 25, nMetaMagic, "AOE");

        //Adjust the damage based on the Reflex Save, Evasion, and Improved Evasion.
        string sElement = "Magi";
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
        nDamage = nDamage + nBonus;

        if (nDamage > 0)
        {
            // * GZ: Added correct damage power
            effect ePhysical = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING);
            effect eMagic = EffectDamage(nBonus, DAMAGE_TYPE_MAGICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePhysical, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMagic, oTarget);
            effect eImpact = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        }
    }
}

void main()
{
    object oTarget;

    int nLevel = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, OBJECT_SELF);
    int i = 0;
    float fDist = 0.0;
    float fDelay = 0.0;

    for (i = 1; i <= nLevel; i++)
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, i);
        if (GetIsObjectValid(oTarget) == TRUE && LineOfSightObject(OBJECT_SELF, oTarget))
        {
            fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
            fDelay = fDist/(3.0 * log(fDist) + 2.0);

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 603));
            effect eArrow = EffectVisualEffect(VFX_IMP_MIRV_ELECTRIC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);
            DelayCommand(fDelay, DoAttack(oTarget));
        }
    }
}
