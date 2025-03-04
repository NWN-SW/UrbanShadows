//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//:: First of the four files.
//:: NPC: Ana Catagena
//:: Location: Egypt
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");

    //Check if the player started the quest.
    if(nCheck == 0)
    {
        return FALSE;
    }

    return TRUE;
}

