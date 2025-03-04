//::///////////////////////////////////////////////
//:: Quest: Missing Bees (TEMPLAR ONLY)
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Stage 1: Quest Start (Templar Base, NPC: Luther)
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
    if(nCheck == 0)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_MBEES", 1);
        AddJournalQuestEntry("Q_MBees", 1, GetPCSpeaker(), FALSE);
    }
}


