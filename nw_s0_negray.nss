//::///////////////////////////////////////////////
//:: Negative Energy Ray by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    string sElement = "Nega";

    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eRay;

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_RAY));
    eRay = EffectBeam(1114, OBJECT_SELF, BODY_NODE_HAND);
    if(GetIsEnemy(oTarget, OBJECT_SELF))
    {
        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "Single";
            int nDamage = GetFirstLevelDamage(oTarget, 0, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Nega";
            int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

            //Adjust damage based on Alchemite and Saving Throw
            nDamage = GetFortDamage(oTarget, nReduction, nDamage);
        //End Custom Spell-Function Block

        //Damage Effect
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
        //Apply the VFX impact and effects
        //DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);

        //Fire cast spell at event for the specified target
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);

        //Class mechanics
        string sSpellType = "Occult";
        DoClassMechanic(sSpellType, "Single", nDamage, oTarget);
    }
}
