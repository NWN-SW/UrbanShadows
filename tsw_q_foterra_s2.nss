//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 1
//:: SQL Name: Q_FOTERRA1
//:: Journal Name: Q_FOTerra1
//::
//:: Stage 2: Found Newspaper at Police Station, Accepted Phone Call
//:: Completes This Quest
//:: NPC: Ana Catagena
//:: Location: Egypt Oasis
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
	object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA1");
	
    if(nCheck == 1)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FOTERRA1", 2);
        AddJournalQuestEntry("Q_FOTerra1", 2, GetPCSpeaker(), FALSE);
		AddReputation(oPC, 6);
    }
}

