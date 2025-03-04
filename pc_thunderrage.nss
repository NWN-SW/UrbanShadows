//::///////////////////////////////////////////////
//Thundering Rage by Alexander G.
//:://////////////////////////////////////////////
void main()
{
    //Declare major variables
    int nCasterLevel = GetLevelByClass(0, OBJECT_SELF);
    nCasterLevel = nCasterLevel / 2;
    int nDamage = d4(nCasterLevel);
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SONIC);
    effect eLink = EffectLinkEffects(eVis, eVis2);

    //Get first target in spell area
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget, OBJECT_SELF))
        {
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }
}
