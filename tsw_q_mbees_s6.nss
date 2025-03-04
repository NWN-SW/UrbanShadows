//::///////////////////////////////////////////////
//:: Quest: Missing Bees (TEMPLAR ONLY)
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Stage 7: Player debriefed by Luther, Missing Bee Quest Complete
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");

	//DebugMessage
	SendMessageToPC(GetFirstPC(), "Debug Message3");
	SendMessageToPC(GetFirstPC(), IntToString(nCheck));
	SendMessageToPC(GetFirstPC(), sFaction);

    //templar only quest variant of missing bee quest conclusion
    if(nCheck == 6 && sFaction == "Templar")
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_MBEES", 7);
        AddJournalQuestEntry("Q_MBees", 7, GetPCSpeaker(), FALSE);
        CreateItemOnObject("shoptokent3", oPC);
        AddReputation(oPC, 25);
		
		//Remove quest item
		object oCellphone = GetItemPossessedBy(oPC, "MBeePhone");
		DestroyObject(oCellphone);
    }

    //templar only quest variant of missing bee quest conclusion, completed before templar member
    else if(nCheck == 5 && sFaction == "Templar")
    {
		//DebugMessage
		SendMessageToPC(GetFirstPC(), "Debug Message2");
		
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_MBEES", 7);
        AddJournalQuestEntry("Q_MBees", 7, GetPCSpeaker(), FALSE);
        CreateItemOnObject("shoptokent3", oPC);
        AddReputation(oPC, 25);
    }

}
