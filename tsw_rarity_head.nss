int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);

    string sRarity = GetLocalString(oItem, "RARITY");

    if(sRarity == "Rare" || sRarity == "Rare+" || sRarity == "Legendary")
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
