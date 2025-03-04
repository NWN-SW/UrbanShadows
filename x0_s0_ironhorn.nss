//::///////////////////////////////////////////////
//:: Balagarn's Iron Horn by Alexander G.
//:: Created On: July 22 2002
//:://////////////////////////////////////////////

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
    float fDuration = GetExtendSpell(6.0);
    effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ELECTRICITY);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    effect eParaVis = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    if (nCasterLvl > 20)
    {
        nCasterLvl = 20;
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, RoundsToSeconds(d3()));
    //Apply epicenter explosion on caster
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(OBJECT_SELF));

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Get the Alchemite resistance reduction
    string sElement = "Soni";
    int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        // * spell should not affect the caster
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && (oTarget != oCaster))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 436));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Get Adjusted duration
            float fFinalDuration = GetFortDuration(oTarget, nReduction, fDuration);
            if(GetIsPC(oTarget))
            {
                fFinalDuration = fFinalDuration - 2.0;
            }

            effect ePara = EffectParalyze();
            // Apply effects to the currently selected target.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget, fFinalDuration));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParaVis, oTarget, fFinalDuration));
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Control";
    DoClassMechanic(sSpellType, "AOE", 0, oTarget);
}







