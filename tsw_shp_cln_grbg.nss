void main()
{
    int nMax = 300;
    int nCounter = GetLocalInt(OBJECT_SELF, "SHOP_TIMER_GARBAGE");
    object oShop = GetObjectByTag("Bria_Shop");
    object oFShop = GetObjectByTag("Bria_Shop_F");
    itemproperty ipCheck;
    int nPropCheck;
    int nCount;
    string sRarity;
    string sTag;

    if(nCounter >= nMax)
    {
        //Clean regular shop
        object oItem = GetFirstItemInInventory(oShop);
        while(oItem != OBJECT_INVALID)
        {
            sRarity = GetLocalString(oItem, "RARITY");

            if(sRarity == "Common" || sRarity == "Uncommon" || sRarity == "Common+" || sRarity == "Uncommon+")
            {
                DestroyObject(oItem);
            }
            oItem = GetNextItemInInventory(oShop);
        }

        //Clean regular shop starter items
        oItem = GetFirstItemInInventory(oShop);
        while(oItem != OBJECT_INVALID)
        {
            sTag = GetTag(oItem);
            sRarity = GetLocalString(oItem, "RARITY");

            if((sRarity != "Rare" || sRarity != "Legendary") && (sTag == "mdrn_start_outfit" || sTag == "d_boots" || sTag == "oh_cleave_wep" || sTag == "d_armour" || sTag == "d_larmour" || sTag == "d_marmour" || sTag == "d_handgun"))
            {
                DestroyObject(oItem);
            }
            oItem = GetNextItemInInventory(oShop);
        }

        //Clean faction shop
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
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER_GARBAGE", 0);

            //Clean faction shop starter items
        oItem = GetFirstItemInInventory(oFShop);
        while(oItem != OBJECT_INVALID)
        {
            sTag = GetTag(oItem);
            sRarity = GetLocalString(oItem, "RARITY");

            if((sRarity != "Rare" && sRarity != "Legendary") && (sTag == "mdrn_start_outfit" || sTag == "d_boots" || sTag == "oh_cleave_wep" || sTag == "d_armour" || sTag == "d_larmour" || sTag == "d_marmour" || sTag == "d_handgun"))
            {
                DestroyObject(oItem);
            }
            oItem = GetNextItemInInventory(oFShop);
        }
    }
    else
    {
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER_GARBAGE", nCounter);
    }
}
