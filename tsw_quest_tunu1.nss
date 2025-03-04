//::///////////////////////////////////////////////
//:: Tunu F-Word Quest Check 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "TUNUFWORD");
    if(nCheck == 2)
    {
        return FALSE;
    }

    return TRUE;
}
