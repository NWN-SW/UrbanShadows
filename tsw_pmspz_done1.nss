#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetPCSpeaker();
    int nParkerDone = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_6");

    if(nParkerDone == 1)
    {
        return;
    }

    object oItem = GetItemPossessedBy(oPC, "ToyStuffedGoat");

    if(oItem == OBJECT_INVALID && nParkerDone != 1)
    {
        CreateItemOnObject("toystuffedgoat", oPC);
        SQLocalsPlayer_SetInt(oPC, "PARKER_PUZZLE_1", 1);
        AddJournalQuestEntry("Parker_Puzzle", 1, oPC, FALSE);
    }
}
