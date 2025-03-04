//::///////////////////////////////////////////////
//:: Wall of Ice OnEnter
//:://////////////////////////////////////////////
//By Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{

    //Declare major variables
    int nDamage;
    int nCasterLvl = GetCasterLevel(GetAreaOfEffectCreator());
    effect eDam;
    object oTarget;
    object oCaster = GetAreaOfEffectCreator();
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
    effect eSlow = EffectMovementSpeedDecrease(75);

    //Capture the first target object in the shape.
    oTarget = GetEnteringObject();

    if (GetIsReactionTypeHostile(oTarget, oCaster))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "AOE";
            nDamage = GetSecondLevelDamage(oTarget, nCasterLvl, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Cold";
            int nReduction = GetFocusReduction(oCaster, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            nDamage = nDamage / 3;
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        if(nFinalDamage > 0)
        {
            // Apply effects to the currently selected target.
            eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_COLD);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, 6.0);
        }
    }
}
