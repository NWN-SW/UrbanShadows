//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Sets quest stage to stage 5 if character accepts Sommerset's Job.

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
	object oPC = GetPCSpeaker();
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FEYEST01");

    if(nCheck <= 4)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FEYEST01", 5);
        AddJournalQuestEntry("Q_FeyEst01", 5, GetPCSpeaker(), FALSE);
    }
}

