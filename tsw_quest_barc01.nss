//::///////////////////////////////////////////////
//:: Tunu TheBargain Quest Check 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "THEBARGAIN");
    if(nCheck == 1)
    {
        return FALSE;
    }

    return TRUE;
}

