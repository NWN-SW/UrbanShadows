//::///////////////////////////////////////////////
//:: Gnome Quest Step 11
//:://////////////////////////////////////////////
#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "GNOME_QUEST");
    if(nCheck == 10)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "GNOME_QUEST", 11);
        AddJournalQuestEntry("Gnome_Quest", 11, GetPCSpeaker(), FALSE);
        object oStick = GetItemPossessedBy(GetPCSpeaker(), "GnomeBeatStick");
        DestroyObject(oStick);
    }
}
