#include "utl_i_sqlplayer"
//Webhook Stuff
#include "nwnx_events"
#include "nwnx_time"
#include "nwnx_util"
#include "nwnx_webhook_rch"


void main()
{
    //Make sure Astoria ritual area is registered.
    object oPC = GetExitingObject();
    ExecuteScript("tsw_astpz_3_ext", oPC);

    SetLocalInt(oPC, "RESOURCE_BARS_DRAWN", 0);


    //Remove Death Marker from characters who are alive but have it, as a safeguard due to DM raises not removing it.
    int nDeathCheck1 = SQLocalsPlayer_GetInt(oPC, "CURRENTLY_DEAD");
    int nDeathCheck2 = GetIsDead(oPC);
    if(nDeathCheck1 >= 1 && nDeathCheck2 == FALSE){
        SQLocalsPlayer_SetInt(oPC, "CURRENTLY_DEAD", 0);
    }


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
        string sWebHookMessage = (sPlayerName + " has left the game. There are " + IntToString(nPlayerCount - 1) + " online." );
        NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_ENTERDEV"), sWebHookMessage);
    }

    if (sModuleName == "Game") {
        string sWebHookMessage = (sPlayerName + " has left the game. There are " + IntToString(nPlayerCount - 1) + " online." );
        NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_ENTERGAME"), sWebHookMessage);
    }



}
