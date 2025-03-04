//::///////////////////////////////////////////////
//:: Tunu F-Word Quest Step One
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "TUNUFWORD");
    if(nCheck == 0)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "TUNUFWORD", 1);
        AddJournalQuestEntry("TunuFWord", 1, GetPCSpeaker(), FALSE);
    }
}
