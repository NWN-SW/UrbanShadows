void main()
{
    object oPC = GetLastUsedBy();

    if(oPC == OBJECT_INVALID)
    {
        oPC = GetPCSpeaker();
    }
    AssignCommand(oPC, ActionStartConversation(oPC, "x0_skill_ctrap", TRUE, FALSE));
}
