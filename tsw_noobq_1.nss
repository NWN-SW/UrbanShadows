//Noobie quest step one.
#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetEnteringObject();
    int nCheck;
    if(GetIsPC(oPC))
    {
        nCheck = SQLocalsPlayer_GetInt(oPC, "NOOBIE_QUEST");
    }

    if(nCheck < 1)
    {
        AddJournalQuestEntry("Noobie_Quest", 1, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "NOOBIE_QUEST", 1);
    }
}
