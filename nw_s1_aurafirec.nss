//::///////////////////////////////////////////////
//Custom Fire Aura by Alexander G.
//:://////////////////////////////////////////////
#include "spell_dmg_inc"
#include "NW_I0_SPELLS"


void main()
{
    //Declare major variables
    int nCasterLevel = GetCasterLevel(GetAreaOfEffectCreator());
    object oCaster = GetAreaOfEffectCreator();
    effect eDam;
    int nDamage;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    string sTargets;
    string sElement;
    int nReduction;
    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Get first target in spell area
    object oTarget = GetFirstInPersistentObject();

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget, GetAreaOfEffectCreator()))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELLABILITY_AURA_FIRE));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSecondLevelDamage(oTarget, nCasterLevel, sTargets);
                nDamage = nDamage / 3;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Fire";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
        //Get next target in spell area
        oTarget = GetNextInPersistentObject();
    }
}
