//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//::
//:: Stage 4: Receive Phone Call
//:: NPC: Ana Catagena
//:: Location: Egypt Oasis OR via Phone call after completing Terra Tech Quest 1.
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");
    if(nCheck == 3)
    {

		SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FOTERRA2", 4);
        AddJournalQuestEntry("Q_FOTerra2", 4, GetPCSpeaker(), FALSE);
    }
}
