//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Sets quest stage to stage 1 if character accepts via the call at Brias.
//:: Script requires that the invisible phone placable is near trigger.
//:: Script requires conversation file (sConvo).

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    int nCheck1 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FEYEST01");

    if( (nCheck1 >= 1) && (nCheck1 <= 13) ) {
        return;
    }

    else {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FEYEST01", 1);
        AddJournalQuestEntry("Q_FeyEst01", 1, GetPCSpeaker(), FALSE);
    }
}
