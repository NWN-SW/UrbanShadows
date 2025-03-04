//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//:: Check if player is at quest stage 3.
//:: NPC: Ana Catagena
//:: Location: Egypt
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");

    //Check if player is at quest stage 3.
    if(nCheck == !3)
    {
        return FALSE;
    }

    return TRUE;
}
