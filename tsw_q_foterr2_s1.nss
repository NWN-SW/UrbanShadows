//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//::
//:: Stage 1: Receive Quest
//:: NPC: Ana Catagena
//:: Location: Egypt Oasis OR via Phone call after completing Terra Tech Quest 1.
//:://////////////////////////////////////////////

//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Missing Bees Quest
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//::
//::
//:: Stage 2: Receive Quest
//:: NPC: Ana Catagena
//:: Location: Egypt Oasis OR via Phone call after completing Terra Tech Quest 1.
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");
    if(nCheck == 0)
    {
        //DebugMessage
        //SendMessageToPC(GetFirstPC(), "Debug Message1");

        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FOTERRA2", 1);
        AddJournalQuestEntry("Q_FOTerra2", 1, GetPCSpeaker(), FALSE);
    }


    nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
    if(nCheck == 0)
    {
        //DebugMessage
        //SendMessageToPC(GetFirstPC(), "Debug Message1");

        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_MBEES", 2);
        AddJournalQuestEntry("Q_MBees", 2, GetPCSpeaker(), FALSE);
    }

}
