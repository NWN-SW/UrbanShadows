#include "tsw_class_func"
#include "spell_dmg_inc"

void main()
{
    //Major variables
    int nEnemies;
    effect eAC;
    effect eDamage;

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget))
        {
            nEnemies = nEnemies + 1;
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }

    //Remove all existing aura effects
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectTag(eEffect) == "LIONHEART_AURA_BALANCE" || GetEffectTag(eEffect) == "LIONHEART_AURA_RUIN")
        {
            RemoveEffect(OBJECT_SELF, eEffect);
        }
        eEffect = GetNextEffect(OBJECT_SELF);
    }

    if(nEnemies == 0)
    {
        return;
    }

    //Apply new effects based on Path
    eAC = EffectACIncrease(nEnemies);
    eDamage = EffectDamageIncrease(GetPureDamage(nEnemies), DAMAGE_TYPE_SONIC);

    if(GetHasFeat(MAAR_PATH_OF_BALANCE))
    {
        //Make effect supernatural
        eAC = SupernaturalEffect(eAC);

        //Tag effect
        eAC = TagEffect(eAC, "LIONHEART_AURA_BALANCE");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, 60.0);
    }

    if(GetHasFeat(MAAR_PATH_OF_RUIN))
    {
        //Make effect supernatural
        eDamage = SupernaturalEffect(eDamage);

        //Tag effect
        eDamage = TagEffect(eDamage, "LIONHEART_AURA_RUIN");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, OBJECT_SELF, 60.0);
    }
}
