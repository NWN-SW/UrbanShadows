void main()
{
    int nTimer = GetLocalInt(OBJECT_SELF, "TIMER");
    int nTimerCount = GetLocalInt(OBJECT_SELF, "TIMER_COUNT");

    if(nTimerCount < nTimer)
    {
        nTimerCount = nTimerCount + 1;
        SetLocalInt(OBJECT_SELF, "TIMER_COUNT", nTimerCount);
    }
    else if(nTimerCount == nTimer)
    {
        SetLocalInt(OBJECT_SELF, "TIMER_COUNT", 0);
        SetEventScript(OBJECT_SELF, 7000, "");
        SetEventScript(OBJECT_SELF, 7001, "npc_spawn_enter");
    }
}
