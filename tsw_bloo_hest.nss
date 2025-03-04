//Lascerating Bolt Swarm by Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    object oTarget = OBJECT_INVALID;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
//    int nDamage = 0;
    int nMetaMagic;
    int nCnt = 1;
    effect eMissile = EffectVisualEffect(827);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    float fSize = GetSpellArea(RADIUS_SIZE_COLOSSAL);
    location lTarget = GetSpellTargetLocation(); // missile spread centered around caster
    int nMissiles = nCasterLvl;
    string sTargets;
    int nFinalDamage;
    int nTargetCheck;
    object oMainTarget;
    string sElement;
    object oCaster = OBJECT_SELF;
    int nReduction;
    int nDamage;

    //Element
    sElement = "Nega";

    if (nMissiles > 15)
    {
        nMissiles = 15;
    }

        /* New Algorithm
            1. Count # of targets
            2. Determine number of missiles
            3. First target gets a missile and all Excess missiles
            4. Rest of targets (max nMissiles) get one missile
       */
    int nEnemies = 0;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) )
    {
        // * caster cannot be harmed by this spell
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF))
        {
            // GZ: You can only fire missiles on visible targets
            // If the firing object is a placeable (such as a projectile trap),
            // we skip the line of sight check as placeables can't "see" things.
            if ( ( GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE ) ||
                   GetObjectSeen(oTarget,OBJECT_SELF))
            {
                nEnemies++;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
     }

     if (nEnemies == 0) return; // * Exit if no enemies to hit
     int nExtraMissiles = nMissiles / nEnemies;

     // April 2003
     // * if more enemies than missiles, need to make sure that at least
     // * one missile will hit each of the enemies
     if (nExtraMissiles <= 0)
     {
        nExtraMissiles = 1;
     }

     // by default the Remainder will be 0 (if more than enough enemies for all the missiles)
     int nRemainder = 0;

     if (nExtraMissiles >0)
        nRemainder = nMissiles % nEnemies;

     if (nEnemies > nMissiles)
        nEnemies = nMissiles;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) && nCnt <= nEnemies)
    {
        // * caster cannot be harmed by this spell
        if(GetIsReactionTypeHostile(oTarget))
        {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

                // * recalculate appropriate distances
                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                // Firebrand.
                // It means that once the target has taken damage this round from the
                // spell it won't take subsequent damage
                int nONEHIT = TRUE;
                if (nONEHIT == TRUE)
                {
                    nExtraMissiles = 1;
                    nRemainder = 0;
                }

                int i = 0;
                //--------------------------------------------------------------
                // GZ: Moved SR check out of loop to have 1 check per target
                //     not one check per missile, which would rip spell mantels
                //     apart
                //--------------------------------------------------------------
                if (oTarget != OBJECT_SELF)
                {
                    for (i=1; i <= nExtraMissiles + nRemainder; i++)
                    {
                        //Start Custom Spell-Function Block
                            //Get damage
                            sTargets = "AOE";
                            nDamage = GetEighthLevelDamage(oTarget, nCasterLvl, sTargets);

                            //Buff damage by Amplification elvel
                            nDamage = GetAmp(nDamage);

                            //Get the Alchemite resistance reduction
                            sElement = "Nega";
                            nReduction = GetFocusReduction(oCaster, sElement);

                            //Buff damage bonus on Alchemite
                            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
                        //End Custom Spell-Function Block

                        //Adjust damage based on Alchemite and Saving Throw
                        nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

                        fTime = fDelay;
                        fDelay2 += 0.1;
                        fTime += fDelay2;

                        //Set damage effect
                        effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_PIERCING);
                        //Apply the MIRV and damage effect
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    }
                } // for
                else
                {  // * apply a dummy visual effect
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                }
                nCnt++;// * increment count of missiles fired
                nRemainder = 0;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);

}
