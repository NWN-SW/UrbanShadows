void RestoreFog()
{
    //Global Variables
    object oArea = GetFirstArea();
    int nAmountDay;
    int nAmountNight;
    int nColDay;
    int nColNight;
    int nSkyBox;
    string sTagCheck;
    string sPrefix;
    string sPrefix2;
    string sCompare;

    while(oArea != OBJECT_INVALID)
    {
        //Get Locals
        nAmountDay = GetLocalInt(oArea, "FOG_AMOUNT_DAY");
        nAmountNight = GetLocalInt(oArea, "FOG_AMOUNT_NIGHT");
        nColDay = GetLocalInt(oArea, "FOG_COL_DAY");
        nColNight = GetLocalInt(oArea, "FOG_COL_NIGHT");
        nSkyBox = GetLocalInt(oArea, "SKYBOX_VALUE");

        //Set Fog
        //Make sure we only affect certain areas.
        sTagCheck = GetTag(oArea);
        sPrefix = "OS_";
        sPrefix2 = "OE_";
        sCompare = GetStringLeft(sTagCheck, 3);
        if(sCompare != sPrefix && sCompare != sPrefix2)
        {
            SetFogAmount(FOG_TYPE_SUN, nAmountDay, oArea);
            SetFogAmount(FOG_TYPE_MOON, nAmountNight, oArea);

            SetFogColor(FOG_TYPE_SUN, nColDay, oArea);
            SetFogColor(FOG_TYPE_MOON, nColNight, oArea);

            SetSkyBox(nSkyBox, oArea);
        }
        oArea = GetNextArea();
    }
}
