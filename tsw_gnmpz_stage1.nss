//::///////////////////////////////////////////////
//:: Hoben Quest Step One
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 0)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "GNOME_QUEST", 1);
        AddJournalQuestEntry("Gnome_Quest", 1, GetPCSpeaker(), FALSE);
        CreateItemOnObject("gnomebeatstick", GetPCSpeaker());
    }
}
