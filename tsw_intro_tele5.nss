#include "utl_i_sqlplayer"

void main()
{
    object oWP = GetWaypointByTag("tp_agartha_start");
    object oPC = GetLastUsedBy();
    location lWP = GetLocation(oWP);
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lWP)));

    //Destroy current area
    object oThisArea = GetArea(OBJECT_SELF);
    DelayCommand(4.0, ExecuteScript("tsw_destroy_area", oThisArea));
    DelayCommand(10.0, ExecuteScript("tsw_destroy_area", oThisArea));
    DelayCommand(12.0, ExecuteScript("tsw_destroy_area", oThisArea));

    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest == 6)
    {
        AddJournalQuestEntry("Prologue_Quest", 7, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "Prologue_Quest", 7);
    }

    //Remove intro weapon
    object oWeap = GetItemPossessedBy(oPC, "INTRO_CLUB");
    DestroyObject(oWeap);
}
