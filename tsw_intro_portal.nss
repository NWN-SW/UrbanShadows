void main()
{
    object oPC = GetPCSpeaker();
    int nCheck = GetLocalInt(oPC, "SPOKEN_WITH_INFINITE");
    object oWP = GetNearestObjectByTag("WP_INTRO_TELE1", oPC);
    location lLoc = GetLocation(oWP);
    if(nCheck != 1)
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, "introportal1", lLoc);
        SetLocalInt(oPC, "SPOKEN_WITH_INFINITE", 1);
    }
}
