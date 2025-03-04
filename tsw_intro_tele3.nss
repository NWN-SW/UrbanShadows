#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();
    object oThisArea = GetArea(OBJECT_SELF);

    //Get old apartment
    string sAreaTag = SQLocalsPlayer_GetString(oPC, "MY_APARTMENT");
    object oApartment = GetObjectByTag(sAreaTag);

    //Get teleport waypoint
    object oWP = GetObjectByTag("WP_INTRO_TELE2");
    location lSaved = GetLocation(oWP);
    location lJump = Location(oApartment, GetPositionFromLocation(lSaved), 0.0);
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lJump)));
    DelayCommand(5.0, ExecuteScript("tsw_destroy_area", oThisArea));
    DelayCommand(4.0, ExecuteScript("tsw_destroy_area", oThisArea));
    DelayCommand(8.0, ExecuteScript("tsw_destroy_area", oThisArea));

    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest == 2)
    {
        AddJournalQuestEntry("Prologue_Quest", 3, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "Prologue_Quest", 3);
    }
}
