void main()
{
    //Global Variables
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();
    int nCount = 0;
    itemproperty ipCheck = GetFirstItemProperty(oItem);

    while(GetIsItemPropertyValid(ipCheck))
    {
        nCount = nCount + 1;
        ipCheck = GetNextItemProperty(oItem);
    }

    if(nCount >= 6)
    {
        SetLocalString(oItem, "RARITY", "Legendary");
    }
}
