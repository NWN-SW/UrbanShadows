//::///////////////////////////////////////////////
//:: Gnome Quest Step 12
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 11)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "GNOME_QUEST", 12);
        AddJournalQuestEntry("Gnome_Quest", 12, GetPCSpeaker(), FALSE);
    }
}
