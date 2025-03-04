void main()
{
    int nMax = 4800;
    int nCounter = GetLocalInt(OBJECT_SELF, "SHOP_TIMER");
    object oShop = GetObjectByTag("ArandhelsShop");
    object oFShop = GetObjectByTag("ArandhelsShopF");
    location lLoc = GetLocation(oShop);
    location lFLoc = GetLocation(oFShop);
    string sRarity;
    int nTracker = GetLocalInt(OBJECT_SELF, "SHOP_TIMER_2");

    if(nCounter >= nMax)
    {
        //Clean regular Alchemite
        object oItem = GetFirstItemInInventory(oShop);
        while(oItem != OBJECT_INVALID)
        {
            sRarity = GetLocalString(oItem, "RARITY");

            if(sRarity == "Common" || sRarity == "Uncommon")
            {
                DestroyObject(oItem);
            }
            oItem = GetNextItemInInventory(oShop);
        }

        //Clean faction Alchemite
        oItem = GetFirstItemInInventory(oFShop);
        while(oItem != OBJECT_INVALID)
        {
            sRarity = GetLocalString(oItem, "RARITY");

            if(sRarity == "Common" || sRarity == "Uncommon")
            {
                DestroyObject(oItem);
            }
            oItem = GetNextItemInInventory(oFShop);
        }

        SetLocalInt(OBJECT_SELF, "SHOP_TIMER", 0);

        nTracker = nTracker + 1;
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER_2", nTracker);

    }
    else
    {
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER", nCounter);
    }

    if(nTracker >= 21)
    {
        oShop = GetObjectByTag("ArandhelsShop");
        oFShop = GetObjectByTag("ArandhelsShopF");
        lLoc = GetLocation(oShop);
        lFLoc = GetLocation(oFShop);

        if(nCounter >= nMax)
        {
            DestroyObject(oShop);
            DestroyObject(oFShop);
            CreateObject(OBJECT_TYPE_STORE, "morrainesmagic", lLoc);
            CreateObject(OBJECT_TYPE_STORE, "arandhelshopf", lFLoc);
            SetLocalInt(OBJECT_SELF, "SHOP_TIMER_2", 0);
        }
    }
}
