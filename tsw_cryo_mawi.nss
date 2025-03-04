//::///////////////////////////////////////////////
//:: March of Wintertide by Alexander G.
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
    float fSize = GetSpellArea(50.0);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eSnow = EffectVisualEffect(1096);
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    effect eImpact2 = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, 10);
    effect eSlow = EffectMovementSpeedDecrease(50);
    eDur = ExtraordinaryEffect(eDur);
    string sTargets;
    string sElement;
    int nTotalDamage;
    int nReduction;
    int nSpell = GetSpellId();
    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetLocation(OBJECT_SELF));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact2, GetLocation(OBJECT_SELF));

    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    // Calculate the duration
    float fDuration = GetExtendSpell(30.0);

    //Change weather of the area
    SetWeather(GetArea(OBJECT_SELF), WEATHER_SNOW);

    //Set weather back to what it was
    DelayCommand(fDuration, SetWeather(GetArea(OBJECT_SELF), WEATHER_USE_AREA_SETTINGS));

    //Apply the acid explosions
    float fDelay2;
    location lVFX;
    int nVFXCounter;
    effect eExplode = EffectVisualEffect(VFX_IMP_FROST_S, FALSE, 1.5, [0.0,0.0,0.6]);
    while(nVFXCounter < 10)
    {
        fDelay2 = fDelay2 + 0.1;
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        lVFX = GetNewRandomLocation(GetLocation(OBJECT_SELF), fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        nVFXCounter = nVFXCounter + 1;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF && !GetHasSpellEffect(nSpell,oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell, FALSE));

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetSixthLevelDamage(oTarget, nCasterLevel, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Cold";
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
            int nDOTDamage = nFinalDamage / 4;

            //Fortitude Duration
            float fFortDuration = GetFortDuration(oTarget, nReduction, fDuration);

            // Apply effects to the currently selected target.  For this spell we have used
            //both Divine and Fire damage.
            effect eFire = EffectDamage(nDOTDamage, DAMAGE_TYPE_COLD);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, fFortDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnow, oTarget, fFortDuration);
            DelayCommand(6.0f, RunImpact(oTarget, OBJECT_SELF, nDOTDamage, nSpell));
        }
        else if(oTarget != OBJECT_SELF && GetHasSpellEffect(nSpell, oTarget))
        {
            FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        }

        //Buff Allies
        if(!GetIsReactionTypeHostile(oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSaves, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnow, oTarget, fDuration);
        }

        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Force", sTargets, nFinalDamage, oMainTarget);

    //Sound Effects
    PlaySoundByStrRef(16778116, FALSE);
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
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
        effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
        eDam = EffectLinkEffects(eVis, eDam);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDam, oTarget);
        DelayCommand(6.0f,RunImpact(oTarget, oCaster, nDamage, nSpell));
    }
}


