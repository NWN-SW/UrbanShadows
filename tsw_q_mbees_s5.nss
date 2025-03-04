//::///////////////////////////////////////////////
//:: Quest: Missing Bees (TEMPLAR ONLY)
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: Stage 5: Player hands the phone to Ana
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
	object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);	
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_MBEES");

	//non-templar quest stage, used to wrap up the quest here.
    if(nCheck == 4 && sFaction != "Templar")
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_MBEES", 5);
        AddJournalQuestEntry("Q_MBees", 5, GetPCSpeaker(), FALSE);
		CreateItemOnObject("shoptokent4", oPC);
		AddReputation(oPC, 25);
		
		//Remove quest item
		object oCellphone = GetItemPossessedBy(oPC, "MBeePhone");
		DestroyObject(oCellphone);		
    }

	//templar only quest stage, used to wrap up the quest with Luther at the Templar HQ
    else if(nCheck == 4 && sFaction == "Templar")
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_MBEES", 6);
        AddJournalQuestEntry("Q_MBees", 6, GetPCSpeaker(), FALSE);
		CreateItemOnObject("shoptokent4", oPC);
		AddReputation(oPC, 25);
    }


}


