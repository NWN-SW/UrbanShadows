//::///////////////////////////////////////////////
//:: Tunu TheBargain Quest Step One
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "THEBARGAIN");
    if(nCheck == 0)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "THEBARGAIN", 1);
        AddJournalQuestEntry("TheBargain", 1, GetPCSpeaker(), FALSE);
    }
}

