#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();
    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest == 0)
    {
        object oMainArea = GetObjectByTag("OE_YourApartment");
        object oPC = GetLastUsedBy();
        string sPCName = GetPCPlayerName(oPC);
        int nLength = GetStringLength(sPCName);
        string sClipped = sPCName;
        if(nLength > 20)
        {
            sClipped = GetStringLeft(sPCName, 20);
        }

        //Copy the area for player
        object oNewArea = CopyArea(oMainArea, "OE_" + sClipped + "_APT", "");
        string sNewTag = GetTag(oNewArea);

        //Assign the name of the apartment to the PC
        SQLocalsPlayer_SetString(oPC, "MY_APARTMENT", sNewTag);


        //Get teleport waypoint
        object oWP = GetObjectByTag("WP_INTRO_TELE");
        location lSaved = GetLocation(oWP);
        location lJump = Location(oNewArea, GetPositionFromLocation(lSaved), 0.0);
        DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lJump)));
    }
    else
    {
        object oWP = GetWaypointByTag("tp_recall");
        location lWP = GetLocation(oWP);
        DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lWP)));
    }
}
