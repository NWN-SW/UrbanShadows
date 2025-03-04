//Faction quest step finale.
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    int nCheck = SQLocalsPlayer_GetInt(oPC, "FACTION_QUEST_1");

    if(nCheck == 4)
    {
        AddJournalQuestEntry("Faction_Quest_1", 5, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "FACTION_QUEST_1", 5);
        CreateItemOnObject("fac_lore_itm", oPC);
        CreateItemOnObject("shoptokent2", oPC);
        CreateItemOnObject("shoptokent2", oPC);
        CreateItemOnObject("shoptokent2", oPC);
    }

    if(sFaction == "Templar")
    {
        AddJournalQuestEntry("Faction_Quest_1", 6, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "FACTION_QUEST_1", 6);
        if(GetItemPossessedBy(oPC, "fac_lore_itm") == OBJECT_INVALID)
        {
            CreateItemOnObject("fac_lore_itm", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
        }
    }
	
	
	if(sFaction == "Dragon")
    {
        AddJournalQuestEntry("Faction_Quest_1", 7, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "FACTION_QUEST_1", 7);
        if(GetItemPossessedBy(oPC, "fac_lore_itm") == OBJECT_INVALID)
        {
            CreateItemOnObject("fac_lore_itm", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
        }
    }
	
	
	if(sFaction == "Illuminati")
    {
        AddJournalQuestEntry("Faction_Quest_1", 8, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "FACTION_QUEST_1", 8);
        if(GetItemPossessedBy(oPC, "fac_lore_itm") == OBJECT_INVALID)
        {
            CreateItemOnObject("fac_lore_itm", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
        }
    }
	
}
