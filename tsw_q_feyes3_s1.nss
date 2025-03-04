//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Pendant
//:: SQL Name: Q_FEYEST03
//:: Journal Name: Q_FeyEst03
//:: Questgiver NPC: Chest from Festive Winter Grove
//:: Location: Bell Estate
//:://////////////////////////////////////////////

//:: Gives quest if it is not already in the log. Also gives plot item pendant, and some treasure.

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetLastUsedBy();
    int nCheck1 = SQLocalsPlayer_GetInt(oPC, "Q_FEYEST03");

    if( (nCheck1 >= 1) ) {
        FloatingTextStringOnCreature("You have already looted the chest.",oPC,FALSE);
		return;
    }

    else {
        
		FloatingTextStringOnCreature("You find a curious pendant among the trinkets.",oPC,FALSE);
		SQLocalsPlayer_SetInt(oPC, "Q_FEYEST03", 1);
        AddJournalQuestEntry("Q_FeyEst03", 1, oPC, FALSE);
		
		object oItem = GetItemPossessedBy(oPC, "feyest_pendant");
		if(oItem == OBJECT_INVALID)
		{
			CreateItemOnObject("feyest_pendant", oPC);
		} 

		CreateItemOnObject("shoptokent2", oPC);
		CreateItemOnObject("shoptokent3", oPC);
    }
}

