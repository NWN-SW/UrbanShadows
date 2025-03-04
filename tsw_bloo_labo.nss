//::///////////////////////////////////////////////
//:: Lacerating Bolt by Alexander G.
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
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eVis2 = EffectVisualEffect(258);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Track the first valid target for class mechanics
    object oMainTarget;
    int nTargetCheck = 0;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetSpellTargetObject();

    if (oTarget != OBJECT_INVALID)
    {
       //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        //Get the distance between the explosion and the target to calculate delay
        fDelay = 0.15;

        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "Single";
            nDamage = GetEighthLevelDamage(oTarget, nCasterLvl, sTargets);

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

        //Set the damage effect
        eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_PIERCING);
        if(nDamage > 0)
        {
            // Apply effects to the currently selected target.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));

            //Class mechanics
            string sSpellType = "Occult";
            DoClassMechanic(sSpellType, "Single", nFinalDamage, oTarget);
        }
    }
}
