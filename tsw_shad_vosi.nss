//::///////////////////////////////////////////////
// Void Sight by Alexander G.

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
    float fDuration = GetExtendSpell(300.0);
    float fSize = GetSpellArea(10.0);
    effect eVis = EffectVisualEffect(VFX_DUR_ULTRAVISION);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eVision = EffectUltravision();
    effect eSee = EffectSeeInvisible();
    effect eLink = EffectLinkEffects(eVision, eSee);

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            RemoveEffectsFromSpell(oTarget, GetSpellId());

            //Remove blindness from target
            effect eEffect = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eEffect))
            {
                if(GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS)
                {
                    RemoveEffect(oTarget, eEffect);
                }
                eEffect = GetNextEffect(oTarget);
            }

            //Apply the armor bonuses and the VFX impact
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, fDuration);
        }

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);
    }

    DoMartialMechanic("Guile", "AOE", 0, oTarget);
    DoClassMechanic("Buff", "AOE", 0, oTarget);
}
