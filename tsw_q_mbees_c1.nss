//::///////////////////////////////////////////////
//:: Quest: Missing Bees
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Check if player has yet to receive the quest.
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
	int nCheck2 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA1");
    
	//Check if player has yet to receive the quest, and has completed the egypt starter Dr. Khan quest
	if(nCheck >= 1 || nCheck2 != 2)
    {
        return FALSE;
    }

	//DebugMessage
	//SendMessageToPC(GetFirstPC(), "Debug Message: Click");

    return TRUE;
}

