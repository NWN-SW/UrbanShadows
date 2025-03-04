void main()
{
    object oZone = OBJECT_SELF;
    object oMonster = GetEnteringObject();

    if(!GetIsPC(oMonster) && !GetIsInCombat(oMonster))
    {
        SetEventScript(oMonster, 5000, "npc_frt_move2");
    }
}
