#include "tsw_inc_nui"
#include "tsw_inc_nui_insp"
#include "utl_i_sqlplayer"
#include "0i_database"

const string NUI_TABLET_WINDOW  = "nui_tablet_window";
const string NUI_TABLET_WINDOW2 = "nui_tablet_window2"; //Buzzer APP
const string NUI_TABLET_WINDOW3 = "nui_tablet_window3"; //MyPlace APP

//NUI




int nIdx = NuiGetEventArrayIndex();


//window for main tablet nui interface

void Nui_Tablet_Window(object oPlayer) {


    // First we look for any previous windows, if found (ie, non-zero) we destory them so we can start fresh.
    int nPreviousToken = NuiFindWindow(oPlayer, NUI_TABLET_WINDOW);
    if (nPreviousToken != 0)
    {
            NuiDestroy(oPlayer, nPreviousToken);
    }

    json jCol = JsonArray();
    json jRow = JsonArray();
    { //BACKGROUND, TABLET
       json jSpacer = NuiSpacer();

       json jDrawImage = NuiDrawListImage(
           JsonBool(TRUE),
           JsonString("m3_tab_bck"),
           NuiRect(0.0, 0.0,  1004.0, 718.0),
           JsonInt(NUI_ASPECT_FILL),
           JsonInt(NUI_HALIGN_CENTER),
           JsonInt(NUI_VALIGN_MIDDLE),
           NUI_DRAW_LIST_ITEM_ORDER_BEFORE,
           NUI_DRAW_LIST_ITEM_RENDER_ALWAYS);

          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);
          jDrawImage = JsonArrayInsert(JsonArray(), jDrawImage);
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);
          jRow = JsonArrayInsert(jRow, jSpacer);
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));

    //SCREEN BORDER LEFT
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 85.0f));

    //APPS COLUMN 1
    {
        jRow = JsonArray(); {
            json jAPP1 = NuiImage(
                JsonString("nui_app_buzzer"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));

            jAPP1 = NuiId(jAPP1, "nui_tapp_buzzer");
            jAPP1 = NuiWidth(jAPP1, 74.0f);
            jAPP1 = NuiHeight(jAPP1, 72.0f);

            json jApp1L = NuiLabel(JsonString("Buzzer"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));

            jRow = JsonArray();
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 80.0f));
            jRow = JsonArrayInsert(jRow, jAPP1);
            jRow = JsonArrayInsert(jRow, jApp1L);
            jRow = JsonArrayInsert(jRow, NuiSpacer());
            jRow = NuiCol(jRow);
        }
    } jCol = JsonArrayInsert(jCol, jRow);
    json jRoot = NuiRow(jCol);


    //APPS COLUMN 2
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 40.0f)); {
        jRow = JsonArray(); {    //<--
            json jAPP2 = NuiImage(
                JsonString("nui_app_beebay"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));

            jAPP2 = NuiId(jAPP2, "nui_tapp_beebay");
            jAPP2 = NuiWidth(jAPP2, 74.0f);
            jAPP2 = NuiHeight(jAPP2, 72.0f);

            json jApp2L = NuiLabel(JsonString("Beebay"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));

            jRow = JsonArray();
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 80.0f));
            jRow = JsonArrayInsert(jRow, jAPP2);
            jRow = JsonArrayInsert(jRow, jApp2L);
            jRow = JsonArrayInsert(jRow, NuiSpacer());
            jRow = NuiCol(jRow);
        }
    } jCol = JsonArrayInsert(jCol, jRow);
    jRoot = NuiRow(jCol);

    //APPS COLUMN 3
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 40.0f)); {
        jRow = JsonArray(); {    //<--
            json jAPP3 = NuiImage(
                JsonString("nui_app_hacker"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));

            jAPP3 = NuiId(jAPP3, "nui_tapp_hacker");
            jAPP3 = NuiWidth(jAPP3, 74.0f);
            jAPP3 = NuiHeight(jAPP3, 72.0f);

            json jApp3L = NuiLabel(JsonString("Lockpick"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));

            jRow = JsonArray();
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 80.0f));
            jRow = JsonArrayInsert(jRow, jAPP3);
            jRow = JsonArrayInsert(jRow, jApp3L);
            jRow = JsonArrayInsert(jRow, NuiSpacer());
            jRow = NuiCol(jRow);
        }
    } jCol = JsonArrayInsert(jCol, jRow);
    jRoot = NuiRow(jCol);




    //APPS COLUMN 4
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 40.0f)); {
        jRow = JsonArray(); {    //<--
            json jAPP4 = NuiImage(
                JsonString("nui_app_datab"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));

            jAPP4 = NuiId(jAPP4, "nui_tapp_datab");
            jAPP4 = NuiWidth(jAPP4, 74.0f);
            jAPP4 = NuiHeight(jAPP4, 72.0f);

            json jApp4L = NuiLabel(JsonString("Database"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));

            jRow = JsonArray();
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 80.0f));
            jRow = JsonArrayInsert(jRow, jAPP4);
            jRow = JsonArrayInsert(jRow, jApp4L);
            jRow = JsonArrayInsert(jRow, NuiSpacer());
            jRow = NuiCol(jRow);
        }
    } jCol = JsonArrayInsert(jCol, jRow);
    jRoot = NuiRow(jCol);


    //APPS COLUMN 5
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 40.0f)); {
        jRow = JsonArray(); {    //<--
            json jAPP5 = NuiImage(
                JsonString("nui_app_email"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));

            jAPP5 = NuiId(jAPP5, "nui_tapp_email");
            jAPP5 = NuiWidth(jAPP5, 74.0f);
            jAPP5 = NuiHeight(jAPP5, 72.0f);

            json jApp5L = NuiLabel(JsonString("E-mail"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));

            jRow = JsonArray();
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 80.0f));
            jRow = JsonArrayInsert(jRow, jAPP5);
            jRow = JsonArrayInsert(jRow, jApp5L);
            jRow = JsonArrayInsert(jRow, NuiSpacer());
            jRow = NuiCol(jRow);
        }
    } jCol = JsonArrayInsert(jCol, jRow);
    jRoot = NuiRow(jCol);

    //APPS COLUMN 6
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 154.0f)); {
        jRow = JsonArray(); {    //<--
            json jAPP6 = NuiImage(
                JsonString("nui_app_settings"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));
            json jAPP7 = NuiImage(
                JsonString("nui_app_profile"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_TOP));

            jAPP6 = NuiId(jAPP6, "nui_tapp_settings");
            jAPP6 = NuiWidth(jAPP6, 74.0f);
            jAPP6 = NuiHeight(jAPP6, 72.0f);
            jAPP7 = NuiId(jAPP7, "nui_tapp_profile");
            jAPP7 = NuiWidth(jAPP7, 74.0f);
            jAPP7 = NuiHeight(jAPP7, 72.0f);

            json jApp6L = NuiLabel(JsonString("Settings"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));
            json jApp7L = NuiLabel(JsonString("Profile"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));

            jRow = JsonArray();
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 80.0f));
            jRow = JsonArrayInsert(jRow, jAPP6);
            jRow = JsonArrayInsert(jRow, jApp6L);
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 40.0f));
            jRow = JsonArrayInsert(jRow, jAPP7);
            jRow = JsonArrayInsert(jRow, jApp7L);
            jRow = JsonArrayInsert(jRow, NuiSpacer());
            jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 250.0f));
            jRow = NuiCol(jRow);
        }
    } jCol = JsonArrayInsert(jCol, jRow);
    jRoot = NuiRow(jCol);

    //SCREEN BORDER RIGHT
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 160.0f));
    //jCol = JsonArrayInsert(jCol, NuiSpacer());
    jRoot = NuiRow(jCol);

    // This is the main window with jRoot as the main pane.  It includes titles and parameters (more on those later)
    json nui = NuiWindow(jRoot, JsonString(""), NuiBind("geometry"), NuiBind("resizable"), NuiBind("collapsed"), NuiBind("closable"), NuiBind("transparent"), NuiBind("border"));

    // finally create it and it'll return us a non-zero token.
    int nToken = NuiCreate(oPlayer, nui, NUI_TABLET_WINDOW);

    // This are binds, which are like varaiables to NUI elements that can be changed latter.  Or in this case, changed now.
    NuiSetBind(oPlayer, nToken, "geometry", NuiRect(-1.0f, -1.0f, 1014.0f, 762.0f));    //1004.0f, 718.0f
    NuiSetBind(oPlayer, nToken, "collapsed", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "resizable", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "closable", JsonBool(TRUE));
    NuiSetBind(oPlayer, nToken, "transparent", JsonBool(TRUE));
    NuiSetBind(oPlayer, nToken, "border", JsonBool(FALSE));

}








//--------------------------------------------
//BUZZER APP Nui Interface for Tablet NUI
//By FallenDabus
//Created: 14.05.2024
//--------------------------------------------

void Nui_Tablet_Window2(object oPlayer) {

    //1. First we look for any previous windows, if found (ie, non-zero) we destory them so we can start fresh.
    int nPreviousToken = NuiFindWindow(oPlayer, NUI_TABLET_WINDOW2);
    if (nPreviousToken != 0)
            NuiDestroy(oPlayer, nPreviousToken);

    //2. More on layouts and elements and grouping latter, but this is "root" panel.
    json jCol = JsonArray();
    json jRow = JsonArray();

    //3. BACKGROUND, TABLET. This is the background element for the buzzer app we overlay the rest with.
    {  json jSpacer = NuiSpacer();

       json jDrawImage = NuiDrawListImage(
           JsonBool(TRUE),
           //JsonString("m3_tab_bck"),
           JsonString("m3_tab_bzz_bck"),
           NuiRect(0.0, 0.0,  1004.0, 718.0),
           JsonInt(NUI_ASPECT_FILL),
           JsonInt(NUI_HALIGN_CENTER),
           JsonInt(NUI_VALIGN_MIDDLE),
           NUI_DRAW_LIST_ITEM_ORDER_BEFORE,
           NUI_DRAW_LIST_ITEM_RENDER_ALWAYS);

          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);     // <---  here
          jDrawImage = JsonArrayInsert(JsonArray(), jDrawImage);
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);
          jRow = JsonArrayInsert(jRow, jSpacer);
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //4. Time to create all of our columns. Including the empty columns we need for spacing, we need six.
    //4a. Empty Border Left Column
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 22.0f));


    // ------------------------------------------------------------------------------------------------------------
    // LEFT SIDE: INPUT COLUMN
    // ------------------------------------------------------------------------------------------------------------
    //4b. Column for left side input interface, which includes the text field to write the message you want to post.
    json jInputPannel = JsonArray(); {

        jInputPannel = JsonArrayInsert(jInputPannel, NuiHeight(NuiSpacer(), 50.0f));

        json jgTopGroup = JsonArray(); {
            json jrTextInputBody = JsonArray();  {

                //This is the leftside column that holds the message icon.
                json jrImageRow = JsonArray();  {
                    //Space
                    jrImageRow = JsonArrayInsert(jrImageRow, NuiHeight(NuiSpacer(), 20.0f));
                    jrImageRow = NuiRow(jrImageRow);
                }
                jrTextInputBody = JsonArrayInsert(jrTextInputBody, jrImageRow);
            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgTopGroup    = NuiGroup(NuiCol(jrTextInputBody), FALSE, NUI_SCROLLBARS_NONE);
            jgTopGroup    = NuiHeight(jgTopGroup, 240.0f);
            jgTopGroup    = NuiWidth(jgTopGroup, 250.0f);
        }
        jInputPannel = JsonArrayInsert(jInputPannel, jgTopGroup);


        json jgInputGroup = JsonArray(); {
            json jrInputBody = JsonArray(); {

                //UserIconSelectionField
                json jgUserIconGroup = JsonArray(); {
                    json jrIconRow = JsonArray(); {

                        // Left Button (Previous User Icon)
                        json jARWL = NuiImage(
                            JsonString("bzz_Larr_l"),
                            JsonInt(NUI_ASPECT_EXACTSCALED),
                            JsonInt(NUI_HALIGN_CENTER),
                            JsonInt(NUI_VALIGN_MIDDLE));
                        jARWL = NuiId(jARWL, "nui_buzzer_arw_l_b01");
                        jARWL = NuiWidth(jARWL, 60.0f);
                        jARWL = NuiHeight(jARWL, 60.0f);

                        //User Icon Image
                        json jMUserIcon = NuiImage(NuiBind ("buzzer_icon_selection"),
                            JsonInt(NUI_ASPECT_FIT),
                            JsonInt(NUI_HALIGN_CENTER),
                            JsonInt(NUI_VALIGN_MIDDLE));
                            jMUserIcon = NuiWidth(jMUserIcon, 95.0f);
                            jMUserIcon = NuiHeight(jMUserIcon, 95.0f);

                        // Right Button (Next User Icon)
                        json jARWR = NuiImage(
                            JsonString("bzz_Rarr_l"),
                            JsonInt(NUI_ASPECT_EXACTSCALED),
                            JsonInt(NUI_HALIGN_CENTER),
                            JsonInt(NUI_VALIGN_MIDDLE));
                        jARWR = NuiId(jARWR, "nui_buzzer_arw_r_b01");
                        jARWR = NuiWidth(jARWR, 60.0f);
                        jARWR = NuiHeight(jARWR, 60.0f);

                        //2.3 Create and add button row
                        json jButtonRow = JsonArray();{
                            jButtonRow = JsonArrayInsert (jButtonRow, NuiSpacer ());
                            jButtonRow = JsonArrayInsert(jButtonRow, jARWL);
                            jButtonRow = JsonArrayInsert(jButtonRow, jMUserIcon);
                            //jButtonRow = JsonArrayInsert(jButtonRow, NuiWidth(NuiSpacer(), 9.0f));
                            jButtonRow = JsonArrayInsert(jButtonRow, jARWR);
                            jButtonRow = JsonArrayInsert (jButtonRow, NuiSpacer ());
                            jButtonRow = NuiRow(jButtonRow);
                        } jrIconRow = JsonArrayInsert(jrIconRow, jButtonRow);
                    }
                    //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
                    jgUserIconGroup    = NuiGroup(NuiCol(jrIconRow), FALSE, NUI_SCROLLBARS_NONE);
                    jgUserIconGroup    = NuiHeight(jgUserIconGroup, 110.0f);
                    jgUserIconGroup    = NuiWidth(jgUserIconGroup, 250.0f);
                }
                jrInputBody = JsonArrayInsert(jrInputBody, jgUserIconGroup);

                //UserName Input Field
                json jgUserNameGroup = JsonArray(); {
                    json jrInputBody = JsonArray();  {
                        //This is the leftside column that holds the message icon.

                       json jrImageRow = JsonArray();  {
                            //Username Edit Box
                            json jCDEditBox = JsonArray(); {
                                jCDEditBox = CreateTextEditBox (jCDEditBox , "desc_Placeholder", "buzzer_unsrame_input",
                                    22, TRUE, 234.0, 23.0, "buzzer_usrname_tooltip");
                                jCDEditBox = NuiRow(jCDEditBox);
                            }
                            jrImageRow = JsonArrayInsert(jrImageRow, jCDEditBox);
                            jrImageRow = NuiRow(jrImageRow);
                        }
                        jrInputBody = JsonArrayInsert(jrInputBody, jrImageRow);
                    }
                    //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
                    jgUserNameGroup    = NuiGroup(NuiRow(jrInputBody), FALSE, NUI_SCROLLBARS_NONE);
                    jgUserNameGroup    = NuiHeight(jgUserNameGroup, 27.0f);
                    jgUserNameGroup    = NuiWidth(jgUserNameGroup, 248.0f);
                } jrInputBody = JsonArrayInsert(jrInputBody, jgUserNameGroup);

                //Message Input Field
                json jgMessageInputGroup = JsonArray(); {
                    json jrTextInputBody = JsonArray();  {

                        //This is the leftside column that holds the message icon.
                        json jrImageRow = JsonArray();  {

                            //Space
                            jrImageRow = JsonArrayInsert(jrImageRow, NuiHeight(NuiSpacer(), 20.0f));

                            //Message Edit Box
                            json jCDEditBox = JsonArray(); {
                                jCDEditBox = CreateTextEditBox (jCDEditBox , "desc_Placeholder", "buzzer_msg_input",
                                                  160, TRUE, 234.0, 140.0, "buzzer_msg_tooltip");
                                jCDEditBox = NuiRow(jCDEditBox);
                            }
                            jrImageRow = JsonArrayInsert(jrImageRow, jCDEditBox);
                            jrImageRow = NuiRow(jrImageRow);
                        }
                        jrTextInputBody = JsonArrayInsert(jrTextInputBody, jrImageRow);
                    }
                    //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
                    jgMessageInputGroup    = NuiGroup(NuiRow(jrTextInputBody), FALSE, NUI_SCROLLBARS_NONE);
                    jgMessageInputGroup    = NuiHeight(jgMessageInputGroup, 238.0f);
                    jgMessageInputGroup    = NuiWidth(jgMessageInputGroup, 248.0f);
                }
                jrInputBody = JsonArrayInsert(jrInputBody, jgMessageInputGroup);

                //Message Input Row that has the send button on the right.
                /*
				json jbSendBuzz = NuiImage(
                        JsonString("bzz_send_s"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_RIGHT),
                        JsonInt(NUI_VALIGN_TOP));

                    jbSendBuzz = NuiId(jbSendBuzz, "buzzer_send_button");
				*/	

                json jrMessageSendButtonRow = JsonArray(); {    
                    jrMessageSendButtonRow = JsonArrayInsert(jrMessageSendButtonRow, NuiWidth(NuiSpacer(), 50.0f));
					//jrMessageSendButtonRow = JsonArrayInsert(jrMessageSendButtonRow, jbSendBuzz);
					jrMessageSendButtonRow = JsonArrayInsert(jrMessageSendButtonRow, NuiWidth(NuiSpacer(), 150.0f));
                    jrMessageSendButtonRow = NuiRow(jrMessageSendButtonRow);
                }
                jrInputBody = JsonArrayInsert(jrInputBody, jrMessageSendButtonRow);

                //Spacer: BottomBorderRow
                jrInputBody = JsonArrayInsert(jrInputBody, NuiHeight(NuiSpacer(), 500.0f));
            }
            //Set the group.
            //We are giving it a fixed size so that the layout wont be affected by it content.
            jgInputGroup    = NuiGroup(NuiCol(jrInputBody), FALSE, NUI_SCROLLBARS_NONE);
            jgInputGroup    = NuiHeight(jgInputGroup, 302.0f);
            jgInputGroup    = NuiWidth(jgInputGroup, 265.0f);
        }
        jInputPannel = JsonArrayInsert(jInputPannel, jgInputGroup);



        json jgTopGroup2 = JsonArray(); {
            json jrTextInputBody = JsonArray();  {

                //This is the leftside column that holds the message icon.
                json jrImageRow = JsonArray();  {

                    jrImageRow = JsonArrayInsert (jrImageRow, NuiSpacer ());

                    json jbSendBuzz = NuiImage(
                        JsonString("bzz_send_s"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_RIGHT),
                        JsonInt(NUI_VALIGN_TOP));

                    jbSendBuzz = NuiId(jbSendBuzz, "buzzer_send_button");
                    jbSendBuzz = NuiWidth(jbSendBuzz, 42.0f);
                    jbSendBuzz = NuiHeight(jbSendBuzz, 40.0f);

					jrImageRow = JsonArrayInsert(jrImageRow, NuiWidth(NuiSpacer(), 150.0f));                 
                    jrImageRow = JsonArrayInsert(jrImageRow, jbSendBuzz);
					jrImageRow = JsonArrayInsert(jrImageRow, NuiWidth(NuiSpacer(), 20.0f));                  
                    jrImageRow = NuiRow(jrImageRow);
					
                }
                jrTextInputBody = JsonArrayInsert(jrTextInputBody, jrImageRow);
            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgTopGroup2    = NuiGroup(NuiCol(jrTextInputBody), FALSE, NUI_SCROLLBARS_NONE);
            jgTopGroup2    = NuiHeight(jgTopGroup2, 40.0f);
            jgTopGroup2    = NuiWidth(jgTopGroup2, 265.0f);
        }
        jInputPannel = JsonArrayInsert(jInputPannel, jgTopGroup2);

        jInputPannel = NuiCol(jInputPannel);
    } jCol = JsonArrayInsert(jCol, jInputPannel);
    json jRoot = NuiRow(jCol);





    //4c. Empty Column for spacing.
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 18.0f));

    // ----------------------------------------------------------
    // RIGHT SIDE: MESSAGE FEED COLUMN
    // -----------------------------------------------------------
    //4d. Column for message icons, and author + message textfield
    json jMsgPannel = JsonArray();
    {
        //4d.01. Empty Row for spacing.
        jMsgPannel = JsonArrayInsert(jMsgPannel, NuiHeight(NuiSpacer(), 56.0f));

        //This group is the message window row that holds the message icon, message author, and the message itself.
        //FIRST MESSAGE
        json jgMsgGroup01 = JsonArray(); {
            json jrMainRow = JsonArray(); {

                //This is the leftside column that holds the message icon.
                json jcImageColumn = JsonArray(); {
                    json jMIcon = NuiImage (NuiBind ("bzz_msgIc01bind"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_CENTER),
                        JsonInt(NUI_VALIGN_MIDDLE));
                    jMIcon = NuiWidth(jMIcon, 95.0f);
                    jMIcon = NuiHeight(jMIcon, 95.0f);

                    jcImageColumn = JsonArrayInsert(jcImageColumn, jMIcon);
                    jcImageColumn = NuiCol(jcImageColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcImageColumn);

                //This is the rightside column that holds the message text and username.
                json jcTextColumn = JsonArray(); {
                    json jMsg01 = NuiText(NuiBind("bzz_msg01bind"), FALSE, 0);

                    jcTextColumn = JsonArrayInsert(jcTextColumn, jMsg01);
                    jcTextColumn = NuiCol(jcTextColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcTextColumn);
            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgMsgGroup01    = NuiGroup(NuiRow(jrMainRow), FALSE, NUI_SCROLLBARS_NONE);
            jgMsgGroup01    = NuiHeight(jgMsgGroup01, 104.0f);
            jgMsgGroup01    = NuiWidth(jgMsgGroup01, 535.0f);
        }
        jMsgPannel = JsonArrayInsert(jMsgPannel, jgMsgGroup01);


        //4d.x. Empty Row for spacing.
        jMsgPannel = JsonArrayInsert(jMsgPannel, NuiHeight(NuiSpacer(), 12.0f));

        //SECOND MESSAGE
        json jgMsgGroup02 = JsonArray(); {
            json jrMainRow = JsonArray();  {

                //This is the leftside column that holds the message icon.
                json jcImageColumn = JsonArray();
                {
                    json jMIcon = NuiImage (NuiBind ("bzz_msgIc02bind"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_CENTER),
                        JsonInt(NUI_VALIGN_MIDDLE));
                    jMIcon = NuiWidth(jMIcon, 95.0f);
                    jMIcon = NuiHeight(jMIcon, 95.0f);

                    jcImageColumn = JsonArrayInsert(jcImageColumn, jMIcon);
                    jcImageColumn = NuiCol(jcImageColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcImageColumn);

                //This is the rightside column that holds the message text and username.
                json jcTextColumn = JsonArray(); {
                    json jMsg01 = NuiText(NuiBind("bzz_msg02bind"), FALSE, 0);

                    jcTextColumn = JsonArrayInsert(jcTextColumn, jMsg01);
                    jcTextColumn = NuiCol(jcTextColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcTextColumn);

            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgMsgGroup02    = NuiGroup(NuiRow(jrMainRow), FALSE, NUI_SCROLLBARS_NONE);
            jgMsgGroup02    = NuiHeight(jgMsgGroup02, 104.0f);
            jgMsgGroup02    = NuiWidth(jgMsgGroup02, 535.0f);
        }
        jMsgPannel = JsonArrayInsert(jMsgPannel, jgMsgGroup02);


        //4d.x. Empty Row for spacing.
        jMsgPannel = JsonArrayInsert(jMsgPannel, NuiHeight(NuiSpacer(), 12.0f));

        //THIRD MESSAGE
        json jgMsgGroup03 = JsonArray(); {
            json jrMainRow = JsonArray(); {

                //This is the leftside column that holds the message icon.
                json jcImageColumn = JsonArray(); {
                    json jMIcon = NuiImage (NuiBind ("bzz_msgIc03bind"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_CENTER),
                        JsonInt(NUI_VALIGN_MIDDLE));
                    jMIcon = NuiWidth(jMIcon, 95.0f);
                    jMIcon = NuiHeight(jMIcon, 95.0f);

                    jcImageColumn = JsonArrayInsert(jcImageColumn, jMIcon);
                    jcImageColumn = NuiCol(jcImageColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcImageColumn);

                //This is the rightside column that holds the message text and username.
                json jcTextColumn = JsonArray();
                {
                    json jMsg01 = NuiText(NuiBind("bzz_msg03bind"), FALSE, 0);

                    jcTextColumn = JsonArrayInsert(jcTextColumn, jMsg01);
                    jcTextColumn = NuiCol(jcTextColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcTextColumn);
            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgMsgGroup03    = NuiGroup(NuiRow(jrMainRow), FALSE, NUI_SCROLLBARS_NONE);
            jgMsgGroup03    = NuiHeight(jgMsgGroup03, 104.0f);
            jgMsgGroup03    = NuiWidth(jgMsgGroup03, 535.0f);
        }
        jMsgPannel = JsonArrayInsert(jMsgPannel, jgMsgGroup03);


        //4d.x. Empty Row for spacing.
        jMsgPannel = JsonArrayInsert(jMsgPannel, NuiHeight(NuiSpacer(), 12.0f));

        //FOURTH MESSAGE
        json jgMsgGroup04 = JsonArray(); {
            json jrMainRow = JsonArray(); {

                //This is the leftside column that holds the message icon.
                json jcImageColumn = JsonArray(); {
                    json jMIcon = NuiImage (NuiBind ("bzz_msgIc04bind"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_CENTER),
                        JsonInt(NUI_VALIGN_MIDDLE));
                    jMIcon = NuiWidth(jMIcon, 95.0f);
                    jMIcon = NuiHeight(jMIcon, 95.0f);

                    jcImageColumn = JsonArrayInsert(jcImageColumn, jMIcon);
                    jcImageColumn = NuiCol(jcImageColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcImageColumn);

                //This is the rightside column that holds the message text and username.
                json jcTextColumn = JsonArray(); {
                    json jMsg01 = NuiText(NuiBind("bzz_msg04bind"), FALSE, 0);

                    jcTextColumn = JsonArrayInsert(jcTextColumn, jMsg01);
                    jcTextColumn = NuiCol(jcTextColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcTextColumn);

            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgMsgGroup04    = NuiGroup(NuiRow(jrMainRow), FALSE, NUI_SCROLLBARS_NONE);
            jgMsgGroup04    = NuiHeight(jgMsgGroup04, 104.0f);
            jgMsgGroup04    = NuiWidth(jgMsgGroup04, 535.0f);
        }
        jMsgPannel = JsonArrayInsert(jMsgPannel, jgMsgGroup04);


        //4d.x. Empty Row for spacing.
        jMsgPannel = JsonArrayInsert(jMsgPannel, NuiHeight(NuiSpacer(), 11.0f));

        //FIFTH MESSAGE
        json jgMsgGroup05 = JsonArray(); {
            json jrMainRow = JsonArray(); {
                //This is the leftside column that holds the message icon.
                json jcImageColumn = JsonArray(); {
                    //Insert and binding of the icon image
                   json jMIcon = NuiImage (NuiBind ("bzz_msgIc05bind"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_CENTER),
                        JsonInt(NUI_VALIGN_MIDDLE));
                    jMIcon = NuiWidth(jMIcon, 95.0f);
                    jMIcon = NuiHeight(jMIcon, 95.0f);

                    jcImageColumn = JsonArrayInsert(jcImageColumn, jMIcon);
                    jcImageColumn = NuiCol(jcImageColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcImageColumn);

                //This is the rightside column that holds the message text and username.
                json jcTextColumn = JsonArray();  {
                    json jMsg01 = NuiText(NuiBind("bzz_msg05bind"), FALSE, 0);

                    jcTextColumn = JsonArrayInsert(jcTextColumn, jMsg01);
                    jcTextColumn = NuiCol(jcTextColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcTextColumn);
            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgMsgGroup05    = NuiGroup(NuiRow(jrMainRow), FALSE, NUI_SCROLLBARS_NONE);
            jgMsgGroup05    = NuiHeight(jgMsgGroup05, 104.0f);
            jgMsgGroup05    = NuiWidth(jgMsgGroup05, 535.0f);
        }
        jMsgPannel = JsonArrayInsert(jMsgPannel, jgMsgGroup05);


        //LOWER BUTTON ROW
        json jgMsgButtonRow = JsonArray(); {
            json jrMainRow = JsonArray(); {

                //This is the leftside column that holds the message icon.
                json jcImageColumn = JsonArray();
                {
                    json jARWL = NuiImage(
                            JsonString("bzz_Larr_s"),
                            JsonInt(NUI_ASPECT_FIT),
                            JsonInt(NUI_HALIGN_LEFT),
                            JsonInt(NUI_VALIGN_MIDDLE));

                        jARWL = NuiId(jARWL, "nui_buzzer_parw_l_b01");
                        jARWL = NuiWidth(jARWL, 38.0f);
                        jARWL = NuiHeight(jARWL, 24.0f);

                        json jARWR = NuiImage(
                            JsonString("bzz_Rarr_s"),
                            JsonInt(NUI_ASPECT_FIT),
                            JsonInt(NUI_HALIGN_RIGHT),
                            JsonInt(NUI_VALIGN_MIDDLE));

                        jARWR = NuiId(jARWR, "nui_buzzer_parw_r_b01");
                        jARWR = NuiWidth(jARWR, 38.0f);
                        jARWR = NuiHeight(jARWR, 24.0f);

                        //This is the rightside column that holds the message text and username.
                        json jcPageNumber = JsonArray();  {
                            json jMsg01 = NuiText(NuiBind("bzz_pagebind"), FALSE, 0);

                            jcPageNumber = JsonArrayInsert(jcPageNumber, jMsg01);
                            jcPageNumber = NuiCol(jcPageNumber);
                        }


                        //2.3 Create and add button row
                        json jButtonRow = JsonArray();{
                            //jButtonRow = JsonArrayInsert (jButtonRow, NuiSpacer ());
                            jButtonRow = JsonArrayInsert(jButtonRow, jARWL);
                            jButtonRow = JsonArrayInsert(jButtonRow, NuiWidth(NuiSpacer(), 200.0f));
                            jButtonRow = JsonArrayInsert(jButtonRow, jcPageNumber);
                            jButtonRow = JsonArrayInsert(jButtonRow, NuiWidth(NuiSpacer(), 50.0f));
                            jButtonRow = JsonArrayInsert(jButtonRow, jARWR);
                            //jButtonRow = JsonArrayInsert (jButtonRow, NuiSpacer ());
                            jButtonRow = NuiRow(jButtonRow); //We want the buttons horizontal, hence we add it as a NuiRow
                        } jcImageColumn = JsonArrayInsert(jcImageColumn, jButtonRow);
                        //jrIconRow = NuiRow(jrIconRow);
                    jcImageColumn = NuiCol(jcImageColumn);
                }
                jrMainRow = JsonArrayInsert(jrMainRow, jcImageColumn);
            }
            //Set the group. We are giving it a fixed size so that the layout wont be affected by message lengths.
            jgMsgButtonRow    = NuiGroup(NuiRow(jrMainRow), FALSE, NUI_SCROLLBARS_NONE);
            jgMsgButtonRow    = NuiHeight(jgMsgButtonRow, 36.0f);
            jgMsgButtonRow    = NuiWidth(jgMsgButtonRow, 535.0f);
        }
        jMsgPannel = JsonArrayInsert(jMsgPannel, jgMsgButtonRow);



        //End Piece: Transforming jInputPannel into a NUI Layout (NuiCol = NuiColumn)
        jMsgPannel = NuiCol(jMsgPannel);

    } jCol = JsonArrayInsert(jCol, jMsgPannel);
    jRoot = NuiRow(jCol);


    //4f. Empty Border Right Column
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 90.0f));

    //5. Add last column to root as well.
    jRoot = NuiRow(jCol);

    // This is the main window with jRoot as the main pane.  It includes titles and parameters (more on those later)
    json nui = NuiWindow(jRoot, JsonString(""), NuiBind("geometry"), NuiBind("resizable"), NuiBind("collapsed"), NuiBind("closable"), NuiBind("transparent"), NuiBind("border"));

    // finally create it and it'll return us a non-zero token.
    int nToken = NuiCreate(oPlayer, nui, NUI_TABLET_WINDOW2);

    // This are binds, which are like varaiables to NUI elements that can be changed latter.  Or in this case, changed now.
    NuiSetBind(oPlayer, nToken, "geometry", NuiRect(-1.0f, -1.0f, 1014.0f, 762.0f));    //1004.0f, 718.0f
    NuiSetBind(oPlayer, nToken, "collapsed", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "resizable", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "closable", JsonBool(TRUE));
    NuiSetBind(oPlayer, nToken, "transparent", JsonBool(TRUE));
    NuiSetBind(oPlayer, nToken, "border", JsonBool(FALSE));


    // ---------------------------------------------
    // BINDS AND VARIABLES FOR BUZZER APP (WINDOW 2)
    // ---------------------------------------------

    string nBzzIconID;
    string sRefBuzzerIcon;
    int nRefPageNumber = 0;
    int nBzzPageNum;
    int nMsgID;
    int nMostRecentMsg;
    string sbzz_PageNum = "Page 1";
	int nRefreshRequest = 0;

    // nMostRecentMsg tracks in the database the entry number / tag (integer) of the most recently posted message.
    sqlquery myquerycounter;
    sqlquery myquery;
    myquerycounter = SqlPrepareQueryCampaign("buzzer", "select counter from tabcounter where tag = @tag");
    SqlBindString (myquerycounter, "@tag", "MostRecentMessage");
    while (SqlStep(myquerycounter)) {
        nMostRecentMsg = SqlGetInt(myquerycounter, 0);
    }

    int nMsgNumber = nMostRecentMsg;


    // NOTE: THIS SHOULD BE REPLACED BY A LOOP. THIS MASSIVE BLOCK IS JUST NOT PRETTY TO LOOK AT. >:[
    // Message Button Binds (Including databank queries to find the Page 0 Entries)

    //Message 01 (Icon, User and Text)
    string bzz_Icn01;
    string bzz_Usr01;
    string bzz_Txt01;
    string bzz_Msg01;
    if ( (nMsgNumber + 0) <= 0 ) nMsgID = nMsgNumber + 50 + 0;
    else nMsgID = nMsgNumber + 0;
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Icn01 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Usr01 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Txt01 = SqlGetString(myquery, 0); }
    bzz_Msg01 = (bzz_Usr01 + " buzzed: " + "\n" + bzz_Txt01);

    string bzz_Icn02;
    string bzz_Usr02;
    string bzz_Txt02;
    string bzz_Msg02;
    if ( (nMsgNumber -1) <= 0 ) nMsgID = nMsgNumber + 50 -1;
    else nMsgID = nMsgNumber -1;
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Icn02 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Usr02 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Txt02 = SqlGetString(myquery, 0); }
    bzz_Msg02 = (bzz_Usr02 + " buzzed: " + "\n" + bzz_Txt02);

    string bzz_Icn03;
    string bzz_Usr03;
    string bzz_Txt03;
    string bzz_Msg03;
    if ( (nMsgNumber -2) <= 0 ) nMsgID = nMsgNumber + 50 -2;
    else nMsgID = nMsgNumber -2;
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Icn03 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Usr03 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Txt03 = SqlGetString(myquery, 0); }
    bzz_Msg03 = (bzz_Usr03 + " buzzed: " + "\n" + bzz_Txt03);

    string bzz_Icn04;
    string bzz_Usr04;
    string bzz_Txt04;
    string bzz_Msg04;
    if ( (nMsgNumber -3) <= 0 ) nMsgID = nMsgNumber + 50 -3;
    else nMsgID = nMsgNumber -3;
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Icn04 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Usr04 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Txt04 = SqlGetString(myquery, 0); }
    bzz_Msg04 = (bzz_Usr04 + " buzzed: " + "\n" + bzz_Txt04);

    string bzz_Icn05;
    string bzz_Usr05;
    string bzz_Txt05;
    string bzz_Msg05;
    if ( (nMsgNumber -4) <= 0 ) nMsgID = nMsgNumber + 50 -4;
    else nMsgID = nMsgNumber -4;
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_img from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Icn05 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_usr from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Usr05 = SqlGetString(myquery, 0); }
    myquery = SqlPrepareQueryCampaign("buzzer", "select msg_txt from tabmsg where tag = @tag");
    SqlBindInt (myquery, "@tag", nMsgID);
    while (SqlStep(myquery)) {
        bzz_Txt05 = SqlGetString(myquery, 0); }
    bzz_Msg05 = (bzz_Usr05 + " buzzed: " + "\n" + bzz_Txt05);


    // Username Input Binds and Variables
    string sBuzzUsrName;
    if ( SQLocalsPlayer_GetString(oPlayer, "CDB_BuzzerUsername") != "") {
        sBuzzUsrName = SQLocalsPlayer_GetString (oPlayer, "CDB_BuzzerUsername"); }

    else {
        sBuzzUsrName = "Buzzer Username!"; }

    // Username Input Binds and Variables
    NuiSetBind (oPlayer, nToken, "buzzer_unsrame_input", JsonString (sBuzzUsrName));
    NuiSetBind (oPlayer, nToken, "buzzer_usrname_tooltip", JsonString ("Enter Username!"));

    // Message Input Binds and Variables
    string sBuzzMessage = "Buzz Text!";
    NuiSetBind (oPlayer, nToken, "buzzer_msg_input", JsonString (sBuzzMessage));
    NuiSetBind (oPlayer, nToken, "buzzer_msg_tooltip", JsonString ("Enter Buzz!"));

    // Message Send Button Binds
    NuiSetBind (oPlayer, nToken, "buzzer_send_button", JsonBool (TRUE));

    // Set the portrait name to be watch in e_window_pc so we can update it
    if ( SQLocalsPlayer_GetString(oPlayer, "CDB_BuzzerIcon") != "") {
        sRefBuzzerIcon = SQLocalsPlayer_GetString (oPlayer, "CDB_BuzzerIcon"); }

    else {
        sRefBuzzerIcon = "BzzrIcn25"; }

    NuiSetBind (oPlayer, nToken, "buzzer_icon_selection", JsonString (sRefBuzzerIcon));
    NuiSetBind (oPlayer, nToken, "page_number_selection", JsonInt (nRefPageNumber));

    // Add a tool tip so the player knows they can enter a custom portrait.
    NuiSetBind (oPlayer, nToken, "nui_buzzer_arw_l_b01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "nui_buzzer_arw_r_b01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "nui_buzzer_refresh", JsonBool (TRUE));

    //Bindings for Page Buttons
    NuiSetBind (oPlayer, nToken, "nui_buzzer_parw_l_b01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "nui_buzzer_parw_r_b01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "bzz_pagebind", JsonString (sbzz_PageNum));


    //MessageContentBinds
    NuiSetBind (oPlayer, nToken, "bzz_msgIc01bind", JsonString (bzz_Icn01));
    NuiSetBind (oPlayer, nToken, "bzz_msgUsr01bind", JsonString (bzz_Usr01));
    NuiSetBind (oPlayer, nToken, "bzz_msgTxt01bind", JsonString (bzz_Txt01));
    NuiSetBind (oPlayer, nToken, "bzz_msg01bind", JsonString (bzz_Msg01));

    NuiSetBind (oPlayer, nToken, "bzz_msgIc02bind", JsonString (bzz_Icn02));
    NuiSetBind (oPlayer, nToken, "bzz_msgUsr02bind", JsonString (bzz_Usr02));
    NuiSetBind (oPlayer, nToken, "bzz_msgTxt02bind", JsonString (bzz_Txt02));
    NuiSetBind (oPlayer, nToken, "bzz_msg02bind", JsonString (bzz_Msg02));

    NuiSetBind (oPlayer, nToken, "bzz_msgIc03bind", JsonString (bzz_Icn03));
    NuiSetBind (oPlayer, nToken, "bzz_msgUsr03bind", JsonString (bzz_Usr03));
    NuiSetBind (oPlayer, nToken, "bzz_msgTxt03bind", JsonString (bzz_Txt03));
    NuiSetBind (oPlayer, nToken, "bzz_msg03bind", JsonString (bzz_Msg03));

    NuiSetBind (oPlayer, nToken, "bzz_msgIc04bind", JsonString (bzz_Icn04));
    NuiSetBind (oPlayer, nToken, "bzz_msgUsr04bind", JsonString (bzz_Usr04));
    NuiSetBind (oPlayer, nToken, "bzz_msgTxt04bind", JsonString (bzz_Txt04));
    NuiSetBind (oPlayer, nToken, "bzz_msg04bind", JsonString (bzz_Msg04));

    NuiSetBind (oPlayer, nToken, "bzz_msgIc05bind", JsonString (bzz_Icn05));
    NuiSetBind (oPlayer, nToken, "bzz_msgUsr05bind", JsonString (bzz_Usr05));
    NuiSetBind (oPlayer, nToken, "bzz_msgTxt05bind", JsonString (bzz_Txt05));
    NuiSetBind (oPlayer, nToken, "bzz_msg05bind", JsonString (bzz_Msg05));

    // attempt to have buzzer refresh automatically
    // module variable
    NuiSetBind (oPlayer, nToken, "buzzer_refresh", JsonInt (nRefreshRequest));

    // custom portrait entered.
    NuiSetBindWatch (oPlayer, nToken, "buzzer_icon_name", TRUE);
    NuiSetBindWatch (oPlayer, nToken, "buzzer_refresh", TRUE);

}








//--------------------------------------------
//MYPlace APP Nui Interface for Tablet NUI
//By FallenDabus
//Created: 14.05.2024
//--------------------------------------------

//window for main tablet nui interface
void Nui_Tablet_Window3(object oPlayer) {

    // First we look for any previous windows, if found (ie, non-zero) we destory them so we can start fresh.
    int nPreviousToken = NuiFindWindow(oPlayer, NUI_TABLET_WINDOW3);
    if (nPreviousToken != 0)
    {
            NuiDestroy(oPlayer, nPreviousToken);
    }

    // More on layouts and elements and grouping latter, but this is "root" pane.
    json jCol = JsonArray();
    json jRow = JsonArray();

    //BACKGROUND, TABLET
    {
       json jSpacer = NuiSpacer();

       json jDrawImage = NuiDrawListImage(
           JsonBool(TRUE),
           JsonString("m3_tab_mp_bck"),
           //JsonString("m3_tab_bck"),
           NuiRect(0.0, 0.0,  1004.0, 718.0),
           JsonInt(NUI_ASPECT_FILL),
           JsonInt(NUI_HALIGN_CENTER),
           JsonInt(NUI_VALIGN_MIDDLE),
           NUI_DRAW_LIST_ITEM_ORDER_BEFORE,
           NUI_DRAW_LIST_ITEM_RENDER_ALWAYS);


          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);     // <---  here
          jDrawImage = JsonArrayInsert(JsonArray(), jDrawImage);
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);
          jRow = JsonArrayInsert(jRow, jSpacer);
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //COLUMN 1 - Empty Border Left
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 20.0f));

    //COLUMN 2 - jCharacterPanel - Column for Portrait and Character Description Selection
    json jCPannel = JsonArray();
    {
        jCPannel = JsonArrayInsert(jCPannel, NuiHeight(NuiSpacer(), 70.0f));

        //2.1. Create and add text edit box, so players can enter a custom portrait.
        json jCPNum = JsonArray(); {
            jCPNum = JsonArrayInsert (jCPNum, NuiSpacer ());
            jCPNum = CreateTextEditBox (jCPNum, "port_p_holder", "port_name", 15, FALSE, 140.0, 30.0, "port_tooltip");
            jCPNum = JsonArrayInsert (jCPNum, NuiSpacer ());
            jCPNum = NuiRow(jCPNum);
        } jCPannel = JsonArrayInsert(jCPannel, jCPNum);

        //jCPannel = JsonArrayInsert(jCPannel, NuiHeight(NuiSpacer(), 10.0f));


        //jCPannel = JsonArrayInsert (jCPannel, NuiSpacer ());
        jCPannel = JsonArrayInsert(jCPannel, NuiHeight(NuiSpacer(), 10.0f));

        //2.2. Create and add portrait row
        json jPortrait = NuiImage (NuiBind ("port_resref"),
            JsonInt (NUI_ASPECT_EXACT),
            JsonInt (NUI_HALIGN_CENTER),
            JsonInt (NUI_VALIGN_MIDDLE));
        jCPannel = JsonArrayInsert(jCPannel, jPortrait);
        //jCPannel = JsonArrayInsert(jCPannel, NuiHeight(NuiSpacer(), 25.0f));


        //2.2 Create Image Buttons for Button Row in 2.3.
        json jARWL = NuiImage(
                    JsonString("nui_arw_l_b01"),
                    JsonInt(NUI_ASPECT_FIT),
                    JsonInt(NUI_HALIGN_CENTER),
                    JsonInt(NUI_VALIGN_MIDDLE));

                jARWL = NuiId(jARWL, "nui_arw_l_b01");
                jARWL = NuiWidth(jARWL, 42.0f);
                jARWL = NuiHeight(jARWL, 40.0f);

        json jCMrk1 = NuiImage(
                    JsonString("nui_cmark_b01"),
                    JsonInt(NUI_ASPECT_FIT),
                    JsonInt(NUI_HALIGN_CENTER),
                    JsonInt(NUI_VALIGN_MIDDLE));

                jCMrk1 = NuiId(jCMrk1, "nui_cmark_b01");
                jCMrk1 = NuiWidth(jCMrk1, 42.0f);
                jCMrk1 = NuiHeight(jCMrk1, 40.0f);

        json jARWR = NuiImage(
                    JsonString("nui_arw_r_b01"),
                    JsonInt(NUI_ASPECT_FIT),
                    JsonInt(NUI_HALIGN_CENTER),
                    JsonInt(NUI_VALIGN_MIDDLE));

                jARWR = NuiId(jARWR, "nui_arw_r_b01");
                jARWR = NuiWidth(jARWR, 42.0f);
                jARWR = NuiHeight(jARWR, 40.0f);


        //2.3 Create and add button row
        json jButtonRow = JsonArray();{
            jButtonRow = JsonArrayInsert (jButtonRow, NuiSpacer ());
            jButtonRow = JsonArrayInsert(jButtonRow, jARWL);
            //jButtonRow = CreateButton (jButtonRow, "", "btn_portrait_prev", 42.0f, 40.0); // <---
            jButtonRow = JsonArrayInsert(jButtonRow, NuiWidth(NuiSpacer(), 9.0f));
            jButtonRow = JsonArrayInsert(jButtonRow, jCMrk1);
            //jButtonRow = CreateButton (jButtonRow, "", "btn_portrait_ok", 44.0f, 40.0); // <---
            jButtonRow = JsonArrayInsert(jButtonRow, NuiWidth(NuiSpacer(), 9.0f));
            jButtonRow = JsonArrayInsert(jButtonRow, jARWR);
            //jButtonRow = CreateButton (jButtonRow, "", "btn_portrait_next", 42.0f, 40.0); // <---
            jButtonRow = JsonArrayInsert (jButtonRow, NuiSpacer ());
            jButtonRow = NuiRow(jButtonRow); //We want the buttons horizontal, hence we add it as a NuiRow
        } jCPannel = JsonArrayInsert(jCPannel, jButtonRow);
        //jCPannel = JsonArrayInsert(jCPannel, NuiHeight(NuiSpacer(), 10.0f));

        //2.4 Create and add description label
        json jCPLabel = JsonArray();
        {
            //jCPLabel = JsonArrayInsert (jCPLabel, NuiSpacer ());
            jCPLabel = JsonArrayInsert(jCPLabel, NuiWidth(NuiSpacer(), 10.0f));
            jCPLabel = CreateLabel (jCPLabel, "description_label", 200.0, 10.0f);
            jCPLabel = CreateLabel (jCPLabel, "port_id", 30.0, 10.0f);
            jCPLabel = JsonArrayInsert (jCPLabel, NuiSpacer ());
            jCPLabel = NuiRow(jCPLabel);
        } jCPannel = JsonArrayInsert(jCPannel, jCPLabel);
        jCPannel = JsonArrayInsert(jCPannel, NuiHeight(NuiSpacer(), 10.0f));

        //2.5 Create and add character description edit box
        json jCDEditBox = JsonArray();
        {
            jCDEditBox = CreateTextEditBox (jCDEditBox , "desc_Placeholder", "desc_value",
                              1000, TRUE, 280.0, 160.0, "desc_tooltip");
            jCDEditBox = NuiRow(jCDEditBox);
        } jCPannel = JsonArrayInsert(jCPannel, jCDEditBox);


        //2.6. Create and add save button
        json jCMrk2 = NuiImage(
                    JsonString("nui_cmark_w01"),
                    JsonInt(NUI_ASPECT_FIT),
                    JsonInt(NUI_HALIGN_CENTER),
                    JsonInt(NUI_VALIGN_MIDDLE));

                jCMrk2 = NuiId(jCMrk2, "nui_cmark_w01");
                jCMrk2 = NuiWidth(jCMrk2, 42.0f);
                jCMrk2 = NuiHeight(jCMrk2, 40.0f);

        json jSaveButton = JsonArray();
        {
            jSaveButton = JsonArrayInsert (jSaveButton, NuiSpacer ());
            jSaveButton = JsonArrayInsert(jSaveButton, jCMrk2);
            //jSaveButton = CreateButton (jSaveButton, "", "btn_desc_save", 42.0f, 40.0); // <---
            //jSaveButton = JsonArrayInsert (jSaveButton, NuiSpacer ());
            jSaveButton = NuiRow(jSaveButton);
        } jCPannel = JsonArrayInsert(jCPannel, jSaveButton);


        //Button Edge Spacer
        jCPannel = JsonArrayInsert(jCPannel, NuiHeight(NuiSpacer(), 70.0f));

        //2.x Transforming jCPanel into a NUI Layout (NuiCol = NuiColumn).
        jCPannel = NuiCol(jCPannel);
    } jCol = JsonArrayInsert(jCol, jCPannel);
    json jRoot = NuiRow(jCol);


    //APPS COLUMN 3
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 140.0f));


    //APPS COLUMN 4
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 166.0f));


    //APPS COLUMN 5
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 140.0f));


    //SCREEN BORDER RIGHT
    jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 160.0f));
    //jCol = JsonArrayInsert(jCol, NuiSpacer());
    jRoot = NuiRow(jCol);


    // This is the main window with jRoot as the main pane.  It includes titles and parameters (more on those later)
    json nui = NuiWindow(jRoot, JsonString(""), NuiBind("geometry"),
    NuiBind("resizable"), NuiBind("collapsed"), NuiBind("closable"), NuiBind("transparent"), NuiBind("border"));

    // finally create it and it'll return us a non-zero token.
    int nToken = NuiCreate(oPlayer, nui, NUI_TABLET_WINDOW3);

    // This are binds, which are like varaiables to NUI elements that can be changed latter.  Or in this case, changed now.
    NuiSetBind(oPlayer, nToken, "geometry", NuiRect(-1.0f, -1.0f, 1014.0f, 762.0f));    //1004.0f, 718.0f
    NuiSetBind(oPlayer, nToken, "collapsed", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "resizable", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "closable", JsonBool(TRUE));
    NuiSetBind(oPlayer, nToken, "transparent", JsonBool(TRUE));
    NuiSetBind(oPlayer, nToken, "border", JsonBool(FALSE));



     // ---------------------------------
    // BINDS FOR MY PLACE APP (WINDOW 3)
    // ---------------------------------

        // Get the players portrait resref so we can display the portrait.
        int nID = GetPortraitId (oPlayer);
        string sID;
        string sResRef = GetPortraitResRef (oPlayer);

    // If the Id is 65535 then it is a custom portrait so lets show that.
    if (nID == PORTRAIT_INVALID)
        sID = "Custom Portrait";
    else
        sID = IntToString (nID);

    // Set the portrait name to be watch in e_window_pc so we can update an
    NuiSetBind (oPlayer, nToken, "port_name", JsonString (sResRef));
    NuiSetBind (oPlayer, nToken, "port_id", JsonString (sID));
    NuiSetBind (oPlayer, nToken, "port_resref", JsonString (sResRef + "l"));

    // Add a tool tip so the player knows they can enter a custom portrait.
    NuiSetBind (oPlayer, nToken, "port_tooltip", JsonString ("You may also type the portrait file name."));

    // Set the buttons to show events to 0e_window_pc.
    NuiSetBind (oPlayer, nToken, "nui_arw_l_b01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "nui_arw_r_b01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "nui_cmark_w01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "nui_cmark_b01", JsonBool (TRUE));
    NuiSetBind (oPlayer, nToken, "desc_tooltip", JsonString ("Use enter to keep text within the box and you can use color codes!"));
    NuiSetBind (oPlayer, nToken, "description_label", JsonString (GetName (oPlayer) + "'s Description"));

    // Get the players description and put it into the description edit box.
    string sDescription = GetDescription (oPlayer);
    NuiSetBind (oPlayer, nToken, "desc_value", JsonString (sDescription));
    // custom portrait entered.
    NuiSetBindWatch (oPlayer, nToken, "port_name", TRUE);
    // This watch is needed to save the location of the window.
    NuiSetBindWatch (oPlayer, nToken, "window_geometry", TRUE);

}



void DestroyNuiTablet(object oPlayer)
{
    //before destruction, copying current window location position to player SQL
    //SQLocalsPlayer_SetFloat(oPlayer, "PC_TABLET_X_POS", fX);
    //SQLocalsPlayer_SetFloat(oPlayer, "PC_TABLET_Y_POS", fY);

    int nTabletMainToken = NuiFindWindow(oPlayer, NUI_TABLET_WINDOW);
    NuiDestroy(oPlayer, nTabletMainToken);

}
