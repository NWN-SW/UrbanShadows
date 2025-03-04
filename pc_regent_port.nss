void main()
{
    object oPC = GetPCSpeaker();
    object oMoved = GetFirstPC();
    object oArea = GetArea(oMoved);
    object oBossArea = GetObjectByTag("TomboftheUsurper");
    object oWP = GetObjectByTag("regent_fight");

    while(oMoved != OBJECT_INVALID)
    {
        if(oArea == oBossArea)
        {
            AssignCommand(oMoved, ActionJumpToObject(oWP));
        }
        oMoved = GetNextPC();
        oArea = GetArea(oMoved);
    }
    AssignCommand(oPC, ActionJumpToObject(oWP));
}
