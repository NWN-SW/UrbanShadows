void main()
{
    object oTag = GetObjectByTag("AstoriaGate_1");
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "ObsidianSword");

    if(oItem != OBJECT_INVALID)
    {
        AssignCommand(oPC, ActionJumpToObject(oTag));
    }
    else
    {
        SendMessageToPC(oPC, "You cannot enter this portal without the proper relic.");
    }
}
