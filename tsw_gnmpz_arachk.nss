//::///////////////////////////////////////////////
//:: Hoben Quest Check Arandhel
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 1 || nCheck == 10)
    {
        return FALSE;
    }

    return TRUE;
}
