//::///////////////////////////////////////////////
//:: Greater Earthquake by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_get_rndmloc"
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

    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    float fDelay2;
    float nSize =  GetSpellArea(15.0);
    effect eExplode = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eVis = EffectVisualEffect(VFX_COM_HIT_ACID);
    effect eVis2 = EffectVisualEffect(354);
    effect eFloatingRock = EffectVisualEffect(137);
    effect eDam;
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    string sTargets;
    string sElement;
    int nReduction;
    int nTargetCheck;
    int nFinalDamage;
    object oMainTarget;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, OBJECT_SELF);

    //CC effects
    effect eStun = EffectStunned();
    effect eStunVis = EffectVisualEffect(VFX_IMP_STUN);
    effect eSlow = EffectMovementSpeedDecrease(50);
    effect eSlowVis = EffectVisualEffect(VFX_IMP_SLOW);
    float fStunDur = GetExtendSpell(6.0);
    float fSlowDur = GetExtendSpell(12.0);

    //Apply pulses
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(oCaster));
    DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(oCaster)));
    DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(oCaster)));
    DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(oCaster)));

    //Floating debris
    int nCounter = 0;
    location lLoc;
    while(nCounter <= 10)
    {
        lLoc = GetNewRandomLocation(lTarget, nSize);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFloatingRock, lLoc);
        nCounter = nCounter + 1;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EARTHQUAKE));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Acid";
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);

                //Store main target and set check
                if(nTargetCheck == 0)
                {
                    oMainTarget = oTarget;
                    nTargetCheck = 1;
                }
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EARTHQUAKE));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = 1.5;
            fDelay2 = 5.0;

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_BLUDGEONING);
            // * caster can't be affected by the spell
            if( (nDamage > 0) && (oTarget != oCaster))
            {
                //Adjust durations
                float fFinalStunDur = GetReflexDuration(oTarget, nReduction, fStunDur);
                float fFinalSlowDur = GetReflexDuration(oTarget, nReduction, fSlowDur);

                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                //Stun
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fFinalStunDur));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eStunVis, oTarget));
                //Slow
                DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, fFinalSlowDur));
                DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eSlowVis, oTarget));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoClassMechanic("Earth", sTargets, nFinalDamage, oMainTarget);

}





