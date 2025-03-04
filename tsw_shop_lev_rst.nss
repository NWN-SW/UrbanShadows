void main()
{
    int nMax = 14400;
    int nCounter = GetLocalInt(OBJECT_SELF, "SHOP_TIMER");
    object oShop = GetObjectByTag("Bria_Shop");
    location lLoc = GetLocation(oShop);

    if(nCounter >= nMax)
    {
        DestroyObject(oShop);
        CreateObject(OBJECT_TYPE_STORE, "bria_shop", lLoc);
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER", 0);
    }
    else
    {
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER", nCounter);
    }
}
