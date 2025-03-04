//::///////////////////////////////////////////////
//:: Seal of Nightmares by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void RunImpact(object oTarget, object oCaster, int nDamage, int nSpell);

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
    int nDamage;
    int nFinalDamage;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oCaster = OBJECT_SELF;
    //Custom spell size
    float fSize = GetSpellArea(10.0);
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
    effect eVis2 = EffectVisualEffect(961);
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    eDur = ExtraordinaryEffect(eDur);
    string sTargets;
    string sElement;
    int nTotalDamage;
    int nReduction;
    int nSpell = GetSpellId();
    location lLocation = GetSpellTargetLocation();
    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLocation);

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    // Calculate the duration
    float fDuration = GetExtendSpell(18.0);

    //Apply the acid explosions
    float fDelay2;
    location lVFX;
    int nVFXCounter;
    effect eExplode = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY, FALSE, 1.5, [0.0,0.0,0.6]);
    while(nVFXCounter < 6)
    {
        fDelay2 = fDelay2 + 0.1;
        lVFX = GetNewRandomLocation(lLocation, fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        nVFXCounter = nVFXCounter + 1;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lLocation, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF && !GetHasSpellEffect(nSpell,oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSixthLevelDamage(oTarget, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Nega";
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
            nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);
            int nDOTDamage = nFinalDamage / 2;

            if(nDamage > 0)
            {
                  // Apply effects to the currently selected target.  For this spell we have used
                  //both Divine and Fire damage.
                  effect eFire = EffectDamage(nDOTDamage, DAMAGE_TYPE_NEGATIVE);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget);
                  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
                  DelayCommand(6.0f, RunImpact(oTarget, OBJECT_SELF, nDOTDamage, nSpell));
            }
        }
        else if(oTarget != OBJECT_SELF && GetHasSpellEffect(nSpell, oTarget))
        {
            FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lLocation, OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}

//DoT Function
void RunImpact(object oTarget, object oCaster, int nDamage, int nSpell)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if(GZGetDelayedSpellEffectsExpired(nSpell, oTarget, oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
        effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
        effect eVis2 = EffectVisualEffect(1093);
        eDam = EffectLinkEffects(eVis, eDam);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eVis2, oTarget);
        if(Random(4) == 1)
        {
            AssignCommand(oTarget, DelayCommand(0.0, PlaySoundByStrRef(16778135, FALSE)));
        }
        DelayCommand(6.0f, RunImpact(oTarget, oCaster, nDamage, nSpell));
    }
}


