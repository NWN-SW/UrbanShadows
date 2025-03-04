//::///////////////////////////////////////////////
//:: Tunu F-Word Quest 2
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "TUNUFWORD");
    if(nCheck == 1)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "TUNUFWORD", 2);
        AddJournalQuestEntry("TunuFWord", 2, GetPCSpeaker(), FALSE);
        TakeGoldFromCreature(500, GetPCSpeaker(), TRUE);

    }
}
