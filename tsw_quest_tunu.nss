//::///////////////////////////////////////////////
//:: Tunu F-Word Quest Check 1
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "TUNUFWORD");
    if(nCheck == 1)
    {
        return TRUE;
    }

    return FALSE;
}
