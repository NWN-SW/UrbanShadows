//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Questions
//:: SQL Name: Q_FEYEST02
//:: Journal Name: Q_FeyEst02
//:: Questgiver NPC: Bell Estate Portrait
//:: Location: Bell Estate
//:://////////////////////////////////////////////

//:: Gives quest if it is not already in the log.

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    
	if(GetIsPC(GetExitingObject())) {
	
		object oPC = GetExitingObject();
		int nCheck1 = SQLocalsPlayer_GetInt(oPC, "Q_FEYEST02");

		if( (nCheck1 >= 1) ) {
			return;
		}

		else {
			SQLocalsPlayer_SetInt(oPC, "Q_FEYEST02", 1);
			AddJournalQuestEntry("Q_FeyEst02", 1, oPC, FALSE);
		}
	
	}
	
	else {
		return;
	}
}

