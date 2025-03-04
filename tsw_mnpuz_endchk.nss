//::///////////////////////////////////////////////
//:: FileName tsw_mnpuz_endchk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Lord Gates
//:: Created On: 1
//:://////////////////////////////////////////////
#include "utl_i_sqlplayer"

int StartingConditional()
{

    // Inspect local variables
    object oPC = GetPCSpeaker();
    int nEnd = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_6");
    int nCheck = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_5");
    if(nCheck == 1 && nEnd != 1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
