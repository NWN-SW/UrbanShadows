void main()
{
    int nHP = GetMaxHitPoints(OBJECT_SELF);
    int nTick = nHP / 48;
    int nCurrent = GetLocalInt(OBJECT_SELF, "LIFE_TIMER");
    SetLocalInt(OBJECT_SELF, "MAX_HITPOINTS", nHP);

    if(nCurrent >= nHP)
    {
        DestroyObject(OBJECT_SELF);
    }
    else
    {
        nCurrent = nCurrent + nTick;
        SetLocalInt(OBJECT_SELF, "LIFE_TIMER", nCurrent);
    }
}
