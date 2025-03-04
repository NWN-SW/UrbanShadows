//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Sets quest stage to stage 2 if character starts quest via Cassie.

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
	object oPC = GetPCSpeaker();
	//string sFaction = GetFaction(oPC);
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FEYEST01");
	
    if(nCheck == 0)
    {
        SQLocalsPlayer_SetInt(oPC, "Q_FEYEST01", 2);
        AddJournalQuestEntry("Q_FeyEst01", 2, GetPCSpeaker(), FALSE);
		//AddReputation(oPC, 6);
    }
}
