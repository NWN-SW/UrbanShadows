//:://////////////////////////////////////////////
//:: Created By: FD
//:: Created On: 12.05.2024
//:://////////////////////////////////////////////

#include "utl_i_sqlplayer"
#include "tsw_nui_keyp"

void main()
{
    object oPC = GetLastUsedBy();

    //Set SQL entries for keypad combination and door target tag. Required variables for tsw_nui_keyp_ev.nss.
    SetLocalString(oPC, "KEYPAD_CODE", GetLocalString(OBJECT_SELF,"sDoorKPCombination"));
    SetLocalString(oPC, "KEYPAD_DOOR", GetLocalString(OBJECT_SELF, "sDoorTrigger"));

    //Set SQL entry for popup message when door is opened. Requires variables for tsw_nui_keyp_ev.nss
    SetLocalString(oPC, "KEYPAD_MSG", GetLocalString(OBJECT_SELF, "sMessageDoorOpen"));

    Nui_Keypad_Window(oPC);
}

