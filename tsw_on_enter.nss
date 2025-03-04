#include "mr_hips_inc"
#include "inc_nui_resource"
#include "utl_i_sqlplayer"
#include "inc_timer"
#include "nw_i0_plot"

//Webhook Stuff
#include "nwnx_events"
#include "nwnx_time"
#include "nwnx_util"
#include "nwnx_webhook_rch"

void ResetInternalCooldowns(object oPC)
{
    //Reset internal cooldowns
    DeleteLocalInt(oPC, "ANIMA_USE_COOLDOWN");
    DeleteLocalInt(oPC, "STAM_USE_COOLDOWN");
    SetLocalInt(oPC, "RES_CD_CLEANER", 1);

    DelayCommand(2.0, ResetInternalCooldowns(oPC));
}

void JumpToDelArea()
{

    JumpToObject(GetWaypointByTag("dreamspawn"));

}


void main()
{
    HIPS_On_ClientEnter();
    object oPC = GetEnteringObject();
    SetLocalInt(oPC,"iJustLogged",1);
    DelayCommand(300.0f,DeleteLocalInt(oPC,"iJustLogged"));
    int nCheck = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");

    object oItem = GetFirstItemInInventory(oPC);
    while(oItem != OBJECT_INVALID)
    {
        if(GetBaseItemType(oItem) == 73)
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }

    //Set internal resource cooldown cleaner
    int nResCD = GetLocalInt(oPC, "RES_CD_CLEANER");
    if(nResCD != 1)
    {
        ResetInternalCooldowns(oPC);
    }

    //Set safety timer for people just logging in.
    SetTimer("OTHERWORLD_PROTECTION", 30, oPC);

    //RESOURCE BARS WEEEE
    //Set default resource bar location if not customization.
    float fPC_X = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_X_POS");
    float fPC_Y = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_Y_POS");
    int nBarsDrawn = GetLocalInt(oPC, "RESOURCE_BARS_DRAWN");
    if(fPC_X == 0.0 || fPC_Y == 0.0)
    {
        SQLocalsPlayer_SetFloat(oPC, "PC_RESOURCE_X_POS", 945.0);
        SQLocalsPlayer_SetFloat(oPC, "PC_RESOURCE_Y_POS", 895.0);
    }

    if(nBarsDrawn == 0 && nCheck >= 7)
    {
        DrawResourceBars(oPC);
        SetLocalInt(oPC, "RESOURCE_BARS_DRAWN", 1);
    }

    DelayCommand(2.0, UpdateBinds(oPC));

    //Reset touch toggle
    DeleteLocalInt(oPC, "TOUCH_TOGGLE");

    //Give gold for new characters
    if(HasGold(50, oPC) == 0)
    {
        RewardGP(50, oPC, FALSE);
    }

    //Disable the map
    //SetGuiPanelDisabled(oPC, GUI_PANEL_MINIMAP, 1);

    //Disable spellbook
    SetGuiPanelDisabled(oPC, GUI_PANEL_SPELLBOOK, 1);

    //Puzzle Journals
    ExecuteScript("pc_addjournals");

    //Kill dead players
    ExecuteScript("tsw_deadlogin");

    //Flag PC if they are a bloodmage
    ExecuteScript("tsw_set_bloodmag", oPC);

    //Webhook Message to Dev Server
    string sPlayerName = GetName(oPC, FALSE);
    object oPlayerSearch = GetFirstPC();
    int nPlayerCount = 0;

    while(oPlayerSearch != OBJECT_INVALID) {
        nPlayerCount = nPlayerCount +1;
        oPlayerSearch = GetNextPC();
    }

    string sModuleName = NWNX_Util_GetEnvironmentVariable("NWNX_TSW_SERVER_TYPE");

    //If module name is SecretWorldDev, we send the webhook to the dev server's discord buzzer channel.
    if (sModuleName == "Dev") {
        string sWebHookMessage = (sPlayerName + " has joined the game. There are " + IntToString(nPlayerCount) + " players logged on.");
        NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_ENTERDEV"), sWebHookMessage);

        if (nPlayerCount == 3 || nPlayerCount == 5 || nPlayerCount == 10 || nPlayerCount == 20 || nPlayerCount == 50) {
            struct NWNX_WebHook_Message stMessage;
            stMessage.sTitle = "Buzz! :bee:";
            stMessage.sColor = "#e2a114";
            stMessage.sDescription = "**A bee has just logged on. There are now " + IntToString(nPlayerCount) + " active bees on Buzzer.**";
            string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER1"), stMessage);
            NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER1"), sConstructedMsg);
        }
    }

    if (sModuleName == "Game") {
        string sWebHookMessage = (sPlayerName + " has joined the game. There are " + IntToString(nPlayerCount) + " players logged on.");
        NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_ENTERGAME"), sWebHookMessage);

        if (nPlayerCount == 1 || nPlayerCount == 3 || nPlayerCount == 8 || nPlayerCount == 12 || nPlayerCount == 15) {
            struct NWNX_WebHook_Message stMessage;
            stMessage.sTitle = "Buzz! :bee:";
            stMessage.sColor = "#e2a114";
            stMessage.sDescription = "**A bee has just logged on. There are now " + IntToString(nPlayerCount) + " active bees on Buzzer.**";
            string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER3"), stMessage);
            NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER3"), sConstructedMsg);
        }
    }


    //Test NUI - This script and those related to it were removed 5.10.2024.
    //ExecuteScript("load_nui_menu", oPC);

    //Proper NUI implementation. Added 5.10.2024 by Fallen.
    //SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "tsw_mod_nui"); //now handled via on event via module properties


    //Destroy menu
    DelayCommand(0.2, ExecuteScript("tsw_clean_ui", oPC));

    //Mystic bolt
    DelayCommand(0.2, DecrementRemainingFeatUses(oPC, 1250));
    DelayCommand(0.3, DecrementRemainingFeatUses(oPC, 1250));
    DelayCommand(0.4, DecrementRemainingFeatUses(oPC, 1250));
    DelayCommand(0.5, DecrementRemainingFeatUses(oPC, 1250));
    DelayCommand(0.6, DecrementRemainingFeatUses(oPC, 1250));


        int iCheckDelete = SQLocalsPlayer_GetInt(oPC, "iMarkedForDeath");
        SetLocalInt(oPC, "iMarkedForDeath",iCheckDelete);
        if (GetLocalInt(oPC,"iMarkedForDeath") == 1)
        {
            AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("dreamspawn"))));
        }


}

