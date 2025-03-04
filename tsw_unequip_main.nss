void main()
{
    object oMain = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    object oSecondary = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    ActionUnequipItem(oMain);
    ActionUnequipItem(oSecondary);
}
