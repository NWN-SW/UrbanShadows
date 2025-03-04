void main()
{
    object oPC = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE, PERSISTENT_ZONE_ACTIVE);
    int nPC = GetIsPC(oPC);
    int nDamage = GetMaxHitPoints(oPC) / 4;
    effect eTrap = EffectDamage(nDamage, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);
    effect eFire = EffectVisualEffect(60);

    while(oPC != OBJECT_INVALID)
    {
        if(nPC == 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrap, oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oPC);
        }
        oPC = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE, PERSISTENT_ZONE_ACTIVE);
    }
}
