void RemoveWeaponVFX(object oPC)
{
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    itemproperty iProp = GetFirstItemProperty(oWep);
    int nType = GetItemPropertyType(iProp);
    while(GetIsItemPropertyValid(iProp))
    {
        if(nType == ITEM_PROPERTY_VISUALEFFECT)
        {
            RemoveItemProperty(oWep, iProp);
        }
        iProp = GetNextItemProperty(oWep);
        nType = GetItemPropertyType(iProp);
    }
}
