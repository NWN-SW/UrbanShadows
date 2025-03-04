//::///////////////////////////////////////////////
//:: Gnome Quest Step Two
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 1)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "GNOME_QUEST", 2);
        AddJournalQuestEntry("Gnome_Quest", 2, GetPCSpeaker(), FALSE);
    }
}
