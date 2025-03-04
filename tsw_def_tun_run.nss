void main()
{
    SetLocalInt(GetArea(OBJECT_SELF), "WAVE_DEFENSE_TOGGLE", 1);

    //Do VFX
    object oWP1 = GetWaypointByTag("TUN_DEF_P1");
    object oWP2 = GetWaypointByTag("TUN_DEF_P2");
    location lLoc1 = GetLocation(oWP1);
    location lLoc2 = GetLocation(oWP2);
    effect eVis = EffectVisualEffect(241);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lLoc1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lLoc2);

    //Set Respawn safe
    SetLocalInt(GetArea(OBJECT_SELF), "PENALTY_SAFE_AREA", 1);


    DestroyObject(OBJECT_SELF);
}
