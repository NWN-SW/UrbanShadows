#include "tsw_nui_tablet"

void main()
{
    object oPC = GetItemActivator();
    //SendMessageToPC(oPC, "Debug: Tablet Item Script");

    Nui_Tablet_Window(oPC);
    return;
}
