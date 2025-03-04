#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();
    FadeToBlack(oPC, FADE_SPEED_SLOWEST);

    object oMainArea = GetObjectByTag("OE_TheInfinite");
    string sPCName = GetPCPlayerName(oPC);
    int nLength = GetStringLength(sPCName);
    string sClipped = sPCName;
    if(nLength > 20)
    {
        sClipped = GetStringLeft(sPCName, 20);
    }

    //Copy the area for player
    object oNewArea = CopyArea(oMainArea, "OE_" + sClipped + "_INF", "");
    string sNewTag = GetTag(oNewArea);

    //Get teleport waypoint
    object oWP = GetObjectByTag("WP_INTRO_TELE1");
    location lSaved = GetLocation(oWP);
    location lJump = Location(oNewArea, GetPositionFromLocation(lSaved), 0.0);
    DelayCommand(2.0, AssignCommand(oPC, ActionJumpToLocation(lJump)));

    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest == 1)
    {
        AddJournalQuestEntry("Prologue_Quest", 2, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "Prologue_Quest", 2);
    }
}
