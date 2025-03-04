//::///////////////////////////////////////////////
//:: Mass Blindness and Deafness / Baffle by Alexander G.

#include "tsw_class_func"
#include "spell_dmg_inc"

void main()
{
    //Declare major variables
    float fDuration = GetExtendSpell(8.0);
    effect eBlind =  EffectBlindness();
    effect eDeaf = EffectDeaf();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    float fSize = GetSpellArea(6.0);

    //Link the blindness and deafness effects
    effect eLink = EffectLinkEffects(eBlind, eDeaf);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eXpl = EffectVisualEffect(890);
    effect eSound = EffectVisualEffect(891);
    string sElement = "Magi";
    int nReduction;
    float fFinalDuration;
    //Play area impact VFX
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eXpl, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSound, GetSpellTargetLocation());
    //Get the first target in the spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        if (GetIsReactionTypeHostile(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_BLINDNESS_AND_DEAFNESS));

            //Reduce duration
            nReduction = GetFocusReduction(OBJECT_SELF, sElement);
            fFinalDuration = GetWillDuration(oTarget, nReduction, fDuration);

            //Apply the linked effects and the VFX impact
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        //Get next object in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetSpellTargetLocation());
    }

    DoClassMechanic("Control", "AOE", 0, oTarget);
}
