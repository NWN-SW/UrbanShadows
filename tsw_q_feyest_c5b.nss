//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Checks conversation for Albert Sinclaire if you are ready to go to the estate.
//:: Script requires that the invisible phone placable is near trigger.
//:: Script requires conversation file (sConvo).


#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FEYEST01");
    object oPC = GetPCSpeaker();

    if(nCheck <= 4)
    {
        return FALSE;
    }

    return TRUE;
}


