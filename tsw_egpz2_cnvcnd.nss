//::///////////////////////////////////////////////
//:: FileName tsw_egpz2_cnvcnd
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Alexander Gates
//:: Created On: 1/8/2022
//:://////////////////////////////////////////////
#include "utl_i_sqlplayer"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    //Check local variables
    int nComplete = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_1");
    int nComplete2 = SQLocalsPlayer_GetInt(oPC,"EGYPT_PUZZLE_2");
    if(nComplete != 1 || nComplete2 == 1)
    {
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
