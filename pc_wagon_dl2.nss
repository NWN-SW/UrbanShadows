void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetObjectByTag("Wagon_North_FL");
    AssignCommand(oPC, ActionJumpToObject(oWP));
}
