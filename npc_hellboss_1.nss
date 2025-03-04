void main()
{
    int nCount = Random(4);
    //effect eSummon = EffectSummonCreature("vilecrawler",VFX_FNF_GAS_EXPLOSION_EVIL);
    effect eVFX = EffectVisualEffect(258);
    object oWP1 = GetObjectByTag("TormentSpawn1");
    object oWP2 = GetObjectByTag("TormentSpawn2");
    object oWP3 = GetObjectByTag("TormentSpawn3");
    object oWP4 = GetObjectByTag("TormentSpawn4");
    location lWP1 = GetLocation(oWP1);
    location lWP2 = GetLocation(oWP2);
    location lWP3 = GetLocation(oWP3);
    location lWP4 = GetLocation(oWP4);

    if(GetIsInCombat(OBJECT_SELF))
    {
        switch(nCount)
        {
            case 0:
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lWP1);
            CreateObject(1, "minion1", lWP1);
            break;
            case 1:
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lWP2);
            CreateObject(1, "minion2", lWP2);
            break;
            case 2:
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lWP3);
            CreateObject(1, "minion3", lWP3);
            break;
            case 3:
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lWP4);
            CreateObject(1, "minion1", lWP4);
            break;
        }
    }
}
