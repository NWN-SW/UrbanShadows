//Annihilating Bolt by Alexander G.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"
#include "tsw_get_rndmloc"

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
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fSize = GetSpellArea(10.0);
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eDam;
    string sTargets;
    string sElement = "Holy";
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Apply the bonus explosions
    float fDelay2 = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
    location lVFX;
    int nVFXCounter;
    effect eBoom = EffectVisualEffect(VFX_COM_HIT_DIVINE, FALSE, 1.5, [0.0,0.0,0.6]);
    while(nVFXCounter < 5)
    {
        fDelay2 = fDelay2 + 0.1;
        lVFX = GetNewRandomLocation(GetLocation(oTarget), fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lVFX));
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lVFX));
        nVFXCounter = nVFXCounter + 1;
    }

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget))
        {
            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetWillDamage(oTarget, nReduction, nDamage);
            nFinalDamage = nFinalDamage * 2;

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_DIVINE);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Force";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}

