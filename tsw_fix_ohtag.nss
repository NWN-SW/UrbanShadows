void main()
{
    string sTag = GetTag(OBJECT_SELF);
    object oPC = GetLastUsedBy();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if(oWeapon == OBJECT_INVALID)
    {
        oWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    }

    if(oWeapon != OBJECT_INVALID)
    {
        SetTag(oWeapon, "OH_CLEAVE_WEP");
        SendMessageToPC(oPC, "Tag set successfully.");
    }
}
