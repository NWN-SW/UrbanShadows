//Seal of Scourge by Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fSize = GetSpellArea(30.0);
    effect eImpact = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eDam;
    string sTargets;
    string sElement;
    //Get the spell target location as opposed to the spell target.
    object oTarget = GetSpellTargetObject();
    location lTarget = GetLocation(oTarget);
    object oNextTarget, oTarget2;
    object oMainTarget;
    int nTargetCheck = 0;
    int nCount = 1;

    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCount);

    while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= fSize)
    {
        //Get first target in the lightning area by passing in the location of first target and the casters vector (position)
        oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
        while (GetIsObjectValid(oTarget))
        {
           //Exclude the caster from the damage effects
           if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
           {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
                {
                    //Start Custom Spell-Function Block
                        //Get damage
                        sTargets = "AOE";
                        nDamage = GetFourthLevelDamage(oTarget, nCasterLvl, sTargets);

                        //Buff damage by Amplification elvel
                        nDamage = GetAmp(nDamage);

                        //Get the Alchemite resistance reduction
                        sElement = "Nega";
                        int nReduction = GetFocusReduction(oCaster, sElement);

                        //Buff damage bonus on Alchemite
                        nDamage = GetFocusDmg(oCaster, nDamage, sElement);
                    //End Custom Spell-Function Block

                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                    //Get the distance between the explosion and the target to calculate delay
                    fDelay = 0.1;

                    //Adjust damage based on Alchemite and Saving Throw
                    nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);

                    //Store main target and set check
                    if(nTargetCheck == 0)
                    {
                        oMainTarget = oTarget;
                        nTargetCheck = 1;
                    }

                    //Set the damage effect
                    eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_NEGATIVE);
                    if(nDamage > 0)
                    {
                        // Apply effects to the currently selected target.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        //This visual effect is applied to the target object not the location as above.  This visual effect
                        //represents the flame that erupts on the target not on the ground.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
                        //AssignCommand(oTarget, DelayCommand(fDelay, PlaySoundByStrRef(16778125, FALSE)));
                    }
                }
           }
           //Get the next object in the lightning cylinder
           oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE, GetPosition(OBJECT_SELF));
        }
        nCount++;
        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nCount);
    }

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}


