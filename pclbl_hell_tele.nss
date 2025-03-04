void main()
{
    object oTag = GetObjectByTag("HellGate_1");
    object oPC = GetLastUsedBy();

    AssignCommand(oPC, ActionJumpToObject(oTag));
}
