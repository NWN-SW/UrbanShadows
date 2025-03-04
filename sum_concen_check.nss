void main()
{
    object oMaster = GetMaster();
    effect eVis = EffectVisualEffect(VFX_IMP_UNSUMMON);
    location lSum = GetLocation(OBJECT_SELF);
    if (GetIsObjectValid(oMaster) && GetIsPC(oMaster))
    {
        int nAction = GetCurrentAction(oMaster);
        // master doing anything that requires attention and breaks concentration
        if (nAction == ACTION_COUNTERSPELL ||
            nAction == ACTION_CASTSPELL)
        {
            DestroyObject(OBJECT_SELF);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSum);
        }
    }
    ExecuteScript("nw_ch_ac3", OBJECT_SELF);
}
