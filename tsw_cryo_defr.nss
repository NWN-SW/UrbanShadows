//Deep Freeze by Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nDamage;
    int nFinalDamage;
    int nVFXCounter = 0;
    float fDelay;
    float fDelay2;
    float fSize = GetSpellArea(6.0);
    effect eExplode = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    effect eHold = EffectVisualEffect(1094);
    effect ePara = EffectParalyze();
    effect eLink = EffectLinkEffects(eHold, ePara);
    effect eDam;
    string sTargets;
    string sElement;
    int nReduction;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    location lVFX;

    //Get Duration
    float fDuration = GetExtendSpell(12.0);

    //Apply the acid explosions
    while(nVFXCounter < 11)
    {
        fDelay2 = fDelay2 + 0.1;
        lVFX = GetNewRandomLocation(lTarget, fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        nVFXCounter = nVFXCounter + 1;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget))
        {
            //Get damage
            sTargets = "AOE";

            //Get the Alchemite resistance reduction
            sElement = "Cold";
            nReduction = GetFocusReduction(oCaster, sElement);

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Adjust duration
            float fFinalDuration = GetFortDuration(oTarget, nReduction, fDuration);
            //SendMessageToPC(OBJECT_SELF, "Duration is: " + FloatToString(fDuration));

            // Apply effects to the currently selected target.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fFinalDuration));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    DoClassMechanic("Cold", sTargets, 0, oTarget);
    DoClassMechanic("Control", sTargets, 0, oTarget);
}

