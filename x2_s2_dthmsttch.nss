//::///////////////////////////////////////////////
//:: Deathless Master Touch
//:: X2_S2_dthmsttch
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Pale Master may use their undead arm to
    kill their foes.

    -Requires melee Touch attack
    -Save vs DC 17 to resist

    Epic:
    -SaveDC raised by +1 for each 2 levels past 10th
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: July, 24, 2003
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"
#include "X2_inc_switches"
#include "spell_dmg_inc"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    //object oCaster = GetCurrentHitPoints(OBJECT_SELF);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    //Get highest casting stat
    int nINT = GetAbilityModifier(3);
    int nCHA = GetAbilityModifier(5);
    int nMain = nINT;
    if (nCHA > nINT)
    {
        nMain = nCHA;
    }
    int nNecroLevel = GetLevelByClass(CLASS_TYPE_PALEMASTER);

    //Roll damage for each target
    string sElement = "Nega";
    int nDamage = GetNinthLevelDamage(oTarget, nNecroLevel, nMetaMagic, "Single");

    //Adjust the damage based on the Reflex Save, Evasion, and Improved Evasion.
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
    nDC = nDC + nBonusDC;
    nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    nDamage = GetFortDamage(oTarget, nDC, nDamage);

    //Declare effects
    effect eSlay = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DEATH);

    //Link effects

    if(TouchAttackMelee(oTarget,TRUE)>0)
    {
        //Signal spell cast at event
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 624));
        //Saving Throw

        if ((GetCreatureSize(oTarget)>CREATURE_SIZE_LARGE )&& (GetModuleSwitchValue(MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH) == TRUE))
        {
            return; // creature too large to be affected.
        }

        //Apply effects to target and caster
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSlay, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);

   }

}
