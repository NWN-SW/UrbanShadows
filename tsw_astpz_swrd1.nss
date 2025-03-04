#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetPCSpeaker();
    int nAstDone = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_1");

    if(nAstDone == 1)
    {
        return;
    }

    object oItem = GetItemPossessedBy(oPC, "ObsidianHandle");

    if(oItem == OBJECT_INVALID && nAstDone != 1)
    {
        CreateItemOnObject("obsidianhandle", oPC);
        SQLocalsPlayer_SetInt(oPC, "ASTORIA_PUZZLE_1", 1);
        AddJournalQuestEntry("Astoria_Puzzle", 1, oPC, FALSE);
    }
}
