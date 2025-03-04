///::///////////////////////////////////////////////
//Theurgist Night domain power by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook


    //Declare major variables
    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);
    effect eLink = EffectLinkEffects(eDur, eDex);
    eLink = EffectLinkEffects(eLink, eVis);

    float fDuration = GetExtendSpell(30.0);
    float fSize = GetSpellArea(RADIUS_SIZE_HUGE);

    //Apply the VFX impact and effects
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPROVED_INVISIBILITY, FALSE));
    while (GetIsObjectValid(oTarget))
    {
        if(oTarget == OBJECT_SELF)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, fDuration);
        }
        else if(!GetIsReactionTypeHostile(oTarget) && oTarget != OBJECT_SELF)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, fDuration);
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, "AOE", 0, oTarget);
}


