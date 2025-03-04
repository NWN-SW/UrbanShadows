#include "tsw_inc_nui_insp"
#include "tsw_nui_tablet"
#include "0i_database"

#include "nwnx_events"
#include "nwnx_time"
#include "nwnx_util"
#include "nwnx_webhook_rch"

void main()
{
        object oPlayer   = NuiGetEventPlayer();
        int nToken       = NuiGetEventWindow();
        string sEvent    = NuiGetEventType();
        string sElement  = NuiGetEventElement();
        int nIndex       = NuiGetEventArrayIndex();
        string sWindowId = NuiGetWindowId(oPlayer, nToken);

        int DebugMode = 0;

        // Debug information for when first setting up.
        //SendMessageToPC(GetFirstPC(), "Receive an OnNuiEvent.  Player: " + GetName(oPlayer) + " nToken: " + IntToString(nToken) + " sEvent: " + sEvent + " sElement: " + sElement + " nIndex: " + IntToString(nIndex) + " sWindowId: " + sWindowId);

        // This is not our window, nothing to do.
        if (sWindowId == NUI_TABLET_WINDOW ||
            sWindowId == NUI_TABLET_WINDOW2 ||
            sWindowId == NUI_TABLET_WINDOW3) {
        }

        //else {return;}




    //---------------------------------------
    //FUNCTIONALITY FOR TABLET MAIN INTERFACE
    //---------------------------------------

    sWindowId = NuiGetWindowId(oPlayer, nToken);
    if (sWindowId == NUI_TABLET_WINDOW) {
        //SendMessageToPC(oPlayer, "Debug Message: Main Tablet Interaction");



        if (sElement == "nui_tapp_buzzer") {
                //Debug
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "Buzzer");
                Nui_Tablet_Window2(oPlayer); //open new window for app
                DelayCommand(0.50f, DestroyNuiTablet(oPlayer)); //close old window
                return;
        }

        if (sElement == "nui_tapp_beebay") {
                //Debug
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "Beebay");
                //app mechanic
                return;
        }

        if (sElement == "nui_tapp_hacker") {
                //Debug
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "Hacker");
                //app mechanic
                return;
        }

        if (sElement == "nui_tapp_datab") {
                //Debug
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "Database");
                //app mechanic
                return;
        }

        if (sElement == "nui_tapp_email") {
                //Debu
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "Email");
                //app mechanic
                return;
        }

        if (sElement == "nui_tapp_settings") {
                //Debug
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "Settings");
                //app mechanic
                return;
        }

        if (sElement == "nui_tapp_profile") {
                //Debug
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "MyPlace");
                Nui_Tablet_Window3(oPlayer); //open new window for app
                DelayCommand(0.50f, DestroyNuiTablet(oPlayer)); //close old window
                return;
        }
    }






    //-----------------------------------------------
    //FUNCTIONALITY FOR TABLET BUZZER APP (WINDOW2)
    //-----------------------------------------------


    else if (sWindowId == NUI_TABLET_WINDOW2)
    {

        //Debug
        if (DebugMode == 1)
            SendMessageToPC(oPlayer, "Debug Mode 1: Buzzer 101: Interaction Registered.");

        int nBzzPageChange = 0;
        int nBzzPageNum;
        string sbzz_PageNum;
        int nRefreshRequired = 0;
        int nRefPageNumber;

        int nBzzIconChange = 0;
        int nBzzIconID;

        string sRefBuzzerIcon;



        sqlquery myquerycounter;
        sqlquery myquery;

        //Message Icon Variables
        string bzz_Icn01;
        string bzz_Usr01;
        string bzz_Txt01;
        string bzz_Msg01;
        string bzz_Icn02;
        string bzz_Usr02;
        string bzz_Txt02;
        string bzz_Msg02;
        string bzz_Icn03;
        string bzz_Usr03;
        string bzz_Txt03;
        string bzz_Msg03;
        string bzz_Icn04;
        string bzz_Usr04;
        string bzz_Txt04;
        string bzz_Msg04;
        string bzz_Icn05;
        string bzz_Usr05;
        string bzz_Txt05;
        string bzz_Msg05;

        //Variables for Timestamps and Cooldown
        int nCheckLastBuzz;
        int nCheckCoolDwn;
        string sModuleTime;
        int nHour;
        int nMinute;
        int nSecond;
        int nBuzzCoolDwn;
        int nBuzzerUsrOK = 1;
        int nBuzzerMsgOK = 1;


        if (DebugMode == 1)
            SendMessageToPC(oPlayer, sEvent);


        if (sEvent == "mouseup") {

            // Buzzer Icon next button.
            if (sElement == "nui_buzzer_arw_r_b01") {
              if (DebugMode == 1)
              SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 103: Button Press, User Icon Next.");
              nBzzIconID = JsonGetInt (NuiGetUserData (oPlayer, nToken)) + 1;
              nBzzIconChange = 1;
            }

            // Buzzer Icon previous button.
            if (sElement == "nui_buzzer_arw_l_b01") {
              if (DebugMode == 1)
              SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 104: Button Press, User Icon Previous.");
              nBzzIconID = JsonGetInt (NuiGetUserData (oPlayer, nToken)) - 1;
              nBzzIconChange = -1;
            }

            // Buzzer Page next button.
            if (sElement == "nui_buzzer_parw_r_b01") {
              if (DebugMode == 1)
              SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 105: Button Press, Page Next.");
              nBzzPageNum = JsonGetInt (NuiGetUserData (oPlayer, nToken)) + 1;
              nBzzPageChange = 1;
            }

            // Buzzer Page refresh button.
            if (sElement == "nui_buzzer_refresh") {
              if (DebugMode == 1)
              SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 110: Button Press, Refresh Pages.");
              nRefreshRequired = 1;
            }

            // Buzzer Page previous button.
            if (sElement == "nui_buzzer_parw_l_b01") {
              if (DebugMode == 1)
              SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 106: Button Press, Page Previous.");
              nBzzPageNum = JsonGetInt (NuiGetUserData (oPlayer, nToken)) - 1;
              nBzzPageChange = -1;
            }


            // This section covers sending a message on buzzer.
            if (sElement == "buzzer_send_button") {
                if (DebugMode == 1)
                SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 102: Button Press, Send Message Button.");

                sqlquery bzz_send_query;
                sqlquery bzz_set_query;

                //Checks if username has already been taken.
                string sCNameID = GetName(oPlayer, FALSE);
                string sDBNameID;
                string sBzzMsgUsrN = JsonGetString (NuiGetBind (oPlayer, nToken, "buzzer_unsrame_input"));
                string sCPubCdKey = GetPCPublicCDKey(oPlayer, TRUE);

                bzz_send_query = SqlPrepareQueryCampaign("buzzer", "select id from tab_usr_prot where usrname = @usrname");
                SqlBindString (bzz_send_query, "@usrname", sBzzMsgUsrN);
                while (SqlStep(bzz_send_query)) {
                    sDBNameID = SqlGetString(bzz_send_query, 0); }

                //Debug Messages
                if (DebugMode == 1) {
                    SendMessageToPC(oPlayer, "Debug Mode 1: Buzzer 205: " + sCNameID);
                    SendMessageToPC(oPlayer, "Debug Mode 1: Buzzer 206: " + sBzzMsgUsrN);
                    SendMessageToPC(oPlayer, "Debug Mode 1: Buzzer 207: " + sDBNameID);
                    if (sDBNameID == "")
                        SendMessageToPC(oPlayer, "Debug Mode 1: Buzzer 208: " + " TRUE");
                }


                //Buzzer Username Requirements
                if (sBzzMsgUsrN == "") {
                    SendMessageToPC(oPlayer, "Username must have at least 3 characters");
                    nBuzzerUsrOK = 0;
                }

                else if (GetStringLength(sBzzMsgUsrN) < 3) {
                    SendMessageToPC(oPlayer, "Username must have at least 3 characters");
                    nBuzzerUsrOK = 0;
                }

                else if ( FindSubString(sBzzMsgUsrN, "  ", 0) != -1 ) {
                    SendMessageToPC(oPlayer, "Username may not include double spaces");
                    nBuzzerUsrOK = 0;
                }

                //In case username is not taken, we write the username into the database and tag it with the character name to protect it from others using it.
                if (sDBNameID == "") {
                    //Write new entry for username in database, as username is not taken
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Insert into tab_usr_prot(usrname, id, last_post_time, pubCdKey) values (@tag1, @tag2, @tag3, @tag4)");
                    SqlBindString (bzz_set_query, "@tag1", sBzzMsgUsrN);
                    SqlBindString (bzz_set_query, "@tag2", sCNameID);
                    SqlBindInt (bzz_set_query, "@tag3", 0); //Actual timestamp as int once we figure out how goes here
                    SqlBindString (bzz_set_query, "@tag4", sCPubCdKey);
                    SqlStep(bzz_set_query);

                    sDBNameID = sCNameID;
                }

                //In case username is already taken... send error message.
                else if (sDBNameID != sCNameID) {
                    SendMessageToPC(oPlayer, "This username is already taken.");
                }


                //Buzz Message Requirements
                string sBzzMsgText = JsonGetString (NuiGetBind (oPlayer, nToken, "buzzer_msg_input"));

                if (sBzzMsgText == "" || sBzzMsgText == "Buzz Text!") {
                    nBuzzerMsgOK = 0;
                    SendMessageToPC(oPlayer, "You still need to enter a message.");
                }

                else if (GetStringLength(sBzzMsgText) < 6) {
                    nBuzzerMsgOK = 0;
                    SendMessageToPC(oPlayer, "Your message must be at least five characters long.");
                }

                else if (FindSubString(sBzzMsgText, "  ", 0) != -1) {
                    nBuzzerMsgOK = 0;
                    SendMessageToPC(oPlayer, "Your message may not include double spaces.");
                }


                //Six second cooldown for posting messages
                nCheckLastBuzz = SQLocalsPlayer_GetInt(oPlayer, "LASTBUZZTIME");
                nCheckCoolDwn = 1;

                if (nCheckLastBuzz != 0) {
                    sModuleTime = SQLite_GetSystemTime();
                    nHour = StringToInt((GetSubString(sModuleTime, 0, 2)));
                    nMinute = StringToInt((GetSubString(sModuleTime, 3, 2)));
                    nSecond = StringToInt((GetSubString(sModuleTime, 6, 2)));
                    nBuzzCoolDwn = (nHour * 3600) + (nMinute * 60) + nSecond;

                    //Determine if more than six seconds have passed since last post.
                    if (nCheckLastBuzz >=  nBuzzCoolDwn) {
                        if ((nCheckLastBuzz - nBuzzCoolDwn) < 6) {
                            nCheckCoolDwn = 0;
                        }
                        else
                            SQLocalsPlayer_SetInt(oPlayer, "LASTBUZZTIME", nBuzzCoolDwn);
                    }
                    else if (nCheckLastBuzz <  nBuzzCoolDwn) {
                        if ((nBuzzCoolDwn - nCheckLastBuzz) < 6) {
                            nCheckCoolDwn = 0;
                        }
                        else
                            SQLocalsPlayer_SetInt(oPlayer, "LASTBUZZTIME", nBuzzCoolDwn);
                    }
                    if (DebugMode == 2) {
                    SendMessageToPC(oPlayer, "---------\n" + "Debug Mode 2: Buzzer 601:" +
                        "\nnBuzzCoolDwn: " + IntToString(nHour * 3600) + " + " + IntToString(nMinute * 60) + " + " + IntToString(nSecond) + " = " + IntToString((nHour * 3600) + (nMinute * 60) + nSecond) +
                        "\nnCheckLastBuzz: " + IntToString(nCheckLastBuzz) +
                        "\nnBuzzCoolDwn: " + IntToString(nBuzzCoolDwn) +
                        "\nnCheckCoolDwn: " + IntToString(nCheckCoolDwn) +
                        "\nsModuleTime: " + sModuleTime +
                        "\n---------"
                        );
                    }

                    //Message to player in case less than six seconds have passed.
                    if (nCheckCoolDwn == 0) {
                        SendMessageToPC(oPlayer, "Slow down! You can only buzz once every six seconds.");
                    }
                }



                //If both username and message check out...
                //We now actually write the new message to to the buzzer database (tabmsg table).
                if (sDBNameID == sCNameID && nCheckCoolDwn == 1 && nBuzzerUsrOK != 0 && nBuzzerMsgOK != 0 ) {
                    int bzz_db_entry_tag;
                    string bzz_db_entry_usr;
                    string bzz_db_entry_msg;
                    string bzz_db_entry_icn;
                    string bzz_db_entry_plyrID;
                    string bzz_db_entry_charID;
                    string sCPubCdKey = GetPCPublicCDKey(oPlayer, TRUE);
                    string sCNameID = GetName(oPlayer, FALSE);
                    string sModuleDate = SQLite_GetSystemDate();
                    string sModuleTime = SQLite_GetSystemTime();

                    bzz_send_query = SqlPrepareQueryCampaign("buzzer", "select counter from tabcounter where tag = @tag");
                    SqlBindString (bzz_send_query, "@tag", "MostRecentMessage");
                    while (SqlStep(bzz_send_query)) {
                        bzz_db_entry_tag = ( SqlGetInt(bzz_send_query, 0) +1 ); }
                    if (bzz_db_entry_tag > 50) {
                        bzz_db_entry_tag = ( bzz_db_entry_tag - 50 ); }


                    //Updating entry when the username was last actively used
                    sBzzMsgUsrN = JsonGetString (NuiGetBind (oPlayer, nToken, "buzzer_unsrame_input"));
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tab_usr_prot set last_post_time = @bzz_db_entry where usrname = @usrname");
                    SqlBindString (bzz_set_query, "@usrname", sBzzMsgUsrN);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sModuleDate);
                    SqlStep(bzz_set_query);


                    //Setting Icon in database of latest message
                    string sBzzMsgIconN = JsonGetString (NuiGetBind (oPlayer, nToken, "buzzer_icon_selection"));
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabmsg set msg_img = @bzz_db_entry where tag = @tag");
                    SqlBindInt (bzz_set_query, "@tag", bzz_db_entry_tag);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sBzzMsgIconN);
                    SqlStep(bzz_set_query);
                    SQLocalsPlayer_SetString(oPlayer, "CDB_BuzzerIcon", sBzzMsgIconN);

                    //Setting Username in database of latest message
                    //sBzzMsgUsrN = JsonGetString (NuiGetBind (oPlayer, nToken, "buzzer_unsrame_input"));
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabmsg set msg_usr = @bzz_db_entry where tag = @tag");
                    SqlBindInt (bzz_set_query, "@tag", bzz_db_entry_tag);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sBzzMsgUsrN);
                    SqlStep(bzz_set_query);
                    SQLocalsPlayer_SetString(oPlayer, "CDB_BuzzerUsername", sBzzMsgUsrN);

                    //Setting Text in database of latest message
                    sBzzMsgText = JsonGetString (NuiGetBind (oPlayer, nToken, "buzzer_msg_input"));
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabmsg set msg_txt = @bzz_db_entry where tag = @tag");
                    SqlBindInt (bzz_set_query, "@tag", bzz_db_entry_tag);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sBzzMsgText);
                    SqlStep(bzz_set_query);
                    // For the message, we also blank the message once it has been sent.
                    NuiSetBind (oPlayer, nToken, "buzzer_msg_input", JsonString (""));
                    //NuiSetUserData (oPlayer, nToken, JsonInt (nBzzPageNum));

                    //Setting Public CD Key in database of latest message
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabmsg set player_id = @bzz_db_entry where tag = @tag");
                    SqlBindInt (bzz_set_query, "@tag", bzz_db_entry_tag);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sCPubCdKey);
                    SqlStep(bzz_set_query);

                    //Setting Character name in database of latest message
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabmsg set pc_id = @bzz_db_entry where tag = @tag");
                    SqlBindInt (bzz_set_query, "@tag", bzz_db_entry_tag);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sCNameID);
                    SqlStep(bzz_set_query);

                    //Date and Time
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabmsg set msg_date = @bzz_db_entry where tag = @tag");
                    SqlBindInt (bzz_set_query, "@tag", bzz_db_entry_tag);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sModuleDate);
                    SqlStep(bzz_set_query);

                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabmsg set msg_time = @bzz_db_entry where tag = @tag");
                    SqlBindInt (bzz_set_query, "@tag", bzz_db_entry_tag);
                    SqlBindString (bzz_set_query, "@bzz_db_entry", sModuleTime);
                    SqlStep(bzz_set_query);

                    // increasing the int to that of latest message in the database
                    if (DebugMode == 1)
                        SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 201: " + (IntToString(bzz_db_entry_tag -1)));
                    bzz_set_query = SqlPrepareQueryCampaign("buzzer", "Update tabcounter set counter = @bzz_db_entry where tag = @tag");
                    SqlBindString (bzz_set_query, "@tag", "MostRecentMessage");
                    SqlBindInt (bzz_set_query, "@bzz_db_entry", bzz_db_entry_tag);
                    SqlStep(bzz_set_query);

                    //Attempt to have Buzzer refresh automatically
                    // doing the same for the global module variable that is used in the heartbeat script
                    SetLocalInt(GetModule(), "nModuleBuzzer", bzz_db_entry_tag);

                    // Debug to check the value after it is being updated.
                    if (DebugMode == 1) {
                        bzz_send_query = SqlPrepareQueryCampaign("buzzer", "select counter from tabcounter where tag = @tag");
                        SqlBindString (bzz_send_query, "@tag", "MostRecentMessage");
                        while (SqlStep(bzz_send_query)) {
                            bzz_db_entry_tag =  SqlGetInt(bzz_send_query, 0) ; }
                        if (DebugMode == 1)
                        SendMessageToPC(GetFirstPC(), "Debug Mode 1: Buzzer 201: " + IntToString(bzz_db_entry_tag));
                    }

                    //Forces a refresh of the displayed messages for the current user.
                    nRefreshRequired = 1;

                    //WEBHOOK
                    //This part sends the message to discord.
                    string sModuleName = NWNX_Util_GetEnvironmentVariable("NWNX_TSW_SERVER_TYPE");

                        //If module name is SecretWorldDev, we send the webhook to the dev server's discord buzzer channel.
                        if (sModuleName == "Dev") {

                            struct NWNX_WebHook_Message stMessage;
                            stMessage.sTitle = "Buzz! :bee:";
                            stMessage.sColor = "#e2a114";
                            stMessage.sDescription = "**" + sBzzMsgUsrN + " has just buzzed: " + sBzzMsgText + "**";
                            string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER1"), stMessage);
                            NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER1"), sConstructedMsg);
                        }

                        //If module name is SecretWorld, we send the webhook to the player server's discord buzzer channel.
                        else if (sModuleName == "Game") {
                            struct NWNX_WebHook_Message stMessage;
                            stMessage.sTitle = "Buzz! :bee:";
                            stMessage.sColor = "#e2a114";
                            stMessage.sDescription = "**" + sBzzMsgUsrN + " has just buzzed: " + sBzzMsgText + "**";
                            string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER2"), stMessage);
                            NWNX_WebHook_SendWebHookHTTPS("discord.com", NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_BUZZER2"), sConstructedMsg);
                        }


                    //Refresh for all other users who currently have the Buzzer App NUI Window Open
                    {
                        object oUser = GetFirstPC();

                        while(oUser != OBJECT_INVALID)      {
                            SendMessageToPC(oUser, "Bzzz: New Buzzer Message Notification.");
                            //Check if oUser has the Buzzer App (Nui Window) open. If so, fetch that nToken.
                            int nToken = NuiFindWindow(oUser, "nui_tablet_window2");
                            //Update the Nui-Bound variable for the User with the token.
                            NuiSetBind(oUser, nToken, "buzzer_refresh", JsonInt(1));
                            //As that particularly Nui-Bound variable is also being watched, a change will force a refresh.
                            oUser = GetNextPC();
                        }
                    }
                }
            }
        }

        //Refresh Code
        if (sEvent == "watch" && sElement == "buzzer_refresh") {
            nRefreshRequired = 1;
            NuiSetBind(oPlayer, nToken, "buzzer_refresh", JsonInt (0));
            if (DebugMode == 2) {
                SendMessageToPC(oPlayer, "Debug Mode 1: Buzzer 603: External Refresh Request Accepted");}
        }


        if (nBzzPageChange != 0 || nRefreshRequired != 0) {
            nRefreshRequired = 0;

            //Here we are updating the page numbers. Checks if its within the ten displayable pages first.
            if (nBzzPageNum > 9) {
                nBzzPageNum = 0;
            }

            else if (nBzzPageNum < 0) {
                nBzzPageNum = 9;
            }

            //Updating Page Number text field beneath messages
            sbzz_PageNum = "Page " + IntToString(nBzzPageNum +1);
            NuiSetBind (oPlayer, nToken, "bzz_pagebind", JsonString (sbzz_PageNum));

            NuiSetUserData (oPlayer, nToken, JsonInt (nBzzPageNum));
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "Buzzer Page Now Is: " + IntToString(nBzzPageNum));
            //NuiSetBind (oPlayer, nToken, "page_number_selection", JsonInt (nBzzPageNum));


            //Now we need to update the messages as we are flipping backward in history. First for the last database entry.
            int nDBLastMsgNum;
            myquerycounter = SqlPrepareQueryCampaign("buzzer", "select counter from tabcounter where tag = @tag");
            SqlBindString (myquerycounter, "@tag", "MostRecentMessage");
            while (SqlStep(myquerycounter)) {
                nDBLastMsgNum = SqlGetInt(myquerycounter, 0);
            }

            //Flipping Pages Backward and Foward
            int nMsg1 = nDBLastMsgNum - (nBzzPageNum * 5);
            int nMsgID;
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "nMsg1: " + IntToString(nMsg1));

            // NOTE: THIS SHOULD BE REPLACED BY A LOOP. THIS MASSIVE BLOCK IS JUST NOT PRETTY TO LOOK AT. >:/
            // Message User Icon 1 (Latest Message)
            if ( (nMsg1 + 0) <= 0 )
                nMsgID = nMsg1 + 50 + 0;
            else
                nMsgID = nMsg1 + 0;
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "nMsgID: " + IntToString(nMsgID));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Icn01 = SqlGetString(myquery, 0); }
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "User Icon 1: " + bzz_Icn01);
            NuiSetBind (oPlayer, nToken, "bzz_msgIc01bind", JsonString (bzz_Icn01));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Usr01 = SqlGetString(myquery, 0); }
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Txt01 = SqlGetString(myquery, 0); }
            bzz_Msg01 = (bzz_Usr01 + " buzzed: " + "\n" + bzz_Txt01);
            NuiSetBind (oPlayer, nToken, "bzz_msg01bind", JsonString (bzz_Msg01));

            if ( (nMsg1 -1) <= 0 )
                nMsgID = nMsg1 + 50 -1;
            else
                nMsgID = nMsg1 -1;
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "nMsgID: " + IntToString(nMsgID));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Icn02 = SqlGetString(myquery, 0); }
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "User Icon 1: " + bzz_Icn02);
            NuiSetBind (oPlayer, nToken, "bzz_msgIc02bind", JsonString (bzz_Icn02));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Usr02 = SqlGetString(myquery, 0); }
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Txt02 = SqlGetString(myquery, 0); }
            bzz_Msg02 = (bzz_Usr02 + " buzzed: " + "\n" + bzz_Txt02);
            NuiSetBind (oPlayer, nToken, "bzz_msg02bind", JsonString (bzz_Msg02));

            if ( (nMsg1 -2) <= 0 )
                nMsgID = nMsg1 + 50 -2;
            else
                nMsgID = nMsg1 -2;
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "nMsgID: " + IntToString(nMsgID));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Icn03 = SqlGetString(myquery, 0); }
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "User Icon 1: " + bzz_Icn03);
            NuiSetBind (oPlayer, nToken, "bzz_msgIc03bind", JsonString (bzz_Icn03));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Usr03 = SqlGetString(myquery, 0); }
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Txt03 = SqlGetString(myquery, 0); }
            bzz_Msg03 = (bzz_Usr03 + " buzzed: " + "\n" + bzz_Txt03);
            NuiSetBind (oPlayer, nToken, "bzz_msg03bind", JsonString (bzz_Msg03));

            if ( (nMsg1 -3) <= 0 )
                nMsgID = nMsg1 + 50 -3;
            else
                nMsgID = nMsg1 -3;
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "nMsgID: " + IntToString(nMsgID));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Icn04 = SqlGetString(myquery, 0); }
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "User Icon 1: " + bzz_Icn04);
            NuiSetBind (oPlayer, nToken, "bzz_msgIc04bind", JsonString (bzz_Icn04));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Usr04 = SqlGetString(myquery, 0); }
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Txt04 = SqlGetString(myquery, 0); }
            bzz_Msg04 = (bzz_Usr04 + " buzzed: " + "\n" + bzz_Txt04);
            NuiSetBind (oPlayer, nToken, "bzz_msg04bind", JsonString (bzz_Msg04));

            if ( (nMsg1 -4) <= 0 )
                nMsgID = nMsg1 + 50 -4;
            else
                nMsgID = nMsg1 -4;
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "nMsgID: " + IntToString(nMsgID));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Icn05 = SqlGetString(myquery, 0); }
            if (DebugMode == 1) SendMessageToPC(GetFirstPC(), "User Icon 1: " + bzz_Icn05);
            NuiSetBind (oPlayer, nToken, "bzz_msgIc05bind", JsonString (bzz_Icn05));
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Usr05 = SqlGetString(myquery, 0); }
            myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
            SqlBindInt (myquery, "@tag", nMsgID);
            while (SqlStep(myquery)) {
                bzz_Txt05 = SqlGetString(myquery, 0); }
            bzz_Msg05 = (bzz_Usr05 + " buzzed: " + "\n" + bzz_Txt05);
            NuiSetBind (oPlayer, nToken, "bzz_msg05bind", JsonString (bzz_Msg05));
        }

        if (nBzzIconChange != 0) {

            //Checks to see if portrait number has to be reset at start or end of selection
            if (nBzzIconID > 35) {
                nBzzIconID = 1;
            }

            else if (nBzzIconID <= 0) {
                nBzzIconID = 35;
            }

            sRefBuzzerIcon = "BzzrIcn" + IntToString(nBzzIconID);
            if (DebugMode == 1)
                SendMessageToPC(GetFirstPC(), sRefBuzzerIcon);
            NuiSetUserData (oPlayer, nToken, JsonInt (nBzzIconID));
            NuiSetBind (oPlayer, nToken, "buzzer_icon_selection", JsonString (sRefBuzzerIcon));
        }


    }







    //-----------------------------------------------
    //FUNCTIONALITY FOR TABLET MY PLACE APP (WINDOW3)
    //-----------------------------------------------


    else if (sWindowId == NUI_TABLET_WINDOW3) {

        int nChange = 0;
        int nID;
        string sResRef;

        // Portrait text name event. You can type in a custom portait!
        if (sEvent == "watch" && sElement == "port_name")
        {
            if (DebugMode == 1)
                SendMessageToPC(oPlayer, "Debug Message: 343");
            nID = JsonGetInt (NuiGetUserData (oPlayer, nToken));
            string sBaseResRef = "po_" + Get2DAString ("portraits", "BaseResRef", nID);
            sResRef = JsonGetString (NuiGetBind (oPlayer, nToken, "port_name"));
            if (sBaseResRef != sResRef) NuiSetBind (oPlayer, nToken, "port_id", JsonString ("Custom Portrait"));
            else NuiSetBind (oPlayer, nToken, "port_id", JsonString (IntToString (nID)));

            NuiSetBind (oPlayer, nToken, "port_resref", JsonString (sResRef + "l"));
        }

        if (DebugMode == 1)
            SendMessageToPC(oPlayer, sEvent);

        if (sEvent == "mouseup") {

            // Save button to save the description to the player.
            if (sEvent == "mouseup" && sElement == "nui_cmark_w01")
            {
                if (DebugMode == 1)
                    SendMessageToPC(GetFirstPC(), "Button: Save Description");
                string sDescription = JsonGetString (NuiGetBind (oPlayer, nToken, "desc_value"));
                SetDescription (oPlayer, sDescription);
            }

            // Portrait next button.
            if (sEvent == "mouseup" && sElement == "nui_arw_r_b01")
            {
              if (DebugMode == 1)
                SendMessageToPC(GetFirstPC(), "Button: Next");
              nID = JsonGetInt (NuiGetUserData (oPlayer, nToken)) + 1;
              nChange = 1;
            }

            // Portait previous button.
            if (sElement == "nui_arw_l_b01")
            {
              if (DebugMode == 1)
                SendMessageToPC(GetFirstPC(), "Button: Previous");
              nID = JsonGetInt (NuiGetUserData (oPlayer, nToken)) - 1;
              nChange = -1;
            }

            if (nChange != 0)
            {
                //Int Value for Player Race and Player Gender
                int nPRace, nPGender;
                int nGender = GetGender (oPlayer);
                int nRace = GetRacialType (oPlayer);

                //female characters
                if (nGender == 1) {
                    if (DebugMode == 1)
                        SendMessageToPC(oPlayer, "Debug: Female Character");
                    if (nID < 6501) nID = 6865;
                    else if (nID > 6865) nID = 6501;
                }

                //male characters
                if (nGender == 0) {
                    if (DebugMode == 1)
                        SendMessageToPC(oPlayer, "Debug: Male Character");
                    if (nID < 6001) nID = 6362;
                    else if (nID > 6362) nID = 6001;
                }

                //commented out race, due to how TSW uses them
                //string sPRace = Get2DAString ("portraits", "Race", nID);
                //if (sPRace != "") nPRace = StringToInt (sPRace);
                //else nPRace = -1;

                string sPGender = Get2DAString ("portraits", "Sex", nID);
                if (sPGender != "") nPGender = StringToInt (sPGender);
                else nPGender = -1;

                if (DebugMode == 1)
                    SendMessageToPC(oPlayer, IntToString(nID));
                if (DebugMode == 1)
                    SendMessageToPC(oPlayer, IntToString(nPGender));

                //while ((nRace != nPRace && (nRace != 4 || (nPRace != 1 && nPRace != 6))) || nGender != nPGender)

                while (nGender != nPGender)
                {
                    nID += nChange;

                    //female characters
                    if (nGender == 1) {
                        if (DebugMode == 1)
                            SendMessageToPC(oPlayer, "Debug: Female Character");
                        if (nID < 6501) nID = 6865;
                        else if (nID > 6865) nID = 6501;
                    }

                    //male characters
                    if (nGender == 0) {
                        if (DebugMode == 1)
                            SendMessageToPC(oPlayer, "Debug: Male Character");
                        if (nID < 6001) nID = 6362;
                        else if (nID > 6362) nID = 6001;
                    }

                    //sPRace = Get2DAString ("portraits", "Race", nID);
                    //if (sPRace != "") nPRace = StringToInt (sPRace);
                    //else nPRace = -1;

                    sPGender = Get2DAString ("portraits", "Sex", nID);
                    if (sPGender != "") nPGender = StringToInt (sPGender);
                    else nPGender = -1;
                }

                string sResRef = "po_" + Get2DAString("portraits", "BaseResRef", nID);
                NuiSetUserData (oPlayer, nToken, JsonInt (nID));
                NuiSetBind (oPlayer, nToken, "port_name", JsonString (sResRef));
            }

            // Save portrait button.
            if (sElement == "nui_cmark_b01")
            {
              if (DebugMode == 1)
                SendMessageToPC(GetFirstPC(), "Button: Checkmark Portrait");
              sResRef = JsonGetString (NuiGetBind (oPlayer, nToken, "port_name"));
              string sID = JsonGetString (NuiGetBind (oPlayer, nToken, "port_id"));
              if (sID != "Custom Portrait") SetPortraitId (oPlayer, StringToInt (sID));
              else SetPortraitResRef (oPlayer, sResRef);
            }
        }
    }
}

