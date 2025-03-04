//::///////////////////////////////////////////////
//:: Gnome Quest Step 13
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 12)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "GNOME_QUEST", 13);
        AddJournalQuestEntry("Gnome_Quest", 13, GetPCSpeaker(), FALSE);
        //Give Items
        CreateItemOnObject("shoptokent4", GetPCSpeaker());
        CreateItemOnObject("shoptokent4", GetPCSpeaker());
    }
}
