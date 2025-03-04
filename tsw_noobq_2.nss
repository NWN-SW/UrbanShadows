//Noobie quest step two.
#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetPCSpeaker();
    int nCheck = SQLocalsPlayer_GetInt(oPC, "NOOBIE_QUEST");

    if(nCheck == 1)
    {
        AddJournalQuestEntry("Noobie_Quest", 2, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "NOOBIE_QUEST", 2);
    }
}
