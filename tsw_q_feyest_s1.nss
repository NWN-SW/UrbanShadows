//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Checks if a character has completed Fire Shrine Quest. 
//:: 	If they have and have not yet received the fey estate quest, they get a phonecall when they enter this trigger.
//:: Script requires that the invisible phone placable is near trigger.
//:: Script requires conversation file (sConvo).

#include "nw_i0_tool"
#include "utl_i_sqlplayer"


void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    int nCheck1 = SQLocalsPlayer_GetInt(oPC, "Q_FEYEST01");
	int nCheck2 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_4");
    string sAreaTag = GetTag(GetArea(OBJECT_SELF));

	if(nCheck2 != 1) {
		return;
	}
	
	else if(nCheck1 == 0 && (sAreaTag == "OE_EdinburghBriasGoods" || sAreaTag == "_dev")) {
			string sConvo = "conv_q_feycall01";

			// Start the appropriate conversation between the target placable object and the player character.
			AssignCommand(oPC, ActionStartConversation(oPC, sConvo, TRUE, FALSE));				
		}
}
