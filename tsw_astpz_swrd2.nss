#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetPCSpeaker();
    int nAstDone = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_2");

    if(nAstDone == 1)
    {
        return;
    }

    object oItem = GetItemPossessedBy(oPC, "ObsidianBlade");

    if(oItem == OBJECT_INVALID && nAstDone != 1)
    {
        CreateItemOnObject("obsidianblade", oPC);
        SQLocalsPlayer_SetInt(oPC, "ASTORIA_PUZZLE_2", 1);
        AddJournalQuestEntry("Astoria_Puzzle", 2, oPC, FALSE);
    }
}
