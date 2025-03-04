//::///////////////////////////////////////////////
//:: Quest: Missing Bees
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Stage 2: Quest Start (Egypt Oasis, NPC: Ana Cartagena)
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
    if(nCheck <= 2)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_MBEES", 2);
        AddJournalQuestEntry("Q_MBees", 2, GetPCSpeaker(), FALSE);
    }
}

