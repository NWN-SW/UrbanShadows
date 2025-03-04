#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();
    int nMNDone = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_6");

    if(nMNDone == 1)
    {
        return;
    }

    object oItem = GetItemPossessedBy(oPC, "BadlyDamagedCellphone");

    if(oItem == OBJECT_INVALID && nMNDone != 1)
    {
        CreateItemOnObject("badlydamagedcell", oPC);
        SQLocalsPlayer_SetInt(oPC, "MINNESOTA_PUZZLE_1", 1);
        AddJournalQuestEntry("Minnesota_Puzzle", 1, oPC, FALSE);
    }
}
