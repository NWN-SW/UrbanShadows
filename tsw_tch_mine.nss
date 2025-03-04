//::///////////////////////////////////////////////
//Technician cluster mines go boom. Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();
    object oCaster = GetAreaOfEffectCreator();
    object oMainTarget;
    location lTarget = GetLocation(OBJECT_SELF);
    //Custom spell size
    float fSize = GetSpellArea(10.0);

    int nDamage;
    int nFinalDamage;
    int nCasterLevel = GetCasterLevel(oCaster);
    int nFire = GetLocalInt(OBJECT_SELF, "NW_SPELL_DELAY_BLAST_FIREBALL");
    //Limit caster level
    effect eDam;
    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    //Check the faction of the entering object to make sure the entering object is not in the casters faction
    if(nFire == 0)
    {
        if(GetIsReactionTypeHostile(oTarget, oCaster))
        {
            SetLocalInt(OBJECT_SELF, "NW_SPELL_DELAY_BLAST_FIREBALL",TRUE);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

            //Save the first valid target for the class mechanic
            oMainTarget = oTarget;

            //Start Custom Spell-Function Block
                //Get damage
                string sTargets = "AOE";
                nDamage = GetFifthLevelDamage(oTarget, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                string sElement = "Fire";
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Cycle through the targets in the explosion area
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

            while(GetIsObjectValid(oTarget))
            {
                if (GetIsReactionTypeHostile(oTarget, oCaster))
                {
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));

                    //Adjust damage based on Alchemite and Saving Throw
                    nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
                    //Set up the damage effect
                    eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
                    if(nDamage > 0)
                    {
                        //Apply VFX impact and damage effect
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                        DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    }
                }
                //Get next target in the sequence
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
            }
            DestroyObject(OBJECT_SELF, 1.0);

            //Class mechanics
            string sSpellType = "Tactic";
            DoMartialMechanic(sSpellType, "AOE", nFinalDamage, oMainTarget, oCaster);
        }
    }
}
