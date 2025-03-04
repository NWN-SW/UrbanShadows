/*
Custom Shadow chaining spell by Alexander G.*/

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

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
    int nDamage;;
    int nDamStrike;
    int nNumAffected = 0;
    int nMetaMagic = GetMetaMagicFeat();
    //Declare lightning effect connected the casters hands
    effect eLightning = EffectBeam(VFX_BEAM_MIND, OBJECT_SELF, BODY_NODE_HAND);;
    effect eVis  = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eDamage;
    object oFirstTarget = GetSpellTargetObject();
    object oHolder;
    object oTarget;
    location lSpellLocation;
    //Enter Metamagic conditions
    //Roll damage for each target
    nDamage = GetFourthLevelDamage(oTarget, nCasterLevel, nMetaMagic, "AOE");

    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
    string sElement = "Magi";
    int nDC = GetSpellSaveDC();
    int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
    nDC = nDC + nBonusDC;
    nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    nDamage = GetWillDamage(oTarget, nDC, nDamage);
    nDamage = nDamage + 8;
    //Damage the initial target
    if (spellsIsTarget(oFirstTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHADOW_CONJURATION_MAGIC_MISSILE));
        //Make an SR Check
        if (!MyResistSpell(OBJECT_SELF, oFirstTarget))
        {
            //Adjust damage via Reflex Save or Evasion or Improved Evasion
            //nDamStrike = GetReflexAdjustedDamage(nDamage, oFirstTarget, nDC, SAVING_THROW_TYPE_ELECTRICITY);
            //Set the damage effect for the first target
            eDamage = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
            //Apply damage to the first target and the VFX impact.
            if(nDamage > 0)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oFirstTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oFirstTarget);
            }
        }
    }
    //Apply the lightning stream effect to the first target, connecting it with the caster
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oFirstTarget,0.5);


    //Reinitialize the lightning effect so that it travels from the first target to the next target
    eLightning = EffectBeam(VFX_BEAM_MIND, oFirstTarget, BODY_NODE_CHEST);


    float fDelay = 0.2;
    int nCnt = 0;


    // *
    // * Secondary Targets
    // *


    //Get the first target in the spell shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) && nCnt < nCasterLevel)
    {
        //Make sure the caster's faction is not hit and the first target is not hit
        if (oTarget != oFirstTarget && spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Connect the new lightning stream to the older target and the new target
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,0.5));

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHADOW_CONJURATION_MAGIC_MISSILE));
            //Do an SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {

                //Roll damage for each target
                nDamage = GetFourthLevelDamage(oTarget, nCasterLevel, nMetaMagic, "AOE");
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
                nDamage = GetFortDamage(oTarget, nDC, nDamage);
                //Adjust damage via Reflex Save or Evasion or Improved Evasion
                //nDamStrike = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY);
                //Apply the damage and VFX impact to the current target
                eDamage = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                if(nDamage > 0) //Damage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                }
            }
            oHolder = oTarget;

            //change the currect holder of the lightning stream to the current target
            if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
            eLightning = EffectBeam(VFX_BEAM_MIND, oHolder, BODY_NODE_CHEST);
            }
            else
            {
                // * April 2003 trying to make sure beams originate correctly
                effect eNewLightning = EffectBeam(VFX_BEAM_MIND, oHolder, BODY_NODE_CHEST);
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
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
      }
 }
