//::///////////////////////////////////////////////
// Blood Retribution by Alexander G.

#include "nw_i0_spells"
#include "spell_dmg_inc"
#include "x2_inc_spellhook"
#include "tsw_class_func"

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
    location lTarget = GetSpellTargetLocation();
    float fDuration = GetExtendSpell(60.0);
    float fSize = GetSpellArea(6.0);
    effect eVis = EffectVisualEffect(993);
    object oTarget;

    //Bonus effect
    effect eDivine = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDivine, lTarget);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget))
        {
            RemoveEffectsFromSpell(oTarget, GetSpellId());

            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
            eDur = EffectLinkEffects(eDur, eVis);

            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            //Shield effect
            int nMax = GetMaxHitPoints(OBJECT_SELF);
            int nCurrent = GetCurrentHitPoints(OBJECT_SELF);
            int nShield = nMax - nCurrent;
            effect eShield = EffectDamageShield(nShield, d4(1), DAMAGE_TYPE_SLASHING);
            eDur = EffectLinkEffects(eDur, eShield);

            //Apply the armor bonuses and the VFX impact
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
        }

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);
    }

    DoClassMechanic("Buff", "AOE", 0, oTarget);
    PlaySoundByStrRef(16778138, FALSE);
}
