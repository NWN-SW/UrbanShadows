void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

    itemproperty ipCustom = ItemPropertyCustom(ITEM_PROPERTY_QUALITY, 6, 1000);
    AddItemProperty(DURATION_TYPE_PERMANENT, ipCustom, oItem);
}
