void main()
{
    int nCheck = GetLocalInt(OBJECT_SELF, "ILLUSIONIST_BACKFIRE_DAMAGE");
    if(nCheck > 0)
    {
        effect eStun = EffectStunned();
        effect eDamage = EffectDamage(nCheck);
        effect eVis = EffectVisualEffect(1098);
        effect eLink = EffectLinkEffects(eDamage, eVis);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, OBJECT_SELF, 2.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, OBJECT_SELF);
        DeleteLocalInt(OBJECT_SELF, "ILLUSIONIST_BACKFIRE_DAMAGE");
    }
}
