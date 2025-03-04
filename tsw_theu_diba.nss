//::///////////////////////////////////////////////
//Divine Barrage by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Declare major variables  ( fDist / (3.0f * log( fDist ) + 2.0f) )
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage = 0;
    int nCnt;
    effect eMissile = EffectVisualEffect(1115);
    effect eVis = EffectVisualEffect(964);
    int nMissiles = 12;
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);
    //Short missile delay
    float fMissileDelay;
    //Limit missiles to five
    if(nMissiles == 0)
    {
        nMissiles = 1;
    }

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        nDamage = GetFifthLevelDamage(oTarget, nCasterLvl, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Holy";
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
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        //Apply a single damage hit for each missile instead of as a single mass
        //Make SR Check
        for (nCnt = 1; nCnt <= nMissiles; nCnt++)
        {
            //Set damage effect
            effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_DIVINE);

            //Apply the MIRV and damage effect
            DelayCommand(fMissileDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
            fMissileDelay = fMissileDelay + 0.1;
            fDelay = fDelay + 0.1;
        }
    }

    DoClassMechanic("Occult", "Single", nDamage, oTarget);
}

