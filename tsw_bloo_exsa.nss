//::///////////////////////////////////////////////
//:: Exsanguinate by Alexander G.
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
    int nDamage;
    int nFinalDamage;
    float fDelay;
    effect eVis = EffectVisualEffect(1116);
    effect eBlood = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    effect eImpact = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eDam;
    float fSize = GetSpellArea(20.0);
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Link Effects
    effect eLink = EffectLinkEffects(eBlood, eImpact);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget))
        {
           //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the explosion and the target to calculate delay

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Start Custom Spell-Function Block
                //Get damage
                string sTargets = "AOE";
                nDamage = GetNinthLevelDamage(oTarget, nCasterLvl, sTargets);
                nDamage = nDamage - 50;
                nDamage = nDamage / 4;

                //Buff damage by Amplification elvel
                nDamage = GetAmp(nDamage);

                //Get the Alchemite resistance reduction
                string sElement = "Nega";
                int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            //End Custom Spell-Function Block

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);

            //Set the damage and heal effects
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_SLASHING);

            if(nFinalDamage > 0)
            {
                // Apply blood mist
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 2.25);

                //Do the chunky
                DelayCommand(1.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
                DelayCommand(1.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                DelayCommand(1.50, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
                DelayCommand(1.50, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                DelayCommand(1.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
                DelayCommand(1.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget));
                DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

            }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    effect eHeal = EffectHeal(50);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF);

    //Class mechanics
    string sSpellType = "Occult";
    DoClassMechanic(sSpellType, "AOE", nFinalDamage, oMainTarget);
}
