void main()
{
    object oArea = GetObjectByTag("TheEnd_WZ");
    object oWP = GetWaypointByTag("tp_recall");
    object oPC = GetFirstPC();
    object oPCArea = GetArea(oPC);
    location lWP = GetLocation(oWP);
    location lPC = GetLocation(oPC);
    location lLord = GetLocation(OBJECT_SELF);
    effect eWeird = EffectVisualEffect(40);
    effect eShake = EffectVisualEffect(286);
    effect ePortal = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eDeath = EffectDeath(TRUE, FALSE);
    int nWave = GetLocalInt(oArea, "INVASION_WAVE");

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWeird, lLord);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lLord);

    if(nWave < 1)
    {
        nWave = 1;
    }

    nWave = nWave * 25000;

    SetEventScript(oArea, 4000, "area_fort_reset");
    SendMessageToAllDMs("Script set.");

    while(oPC != OBJECT_INVALID)
    {
        if(oPCArea == oArea)
        {
            //GiveGoldToCreature(oPC, nWave);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);
            SendMessageToPC(oPC, "Gaia's Beacon is destroyed by the filth. Your body is torn apart over what seems like days of agony. Afterward, your soul is snatched by Gaia and returned to her realm.");
        }
        oPC = GetNextPC();
        oPCArea = GetArea(oPC);
    }
}
