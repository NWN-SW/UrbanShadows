void main()
{
    string sAltarCount = "ASTORIA_ALTAR_COUNT";
    string sCountdown = "ASTORIA_ALTAR_COUNTDOWN";
    string sVFXToggle = "ALTER_VFX_TOGGLE";
    int nToggle = GetLocalInt(OBJECT_SELF, sVFXToggle);
    int nAltarCount = GetLocalInt(OBJECT_SELF, sAltarCount);
    int nCountdown = GetLocalInt(OBJECT_SELF, sCountdown);

    if(nCountdown > 0)
    {
        nCountdown = nCountdown - 1;
        SetLocalInt(OBJECT_SELF, sCountdown, nCountdown);
    }
    else if(nCountdown == 0 && nToggle != 1 && nAltarCount != 0)
    {
        nAltarCount = nAltarCount - 1;
        SetLocalInt(OBJECT_SELF, sAltarCount, nAltarCount);
        SetLocalInt(OBJECT_SELF, sCountdown, 10);
    }
}
