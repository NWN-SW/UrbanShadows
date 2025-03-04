void main()
{
    object oPC = GetEnteringObject();
    object oWP = GetNearestObjectByTag("WP_INTRO_WINDOW", oPC);
    location lLoc = GetLocation(oWP);

    CreateObject(OBJECT_TYPE_PLACEABLE, "introescapewin", lLoc);
}
