void main()
{
    string sVar = "SUMMON_COUNT";
    int nVar = GetLocalInt(OBJECT_SELF, sVar);
    int nCount = 0;
    //effect eSummon = EffectSummonCreature("vilecrawler",VFX_FNF_GAS_EXPLOSION_EVIL);
    effect eVFX = EffectVisualEffect(258);
    location lMob = GetLocation(OBJECT_SELF);

    if(nVar == 1)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMob);
        CreateObject(1, "fire_t3a", lMob);
        CreateObject(1, "fire_t3a", lMob);
        SetLocalInt(OBJECT_SELF, sVar, 0);
    }
    else if(nVar != 1)
    {
        nVar = nVar + 1;
        SetLocalInt(OBJECT_SELF, sVar, nVar);
    }

    ExecuteScript("x2_def_endcombat", OBJECT_SELF);
}
