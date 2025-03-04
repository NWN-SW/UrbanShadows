//::///////////////////////////////////////////////
//:: Quest: Missing Bees
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Check if player has yet to receive the quest.
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
    if(nCheck >= 1)
    {
        return FALSE;
    }

    return TRUE;
}

