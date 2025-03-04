void main()
{
    effect eShake = EffectVisualEffect(286);
    effect eImplosion = EffectVisualEffect(24);
    object oPC = GetFirstPC();
    object oArea = GetArea(oPC);
    object oWP = GetObjectByTag("otherworld_in");
    int nInterior = GetIsAreaInterior(oArea);

    //Make sure we only affect players in specific zones.
    string sSafezone = GetTag(oArea);
    string sPrefix = "OE_";
    string sPrefix2 = "OS_";
    string sCompare = GetStringLeft(sSafezone, 3);

    while(oPC != OBJECT_INVALID)
    {
        if(nInterior != 1 && sPrefix != sCompare && sPrefix2 != sCompare)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImplosion, oPC);
        }
        oPC = GetNextPC();
        oArea = GetArea(oPC);
        sSafezone = GetTag(oArea);
        sCompare = GetStringLeft(sSafezone, 3);
    }
}
