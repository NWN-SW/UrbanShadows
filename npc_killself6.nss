void main()
{
    int nHealth = GetMaxHitPoints(OBJECT_SELF);
    int nDamage = nHealth / 6;
    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);
}
