//::///////////////////////////////////////////////
//:: Hoben Quest Check Krogrog Stage 12
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 12)
    {
        return TRUE;
    }

    return FALSE;
}
