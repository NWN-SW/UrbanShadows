//::///////////////////////////////////////////////
//Secrets of the Veil by Alexander G.
//:://////////////////////////////////////////////
#include "nw_i0_spells"
#include "tsw_class_func"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    object oTarget = GetSpellTargetObject();
    float fDuration = TurnsToSeconds(10);
    fDuration = GetExtendSpell(fDuration);
    int nAmount = GetHighestAbilityModifier(OBJECT_SELF);
    nAmount = nAmount * 2;
    float fSize = GetSpellArea(10.0);

    //Bonus effect
    effect eDivine = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDivine, GetLocation(OBJECT_SELF));

    effect eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nAmount);
    effect eDur = EffectVisualEffect(VFX_DUR_PROTECTION_EVIL_MINOR);
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Link Effects
    effect eLink = EffectLinkEffects(eSaves, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        int nSummon = GetLocalInt(oTarget, "CLASS_MECH_SUMMON");
        if (!GetIsReactionTypeHostile(oTarget) && nSummon == 1)
        {
            RemoveEffectsFromSpell(oTarget, GetSpellId());

            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);
    }

    //DoClassMechanic("Occult", "Single", 0, OBJECT_SELF);
    DoClassMechanic("Buff", "Single", 0, OBJECT_SELF);
}
