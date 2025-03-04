//Noobie quest step three.
#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetPCSpeaker();
    int nCheck = SQLocalsPlayer_GetInt(oPC, "NOOBIE_QUEST");

    if(nCheck == 2)
    {
        AddJournalQuestEntry("Noobie_Quest", 3, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "NOOBIE_QUEST", 3);
        CreateItemOnObject("shoptokent2", oPC);
        CreateItemOnObject("shoptokent2", oPC);
        CreateItemOnObject("shoptokent2", oPC);
        CreateItemOnObject("kitchen_witchit", oPC);
        CreateItemOnObject("m3_tech006", oPC);
    }
}
