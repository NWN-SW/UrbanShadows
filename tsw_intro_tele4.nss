#include "utl_i_sqlplayer"

void main()
{
    object oMainArea = GetObjectByTag("OE_Chaos");
    object oPC = GetLastUsedBy();
    string sPCName = GetPCPlayerName(oPC);
    int nLength = GetStringLength(sPCName);
    string sClipped = sPCName;
    if(nLength > 20)
    {
        sClipped = GetStringLeft(sPCName, 20);
    }

    //Copy the area for player
    object oNewArea = CopyArea(oMainArea, "OE_" + sClipped + "_CHAOS", "");
    string sNewTag = GetTag(oNewArea);

    //Get teleport waypoint
    object oWP = GetObjectByTag("WP_INTRO_TELE3");
    location lSaved = GetLocation(oWP);
    location lJump = Location(oNewArea, GetPositionFromLocation(lSaved), 0.0);
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lJump)));

    //Destroy current area
    object oThisArea = GetArea(OBJECT_SELF);
    DelayCommand(5.0, ExecuteScript("tsw_destroy_area", oThisArea));

    //Play glass break
    object oSound = GetNearestObjectByTag("GlassBreaksIntro");
    SoundObjectPlay(oSound);

    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest == 3)
    {
        AddJournalQuestEntry("Prologue_Quest", 4, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "Prologue_Quest", 4);
    }

}
