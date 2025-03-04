//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 1
//:: SQL Name: Q_FOTERRA1
//:: Journal Name: Q_FOTerra1
//:: Check if player has yet to receive the quest,
//:: NPC: Ana Catagena
//:: Location: Egypt Oasis
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA1");
    if(nCheck >= 1)
    {
        return FALSE;
    }

    return TRUE;
}
