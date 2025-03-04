void main()
{
    //When a minion dies, we want to decrement a variable on the master.
    //When all minions are dead, the master is no longer invulnerable.
    string sMasterTag = GetLocalString(OBJECT_SELF, "FILTH_MASTER_TAG");
    object oMaster = GetNearestObjectByTag(sMasterTag);
    int nMinionsLeft = GetLocalInt(oMaster, "FILTH_MINION_COUNT");
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

    nMinionsLeft = nMinionsLeft - 1;

    if(nMinionsLeft <= 0)
    {
        SetPlotFlag(oMaster, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMaster);
    }
    else
    {
        SetLocalInt(oMaster, "FILTH_MINION_COUNT", nMinionsLeft);
    }
}
