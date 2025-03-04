#include "othwld_fog_resto"

void OtherworldFog()
{
    //Old values to restore.
    int nFogAmntDay;
    int nFogAmntNight;
    int nFogColDay;
    int nFogColNight;
    int nSkyBox;

    //Make sure we only affect certain areas.
    object oArea = GetFirstArea();
    string sTagCheck = GetTag(oArea);
    string sPrefix = "OS_";
    string sPrefix2 = "OE_";
    string sCompare = GetStringLeft(sTagCheck, 3);
    float fDelay = 60.0;

    while(oArea != OBJECT_INVALID)
    {
        if(sCompare != sPrefix && sCompare != sPrefix2)
        {
            //Get current values.
            nFogAmntDay = GetFogAmount(FOG_TYPE_SUN, oArea);
            nFogAmntNight = GetFogAmount(FOG_TYPE_MOON, oArea);

            nFogColDay = GetFogColor(FOG_TYPE_SUN, oArea);
            nFogColNight = GetFogColor(FOG_TYPE_MOON, oArea);

            nSkyBox = GetSkyBox(oArea);
            //Save local variables.
            SetLocalInt(oArea, "FOG_AMOUNT_DAY", nFogAmntDay);
            SetLocalInt(oArea, "FOG_AMOUNT_NIGHT", nFogAmntNight);
            SetLocalInt(oArea, "FOG_COL_DAY", nFogColDay);
            SetLocalInt(oArea, "FOG_COL_NIGHT", nFogColNight);
            SetLocalInt(oArea, "SKYBOX_VALUE", nSkyBox);

            //New values used to replace old.
            SetFogAmount(FOG_TYPE_ALL, 150, oArea);
            SetFogColor(FOG_TYPE_ALL, FOG_COLOR_BLACK, oArea);
            SetSkyBox(SKYBOX_NONE, oArea);
        }
        oArea = GetNextArea();
        sTagCheck = GetTag(oArea);
        sCompare = GetStringLeft(sTagCheck, 3);
    }
}
