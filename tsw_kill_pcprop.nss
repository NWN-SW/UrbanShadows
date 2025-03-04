void DestroyPCProperties(object oPC)
{
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    object oItem = GetFirstItemInInventory(oPC);
    string sResRef = GetResRef(oItem);
    while(oItem != OBJECT_INVALID)
    {
        if(sResRef == "x3_it_pchide" && oSkin != OBJECT_INVALID && oItem != oSkin)
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
        sResRef = GetName(oItem);
    }
}
