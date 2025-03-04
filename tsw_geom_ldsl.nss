//::///////////////////////////////////////////////
//:: Landslide by Alexander G.
//::///////////////////////////////////////////////

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
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fDelay2;
    float fDuration = 8.0;
    float fSize = GetSpellArea(10.0);
    effect eExplode = EffectVisualEffect(354);
    effect eVis = EffectVisualEffect(135);
    effect eShake = EffectVisualEffect(356);
    effect eStunned = EffectVisualEffect(VFX_IMP_STUN);
    effect eStun = EffectStunned();
    effect eDam;
    string sTargets;
    string sElement;
    int nReduction;
    object oMainTarget;
    int nTargetCheck;
    int nVFXCounter = 0;
    location lVFX;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();

    //Screen bump
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lTarget);

    //Apply the Earth explosions
    while(nVFXCounter < 11)
    {
        fDelay2 = fDelay2 + 0.2;
        lVFX = GetNewRandomLocation(lTarget, fSize);
        DelayCommand(fDelay2, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lVFX));
        nVFXCounter = nVFXCounter + 1;
    }
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) == TRUE)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Start Custom Spell-Function Block
                //Get damage
                sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);
                nDamage = nDamage / 2;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Soni";
                nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

                //Track the first valid target for class mechanics
                oMainTarget;
                nTargetCheck = 0;
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_BLUDGEONING);

            //Set duration
            float fFinalDuration = GetReflexDuration(oTarget, nReduction, fDuration);
            if(nDamage > 0)
            {

                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eStunned, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, fFinalDuration));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
    //Class mechanics
    DoClassMechanic("Earth", sTargets, nFinalDamage, oMainTarget);
    DoClassMechanic("Control", sTargets, nFinalDamage, oMainTarget);
}



