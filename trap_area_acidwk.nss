void main()
{
    object oPC = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE, PERSISTENT_ZONE_ACTIVE);
    int nPC = GetIsPC(oPC);
    int nDamage = Random(24) + 1;
    effect eTrap = EffectDamage(nDamage, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
    effect eAcid = EffectVisualEffect(44);

    while(oPC != OBJECT_INVALID)
    {
        if(nPC == 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eTrap, oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oPC);
        }
        oPC = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE, PERSISTENT_ZONE_ACTIVE);
    }
}
