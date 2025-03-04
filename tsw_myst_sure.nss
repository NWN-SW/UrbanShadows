//::///////////////////////////////////////////////
// Sureity by Alexander G.

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
    float fDuration = TurnsToSeconds(10);
    fDuration = GetExtendSpell(fDuration);
    int nAmount =  4;
    float fSize = GetSpellArea(6.0);
    effect eVis = EffectVisualEffect(1037);
    effect eSound = EffectVisualEffect(1042);
    effect eBonus;

    //Bonus effect
    effect eDivine = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDivine, GetLocation(OBJECT_SELF));

    eBonus = EffectAttackIncrease(nAmount,ATTACK_BONUS_MISC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eDur = EffectLinkEffects(eDur, eBonus);

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget))
        {
            //Cancel if alternate version still exists
            if(GetHasSpellEffect(923, oTarget))
            {
                SendMessageToPC(OBJECT_SELF, "Target already has Guidance.");
            }
            else
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

                RemoveEffectsFromSpell(oTarget, GetSpellId());

                //Apply the armor bonuses and the VFX impact
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eSound, oTarget);
            }
        }

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE);
    }

    DoClassMechanic("Buff", "AOE", 0, oTarget);
    DoClassMechanic("Buff", "AOE", 0, oTarget);
}
