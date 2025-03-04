//::///////////////////////////////////////////////
//Flame Arrow by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

const int VFX_IMP_MIRV_MISSILE = 821;

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


    //Declare major variables  ( fDist / (3.0f * log( fDist ) + 2.0f) )
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage = 0;
    int nCnt;
    effect eMissile = EffectVisualEffect(VFX_IMP_MIRV_MISSILE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    int nMissiles = 10;
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    //Limit missiles to five
    if(nMissiles == 0)
    {
        nMissiles = 1;
    }

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        nDamage = GetSixthLevelDamage(oTarget, nCasterLvl, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Fire";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

        //Adjust damage based on Alchemite and Saving Throw
        nDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        int nFinalDamage = nDamage / nMissiles;
    //End Custom Spell-Function Block

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_ARROW));
        //Apply a single damage hit for each missile instead of as a single mass
        //Make SR Check
        for (nCnt = 1; nCnt <= nMissiles; nCnt++)
        {
            //Set damage effect
            effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
            //Apply the MIRV and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));

        }
    }

    DoMartialMechanic("Assault", "Single", nDamage, oTarget);

}

