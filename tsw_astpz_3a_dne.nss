#include "utl_i_sqlplayer"

void main()
{
    // Set the variables
    SQLocalsPlayer_SetInt(GetPCSpeaker(), "ASTORIA_PUZZLE_3", 1);
    AddJournalQuestEntry("Astoria_Puzzle", 3, GetPCSpeaker(), FALSE);

}
