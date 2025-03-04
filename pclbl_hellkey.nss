void main()
{
    object HellKeyOne = GetObjectByTag("ObeliskHellKey1");
    object HellKeyTwo = GetObjectByTag("ObeliskHellKey2");
    object HellPortalTag = GetObjectByTag("HellPortalTagMain");
    object oPC = GetLastUsedBy();
    int nPortalOn = GetLocalInt(HellKeyOne, "PORTAL_ON");
    int nKeyMe = GetLocalInt(OBJECT_SELF, "KEY_SET");
    location lTag = GetLocation(HellPortalTag);
    effect eBlood = EffectVisualEffect(496);
    effect eShake = EffectVisualEffect(286);

    if(nKeyMe == 0)
    {
        SetLocalInt(OBJECT_SELF, "KEY_SET", 1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlood, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, OBJECT_SELF);
        SendMessageToPC(oPC, "You activate a portal key.");
    }

    int nKeyOne = GetLocalInt(HellKeyOne, "KEY_SET");
    int nKeyTwo = GetLocalInt(HellKeyTwo, "KEY_SET");

    if(nKeyOne >= 1 && nKeyTwo >= 1 && nPortalOn == 0)
    {
        SetLocalInt(HellKeyOne, "PORTAL_ON", 1);
        CreateObject(64, "hellgatemain", lTag);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBlood, lTag);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lTag);
        FloatingTextStringOnCreature("A portal activates somewhere...", oPC);
    }
}
