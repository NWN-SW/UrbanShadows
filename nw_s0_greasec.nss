//::///////////////////////////////////////////////
//:: Grease: Heartbeat
//:: NW_S0_GreaseC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creatures entering the zone of grease must make
    a reflex save or fall down.  Those that make
    their save have their movement reduced by 1/2.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 1, 2001
//:://////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "tsw_class_func"
#include "spell_dmg_inc"

void main()
{


    //Declare major variables
    object oTarget;
    effect eDamage;
    int nDamage;
    float fDelay;
    int nLevel = GetCasterLevel(GetAreaOfEffectCreator());
    object oCaster = GetAreaOfEffectCreator();

    //Get first target in spell area
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) &&(GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
        {
            if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
            {
                fDelay = GetRandomDelay(0.0, 2.0);
                //Start Custom Spell-Function Block
                    //Get damage
                    string sTargets = "AOE";
                    nDamage = GetFirstLevelDamage(oTarget, nLevel, sTargets);

                    //Buff damage by Amplification elvel
                    nDamage = GetAmp(nDamage);

                    //Get the Alchemite resistance reduction
                    string sElement = "Acid";
                    int nReduction = GetFocusReduction(oCaster, sElement);

                    //Buff damage bonus on Alchemite
                    nDamage = GetFocusDmg(oCaster, nDamage, sElement);
                //End Custom Spell-Function Block

                //Adjust damage based on Alchemite and Saving Throw
                int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
                nFinalDamage = nFinalDamage / 3;

                eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_ACID);

                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextInPersistentObject();
    }
}

