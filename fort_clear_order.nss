void main()
{
    object oZone = OBJECT_SELF;
    object oMonster = GetEnteringObject();

    if(!GetIsPC(oMonster))
    {
        SetEventScript(oMonster, 5000, "x2_def_heartbeat");
    }
}
