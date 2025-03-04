//::///////////////////////////////////////////////
//:: Quest: Missing Bees
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Check if player has received Quest from Luther as Templar and talks to Ana
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
    if(nCheck == 0 || nCheck >= 2)
    {
        return FALSE;
    }

    return TRUE;
}


