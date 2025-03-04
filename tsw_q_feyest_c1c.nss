//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Checks for Sommserset conversations if you have accepted the quest already via phonecall.
//:: Script requires that the invisible phone placable is near trigger.
//:: Script requires conversation file (sConvo).


#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FEYEST01");
    object oPC = GetPCSpeaker();
    //string sFaction = GetFaction(oPC);

	//if(nCheck != 5 || sFaction != "Templar")
    if(nCheck != 1)
    {
        return FALSE;
    }

    return TRUE;
}

