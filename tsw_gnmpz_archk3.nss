//::///////////////////////////////////////////////
//:: Hoben Quest Check Arandhel Stage 10
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 10)
    {
        return TRUE;
    }

    return FALSE;
}
