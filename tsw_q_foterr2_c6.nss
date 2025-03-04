//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//:: Check if player has killed DR. Khan and is ready to complete quest
//:: NPC: Ana Catagena
//:: Location: Egypt
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");

    //Check if player does not have Terra Tech 2 Quest, and that they completed Terra Tech 1 Quest
    if(nCheck != 5)
    {
        return FALSE;
    }

    return TRUE;
}

