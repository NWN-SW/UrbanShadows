//::///////////////////////////////////////////////
//Theurgist water domain by Alexander G.
//::///////////////////////////////////////////////

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

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


    //Declare major variables
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    //Limit caster level
    // June 2/04 - Bugfix: Cap the level BEFORE the damage calculation, not after. Doh.
    int nDamage;
    object oCaster = OBJECT_SELF;
    int nDamStrike;
    int nNumAffected = 0;
    int nMetaMagic = GetMetaMagicFeat();
    //Declare lightning effect connected the casters hands
    effect eLightning = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND, FALSE, 1.75);;
    effect eVis  = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eVis2 = EffectVisualEffect(VFX_IMP_PULSE_WATER);
    effect eDamage;
    effect eSlow = EffectMovementSpeedDecrease(50);
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    string sTargets;
    string sElement;
    int nReduction;
    int nFinalDamage;
    int nTargetCheck;
    object oMainTarget;
    location lSpellLocation;
    float fArea = GetSpellArea(RADIUS_SIZE_COLOSSAL);

    //Damage the initial target
    if (GetIsReactionTypeHostile(oFirstTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        //Adjust damage via Reflex Save or Evasion or Improved Evasion

        //Start Custom Spell-Function Block
            //Get damage
            sTargets = "AOE";
            nDamage = GetSeventhLevelDamage(oTarget, nCasterLevel, sTargets);
            nDamage = nDamage / 2;

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            sElement = "Cold";
            nReduction = GetFocusReduction(oCaster, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        //Store main target and set check
        if(nTargetCheck == 0)
        {
            oMainTarget = oTarget;
            nTargetCheck = 1;
        }

        //Set the damage effect for the first target
        eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_COLD);
        //Apply damage to the first target and the VFX impact.
        if(nFinalDamage > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oFirstTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oFirstTarget, 12.0);
        }
    }
    //Apply the lightning stream effect to the first target, connecting it with the caster
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oFirstTarget,0.5);


    //Reinitialize the lightning effect so that it travels from the first target to the next target
    eLightning = EffectBeam(VFX_BEAM_COLD, oFirstTarget, BODY_NODE_CHEST, FALSE, 1.75);


    float fDelay = 0.2;
    int nCnt = 0;


    // *
    // * Secondary Targets
    // *


    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fArea, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) && nCnt < nCasterLevel)
    {
        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
        {
            //Connect the new lightning stream to the older target and the new target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSeventhLevelDamage(oTarget, nCasterLevel, sTargets);
                nDamage = nDamage / 2;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Cold";
                nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Apply the damage and VFX impact to the current target
            eDamage = EffectDamage(nFinalDamage, DAMAGE_TYPE_COLD);
            if(nDamage > 0) //Damage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oFirstTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oFirstTarget, 12.0));
            }
            oHolder = oTarget;

            //change the currect holder of the lightning stream to the current target
            if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
            eLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST, FALSE, 1.75);
            }
            else
            {
                // * April 2003 trying to make sure beams originate correctly
                effect eNewLightning = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST, FALSE, 1.75);
                if(GetIsEffectValid(eNewLightning))
                {
                    eLightning =  eNewLightning;
                }
            }

            fDelay = fDelay + 0.1f;
        }
        //Count the number of targets that have been hit.
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            nCnt++;
        }

        // April 2003: Setting the new origin for the beam
       // oFirstTarget = oTarget;

        //Get the next target in the shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fArea, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
      }

    //Class mechanics
    string sSpellType = "Force";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
 }
