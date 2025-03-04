//::///////////////////////////////////////////////
//:: Prismatic Bolt by Alexander G.
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
    float fDuration = GetExtendSpell(8.0);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        //int nDamage = GetFirstLevelDamage(oTarget, nCasterLevel, sTargets);
        //nDamage = nDamage - 25;

        //Buff damage by Amplification elvel
       // nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Magi";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        //nDamage = GetFocusDmg(oCaster, nDamage, sElement);
    //End Custom Spell-Function Block

    effect eVis = EffectVisualEffect(VFX_FNF_PWSTUN);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DISPEL);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        fDuration = GetWillDuration(oTarget, nReduction, fDuration);

        effect eSilence = EffectSilence();
        //Apply the VFX impact and damage effect
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilence, oTarget, fDuration);
    }

    DoClassMechanic("Control", "Single", 0, oTarget);
}




