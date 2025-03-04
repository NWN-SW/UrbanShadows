//::///////////////////////////////////////////////
//:: FileName Russia Puzzle Check
//:://////////////////////////////////////////////
#include "utl_i_sqlplayer"

int StartingConditional()
{

    // Inspect local variables
    if(!(SQLocalsPlayer_GetInt(GetPCSpeaker(), "RUSSIA_PUZZLE_2") == 1))
        return FALSE;

    return TRUE;
}
