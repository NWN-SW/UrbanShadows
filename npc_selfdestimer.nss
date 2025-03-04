void main()
{
    int nHP = GetMaxHitPoints();
    effect eDam = EffectDamage(nHP / 3);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);

    ExecuteScript("nw_c2_default3", OBJECT_SELF);
}
