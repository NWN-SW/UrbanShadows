void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetObjectByTag("Wagon_North_DL");
    AssignCommand(oPC, ActionJumpToObject(oWP));
}
