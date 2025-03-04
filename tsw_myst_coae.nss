//::///////////////////////////////////////////////
//:: Cosmic Aegisby Alexander G.
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


    object oTarget = GetSpellTargetObject();
    //Declare major variables
    float fDuration = TurnsToSeconds(10);
    fDuration = GetExtendSpell(fDuration);
    int nLimit = GetHighestAbilityModifier(OBJECT_SELF);
    nLimit = nLimit * 12;
    int nAmount = 40;
    float fSize = GetSpellArea(6.0);

    //Bonus effect
    effect eDivine = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDivine, GetLocation(OBJECT_SELF));

    effect eMag = EffectDamageResistance(DAMAGE_TYPE_MAGICAL, nAmount, nLimit);
    effect eDiv = EffectDamageResistance(DAMAGE_TYPE_DIVINE, nAmount, nLimit);
    //effect ePos = EffectDamageResistance(DAMAGE_TYPE_POSITIVE, nAmount, nLimit);
    effect eNeg = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, nAmount, nLimit);
    effect eDur = EffectVisualEffect(1066);
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH_WARD);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_BUFFER, FALSE));

    //Link Effects
    effect eLink = EffectLinkEffects(eMag, eDiv);
    //eLink = EffectLinkEffects(eLink, ePos);
    eLink = EffectLinkEffects(eLink, eNeg);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oTarget), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget))
        {
            //Cancel if alternate version still exists
            if(GetHasSpellEffect(924, oTarget))
            {
                SendMessageToPC(OBJECT_SELF, "Target already has Cosmic Shield.");
            }
            else
            {

                RemoveEffectsFromSpell(oTarget, GetSpellId());

                //Apply the VFX impact and effects
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            }
        }

       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oTarget), TRUE, OBJECT_TYPE_CREATURE);
    }

    DoClassMechanic("Buff", "Single", 0, oTarget);
    DoClassMechanic("Buff", "Single", 0, oTarget);
}

