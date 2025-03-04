void main()
{
    object HellKeyOne = GetObjectByTag("ObeliskHellKey1");
    object HellKeyTwo = GetObjectByTag("ObeliskHellKey2");
    object HellPortalMain = GetObjectByTag("HellPortalMain");
    int nKeyOne = GetLocalInt(HellKeyOne, "KEY_SET");
    int nKeyTwo = GetLocalInt(HellKeyTwo, "KEY_SET");
    int nPortalOn = GetLocalInt(HellKeyOne, "PORTAL_ON");

    if(nKeyOne >= 50 && nKeyTwo >= 50)
    {
        SetLocalInt(HellKeyOne, "KEY_SET", 0);
        SetLocalInt(HellKeyTwo, "KEY_SET", 0);
        SetLocalInt(HellKeyOne, "PORTAL_ON", 0);
        nKeyOne = 0;
        nKeyTwo = 0;
        DestroyObject(HellPortalMain);
    }
    else if(nKeyOne >= 1 && nKeyTwo >= 1)
    {
        nKeyOne = nKeyOne + 1;
        SetLocalInt(HellKeyOne, "KEY_SET", nKeyOne);
        nKeyTwo = nKeyTwo + 1;
        SetLocalInt(HellKeyTwo, "KEY_SET", nKeyTwo);
    }
}
