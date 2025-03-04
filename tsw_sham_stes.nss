//::///////////////////////////////////////////////
//:: Steal Essence by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "tsw_class_func"
#include "spell_dmg_inc"

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
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetFirstLevelDamage(oTarget, nCasterLevel, sTargets);
        nDamage = nDamage - 50;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Nega";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(oCaster, nDamage, sElement);
    //End Custom Spell-Function Block


    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eHealVis = EffectVisualEffect(VFX_IMP_STARBURST_GREEN);
    if(GetIsReactionTypeHostile(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Adjust damage based on Alchemite and Saving Throw
        nDamage = GetFortDamage(oTarget, nReduction, nDamage);
        int nHeal = nDamage / 5;

        effect eBad = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
        effect eHeal = EffectHeal(nHeal);
        //Apply the VFX impact and damage effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
        if(GetMaxHitPoints(OBJECT_SELF) > GetCurrentHitPoints(OBJECT_SELF))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, OBJECT_SELF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);
        }
    }
}




