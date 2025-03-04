//Faction quest step one.
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetEnteringObject();
    string sFaction = GetFaction(oPC);
    int nCheck;
    int nDone;
    if(GetIsPC(oPC))
    {
        nCheck = SQLocalsPlayer_GetInt(oPC, "FACTION_QUEST_1");
        nDone  = SQLocalsPlayer_GetInt(oPC, "NOOBIE_QUEST");
    }

    if(nCheck < 1 && nDone == 3)
    {
        AddJournalQuestEntry("Faction_Quest_1", 1, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "FACTION_QUEST_1", 1);
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
