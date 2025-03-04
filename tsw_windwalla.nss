//::///////////////////////////////////////////////
//:: Wall of Wind: On Enter by Alexander G.
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
    float fDuration = GetExtendSpell(12.0);
    object oCaster = GetAreaOfEffectCreator();
    effect eSlow = EffectMovementSpeedDecrease(50);
    eSlow = TagEffect(eSlow, "WIND_WALL_SLOW");
    //Declare and assign personal impact visual effect.
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);

    //Capture the first target object in the shape.
    oTarget = GetEnteringObject();

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, GetAreaOfEffectCreator()))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WALL_OF_FIRE));

        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "AOE";
            nDamage = GetFourthLevelDamage(oTarget, nCasterLvl, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Elec";
            int nReduction = GetFocusReduction(oCaster, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
            nDamage = nDamage / 6;
            if(nDamage < 1)
            {
                nDamage = 1;
            }
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        // Apply effects to the currently selected target.
        eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

        //CC Target for duration
        fDuration = GetWillDuration(oTarget, nReduction, fDuration);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, fDuration);

        //Class mechanics
        string sSpellType = "Electric";
        DoClassMechanic(sSpellType, sTargets, nFinalDamage, oTarget, oCaster);
    }
}
