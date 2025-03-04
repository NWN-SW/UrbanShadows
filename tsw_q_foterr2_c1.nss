//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//:: Check if player has yet to receive the quest,
//:: NPC: Ana Catagena
//:: Location: Egypt 
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");
    int nCheck2 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA1");

    //Check if player does not have Terra Tech 2 Quest, and that they completed Terra Tech 1 Quest
    if(nCheck >= 1 || nCheck2 <= 1)
    {
        return FALSE;
    }

    return TRUE;
}
