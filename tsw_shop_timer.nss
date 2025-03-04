void main()
{
    int nMax = 100800;
    int nCounter = GetLocalInt(OBJECT_SELF, "SHOP_TIMER");
    object oShop = GetObjectByTag("Bria_Shop");
    object oFShop = GetObjectByTag("Bria_Shop_F");
    location lLoc = GetLocation(oShop);
    location lFLoc = GetLocation(oFShop);

    if(nCounter >= nMax)
    {
        DestroyObject(oShop);
        DestroyObject(oFShop);
        CreateObject(OBJECT_TYPE_STORE, "bria_shop", lLoc);
        CreateObject(OBJECT_TYPE_STORE, "bria_shop_f", lFLoc);
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER", 0);
    }
    else
    {
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "SHOP_TIMER", nCounter);
    }
    //Execute Poodoo item cleanup
    ExecuteScript("tsw_shp_cln_grbg");
}
