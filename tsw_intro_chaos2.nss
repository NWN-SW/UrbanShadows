#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetEnteringObject();

    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest == 5)
    {
        AddJournalQuestEntry("Prologue_Quest", 6, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "Prologue_Quest", 6);
    }
}
