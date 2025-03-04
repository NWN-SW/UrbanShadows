//::///////////////////////////////////////////////
//Werewolf Howl by Alexander G.
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_shifter"

void main()
{
    //--------------------------------------------------------------------------
    // Enforce artifical use limit on that ability
    //--------------------------------------------------------------------------
    if (ShifterDecrementGWildShapeSpellUsesLeft() <1 )
    {
        FloatingTextStrRefOnCreature(83576, OBJECT_SELF);
        return;
    }

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eHowl;
    effect eImpact = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eBump = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    int nStrength = GetAbilityModifier(0);
    int nLevel = GetLevelByClass(35);
    int nDC = 20 + nLevel + nStrength;
    int nBase = nLevel * 2;
    int nDamage;
    float fDelay;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBump, OBJECT_SELF);

    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget))
        {
            fDelay = GetDistanceToObject(oTarget)/20;
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_HOWL_SONIC));

            //Base damage
            nDamage = nBase * nStrength;

            //Adjust damage based on save
            if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_SONIC, OBJECT_SELF, fDelay))
            {
                nDamage = nDamage / 2;
            }

            //Set damage effect
            eHowl = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
            //Apply the VFX impact and effects
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


