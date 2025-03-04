//::///////////////////////////////////////////////
//OnDeath Maggot Spell Summon by Alexander G.
//We want to summon a buggo when a creature dies after being affected by Infestation of Maggots.

void main()
{
    int nInfested = GetLocalInt(OBJECT_SELF, "INFESTED");
    if (nInfested >= 3)
    {
        location lSpawn = GetLocation(OBJECT_SELF);
        effect eSplat = EffectVisualEffect(VFX_IMP_DESTRUCTION);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSplat, lSpawn);
        CreateObject(1, "druid_magg_sum", lSpawn);
    }
}
