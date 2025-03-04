int StartingConditional()
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, GetPCSpeaker());
    if(oItem == OBJECT_INVALID)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
