//::///////////////////////////////////////////////
//:: Quest: Missing Bees
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Check if players have killed the bee and recovered the phone for Ana before joining the templar
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");
	object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
	
    if(nCheck != 5 || sFaction != "Templar")
    {
        return FALSE;
    }

    return TRUE;
}


