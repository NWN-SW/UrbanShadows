void main()
{
    int nHealth = GetMaxHitPoints(OBJECT_SELF);
    int nDamage = nHealth / 4;
    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);
}
