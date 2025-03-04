void main()
{
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if(!GetIsInCombat(OBJECT_SELF))
    {
        ActionUnequipItem(oWeap);
    }

    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
