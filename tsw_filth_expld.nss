void main()
{
    int iDamageDealt = GetLocalInt(OBJECT_SELF,"CREATURE_DEF_TIER");

    location lMobDying = GetLocation(OBJECT_SELF);
    object oPC = GetFirstObjectInShape(SHAPE_SPHERE,3.33f ,lMobDying,TRUE);
    effect eDamageDealt = EffectDamage(iDamageDealt*10,DAMAGE_TYPE_NEGATIVE);
    effect eDamageDealtVFX = EffectVisualEffect(83,FALSE,1.33f);
    effect eGutsVFX = EffectVisualEffect(121);
    ApplyEffectToObject (DURATION_TYPE_INSTANT,eGutsVFX,OBJECT_SELF);


    while (GetIsObjectValid(oPC))
    {
       ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamageDealt,oPC);
       ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamageDealtVFX,oPC);
       oPC = GetNextObjectInShape(SHAPE_SPHERE,3.33f ,lMobDying,TRUE);
    }
}
