//::///////////////////////////////////////////////
//Theurgist Death wall onEnter
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{




    //Declare major variables
    object oTarget = GetEnteringObject();
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    string sTargets;
    int nFinalDamage;
    int nTargetCheck;
    object oMainTarget;
    string sElement;
    object oCaster = OBJECT_SELF;
    int nReduction;
    int nDamage;

    if (GetIsReactionTypeHostile(oTarget, GetAreaOfEffectCreator()))
    {
        //Fire spell cast at event
        SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), GetSpellId()));

        //Start Custom Spell-Function Block
            //Get damage
            sTargets = "AOE";
            nDamage = GetSeventhLevelDamage(oTarget, nCasterLvl, sTargets);
            nDamage = nDamage / 3;

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            sElement = "Nega";
            nReduction = GetFocusReduction(oCaster, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);

        if (oTarget != GetAreaOfEffectCreator())
        {
            //Set damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_NEGATIVE);
            //Apply damage and VFX
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}

