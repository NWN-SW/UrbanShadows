//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 1
//:: SQL Name: Q_FOTERRA1
//:: Journal Name: Q_FOTerra1
//::
//:: Stage 1: Receive Quest
//:: NPC: Ana Catagena
//:: Location: Egypt Oasis
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA1");
    if(nCheck == 0)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FOTERRA1", 1);
        AddJournalQuestEntry("Q_FOTerra1", 1, GetPCSpeaker(), FALSE);
    }
}
