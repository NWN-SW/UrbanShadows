//Consequence by Alexander G.

#include "X0_I0_SPELLS"
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
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    float fDelay;
    float fSize = GetSpellArea(10.0);
    float fDuration = GetExtendSpell(18.0);
    effect eSlow = EffectMovementSpeedDecrease(50);
    effect eVis;
    effect eBoom;
    effect eBoom2;
    string sTargets;
    string sElement;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;

    if(GetHasFeat(DOOM_PROPHECY_FIRE, oCaster))
    {
        eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        eBoom = EffectVisualEffect(494);
        eBoom2 = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        sElement = "Fire";
    }
    else if(GetHasFeat(DOOM_PROPHECY_COLD, oCaster))
    {
        eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        eBoom = EffectVisualEffect(VFX_IMP_FROST_L);
        eBoom2 = EffectVisualEffect(VFX_IMP_PULSE_COLD);
        sElement = "Cold";
    }
    else if(GetHasFeat(DOOM_PROPHECY_ELEC, oCaster))
    {
        eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        eBoom = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        eBoom2 = EffectVisualEffect(VFX_IMP_PULSE_WATER);
        sElement = "Elec";
    }

    //Apply the explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom2, lTarget);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                //nDamage = GetFourthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                //nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                //nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Adjust damage based on Alchemite and Saving Throw
            fDuration = GetWillDuration(oTarget, nReduction, fDuration);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            // Apply effects to the currently selected target.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, fDuration));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    DoClassMechanic("Control", "AOE", 0, oMainTarget);
}

