void main()
{
    object oWP = GetWaypointByTag("TRAINING_SPAWN_TWO");
    location lLoc = GetLocation(oWP);
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc);
    CreateObject(OBJECT_TYPE_CREATURE, "t3dummy", lLoc);
}
