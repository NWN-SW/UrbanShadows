#include "tsw_inc_nui"
#include "0i_database"


void main()
{
   object oPlayer   = NuiGetEventPlayer();
   int nToken       = NuiGetEventWindow();
   string sEvent    = NuiGetEventType();
   string sElement  = NuiGetEventElement();
   int nIndex       = NuiGetEventArrayIndex();
   string sWindowId = NuiGetWindowId(oPlayer, nToken);

    // We use the database to save options and the location of our menus.
    CheckServerDataTableAndCreateTable (PLAYER_TABLE);
    CheckServerDataAndInitialize (OBJECT_SELF, PLAYER_TABLE);

   //SendMessageToPC(oPlayer, "Debug Message: TSW_MOD_NUI.NSS Called");
   //SendMessageToPC(GetFirstPC(), "" + sWindowId);

   if (sWindowId == "nui_keypad_window")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_keyp_ev");
        ExecuteScript("tsw_nui_keyp_ev");
        return;
   }


    if (sWindowId == "nui_keypad_window2")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_keyp_ev");
        ExecuteScript("tsw_nui_keyp_ev2");
        return;
   }


   if (sWindowId == "nui_tablet_window")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_tablet_e");
        ExecuteScript("tsw_nui_tablet_e");
        return;
   }

   if (sWindowId == "nui_tablet_window2")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_tablet_e");
        ExecuteScript("tsw_nui_tablet_e");
        return;
   }

   if (sWindowId == "nui_tablet_window3")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_tablet_e");
        ExecuteScript("tsw_nui_tablet_e");
        return;
   }

   if (sWindowId == "fo_clue01_window")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_tablet_e");
        ExecuteScript("tsw_nui_clue_e");
        return;
   }

   if (sWindowId == "fo_clue02_window")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_tablet_e");
        ExecuteScript("tsw_nui_clue_e");
        return;
   }

   if (sWindowId == "fo_clue03_window")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_tablet_e");
        ExecuteScript("tsw_nui_clue_e");
        return;
   }

   if (sWindowId == "nui_hat_window")
   {
        //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_nui_tablet_e");
        ExecuteScript("tsw_nui_hat_e");
        return;
   }


}
