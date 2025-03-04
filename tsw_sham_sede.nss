//Seal of Destruction by Alexander G.

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
    int nDamage;
    int nFinalDamage;
    float fDelay;
    float fSize = GetSpellArea(10.0);
    float fDuration = GetExtendSpell(30.0);
    effect eDur = EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_BLACK);
    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eVis = EffectVisualEffect(VFX_IMP_NIGHTMARE_HEAD_HIT);
    effect eDam;
    string sTargets;
    string sElement = "Nega";
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

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
                nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);
                nDamage = nDamage / 6;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                sElement = "Nega";
                int nReduction = GetFocusReduction(oCaster, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            //End Custom Spell-Function Block

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_NEGATIVE);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration));

                //Apply Explosion Variables
                SetLocalInt(oTarget, "SEAL_DESTRUCTION", 1);
                SetLocalInt(oTarget, "SEAL_DEST_DAMAGE", nFinalDamage);

                //Clear variables after duration
                DelayCommand(fDuration, DeleteLocalInt(oTarget, "SEAL_DESTRUCTION"));
                DelayCommand(fDuration, DeleteLocalInt(oTarget, "SEAL_DEST_DAMAGE"));
            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oMainTarget);
}

