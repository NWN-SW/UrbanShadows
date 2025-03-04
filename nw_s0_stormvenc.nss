//::///////////////////////////////////////////////
//:: Storm of Vengeance: Heartbeat by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

    //Declare major variables
    int nFinalDamage;
    effect eVisElec = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    //effect eVisStun = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    float fDelay;
    string sTargets;
    string sElement;
    int nReduction;
    int nDamage;
    int nTargetCheck = 0;
    object oMainTarget;
    object oCaster =GetAreaOfEffectCreator();
    //Get first target in spell area
    object oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, GetAreaOfEffectCreator()))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_STORM_OF_VENGEANCE));
            //Make an SR Check
            fDelay = GetRandomDelay(0.5, 2.0);

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Elec";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            fDelay = GetRandomDelay(1.5, 2.5);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRE_STORM));

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
            nFinalDamage = nFinalDamage / 3;

            effect eElec = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);

            //Apply the VFX impact and effects
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisElec, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eElec, oTarget));

         }
        //Get next target in spell area
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE);
    }
}
