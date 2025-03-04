//Faction quest step four.
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    int nCheck = SQLocalsPlayer_GetInt(oPC, "FACTION_QUEST_1");

    if(nCheck == 3)
    {
        AddJournalQuestEntry("Faction_Quest_1", 4, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "FACTION_QUEST_1", 4);
    }

    if(sFaction == "Templar" || sFaction == "Dragon" || sFaction == "Illuminati")
    {
        AddJournalQuestEntry("Faction_Quest_1", 5, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "FACTION_QUEST_1", 5);
        if(GetItemPossessedBy(oPC, "fac_lore_itm") == OBJECT_INVALID)
        {
            CreateItemOnObject("fac_lore_itm", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
            CreateItemOnObject("shoptokent2", oPC);
        }
    }
}
