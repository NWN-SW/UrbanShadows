void main()
{
    object oPC = GetEnteringObject();
    int nTimerCount = GetLocalInt(OBJECT_SELF, "TIMER_COUNT");

    if(GetIsPC(oPC) && nTimerCount == 0)
    {
        SetEventScript(OBJECT_SELF, 7000, "npc_spawn_waves");
        SetEventScript(OBJECT_SELF, 7001, "");
    }
}
