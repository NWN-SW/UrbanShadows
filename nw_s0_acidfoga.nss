//::///////////////////////////////////////////////
//:: Acid Fog: On Enter by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

    //Declare major variables
    int nDamage;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eSlow = EffectMovementSpeedDecrease(50);
    object oCaster = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    float fDelay = GetRandomDelay(1.0, 2.2);
    string sTargets;
    string sElement;
    int nReduction;
    int nFinalDamage;
    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the target
        SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_ACID_FOG));
            //Roll damage for each target
            int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSeventhLevelDamage(oTarget, nCasterLvl, sTargets);
                nDamage = nDamage / 2;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Acid";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
            nFinalDamage = nFinalDamage / 8;

            //Slowing effect
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget);

            //Set Damage Effect with the modified damage
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_ACID);
            //Apply damage and visuals
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
}
