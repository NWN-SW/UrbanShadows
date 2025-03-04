//::///////////////////////////////////////////////
//:: Quest: Missing Bees
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Check if players have killed the bee and recovered the phone for Ana
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
    if(nCheck != 6)
    {
        return FALSE;
    }

    return TRUE;
}


