#include "tsw_inc_nui"
#include "tsw_inc_nui_insp"

const string NUI_KEYPAD_WINDOW = "nui_keypad_window";


void Nui_Keypad_Window(object oPlayer){

        int nPreviousToken = NuiFindWindow(oPlayer, NUI_KEYPAD_WINDOW);
        if (nPreviousToken != 0)
        {
                NuiDestroy(oPlayer, nPreviousToken);
        }

        json jCol = JsonArray();
        json jRow = JsonArray();

        {  //background image block start
            json jSpacer = NuiSpacer();

            json jDrawImage = NuiDrawListImage(
                JsonBool(TRUE),
                JsonString("tsw_nui_kp_bck"),
                NuiRect(0.0, 0.0, 160.0, 230.0),//220.0f, 310.0f
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

    //jCol = JsonArrayInsert(jCol, NuiHeight(NuiSpacer(), 1.0f));

    //key combo text label
    jRow = JsonArray(); {    //<--
    json Keypad_c_01 = NuiLabel(NuiBind("nui_KeyCombo01_count"), JsonInt(NUI_HALIGN_RIGHT), JsonInt(NUI_VALIGN_MIDDLE));
    jRow  = JsonArrayInsert(jRow, Keypad_c_01);  // Add it to row
    jRow = JsonArrayInsert(jRow, NuiWidth(NuiSpacer(), 20.0f));
    jRow  = NuiRow(jRow);                  // Transform row into a Nui Layout.
    } jCol = JsonArrayInsert(jCol, jRow);

    jCol = JsonArrayInsert(jCol, NuiSpacer());

    //BUTTONS ROW 1
    jRow = JsonArray(); {    //<--
        json jN1 = NuiImage(
            JsonString("tsw_nui_kp_b01"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN2 = NuiImage(
            JsonString("tsw_nui_kp_b02"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN3 = NuiImage(
            JsonString("tsw_nui_kp_b03"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        //json jN1 = NuiId(NuiImage(jN1),
        jN1 = NuiId(jN1, "nui_keypad01_1");
        jN1 = NuiWidth(jN1, 30.0f);
        jN1 = NuiHeight(jN1, 30.0f);
        jN2 = NuiId(jN2, "nui_keypad01_2");
        jN2 = NuiWidth(jN2, 30.0f);
        jN2 = NuiHeight(jN2, 30.0f);
        jN3 = NuiId(jN3, "nui_keypad01_3");
        jN3 = NuiWidth(jN3, 30.0f);
        jN3 = NuiHeight(jN3, 30.0f);

        jRow = JsonArray();
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jN1);
        jRow      = JsonArrayInsert(jRow, jN2);
        jRow      = JsonArrayInsert(jRow, jN3);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow); //<--

    //BUTTONS ROW 2
    jRow = JsonArray(); {    //<--
        json jN4 = NuiImage(
            JsonString("tsw_nui_kp_b04"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN5 = NuiImage(
            JsonString("tsw_nui_kp_b05"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN6 = NuiImage(
            JsonString("tsw_nui_kp_b06"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jN4 = NuiId(jN4, "nui_keypad01_4");
        jN4 = NuiWidth(jN4, 30.0f);
        jN4 = NuiHeight(jN4, 30.0f);
        jN5 = NuiId(jN5, "nui_keypad01_5");
        jN5 = NuiWidth(jN5, 30.0f);
        jN5 = NuiHeight(jN5, 30.0f);
        jN6 = NuiId(jN6, "nui_keypad01_6");
        jN6 = NuiWidth(jN6, 30.0f);
        jN6 = NuiHeight(jN6, 30.0f);

        jRow = JsonArray();
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jN4);
        jRow      = JsonArrayInsert(jRow, jN5);
        jRow      = JsonArrayInsert(jRow, jN6);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow); //<--

    //BUTTONS ROW 3
    jRow = JsonArray(); {    //<--
        json jN7 = NuiImage(
            JsonString("tsw_nui_kp_b07"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN8 = NuiImage(
            JsonString("tsw_nui_kp_b08"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN9 = NuiImage(
            JsonString("tsw_nui_kp_b09"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jN7 = NuiId(jN7, "nui_keypad01_7");
        jN7 = NuiWidth(jN7, 30.0f);
        jN7 = NuiHeight(jN7, 30.0f);
        jN8 = NuiId(jN8, "nui_keypad01_8");
        jN8 = NuiWidth(jN8, 30.0f);
        jN8 = NuiHeight(jN8, 30.0f);
        jN9 = NuiId(jN9, "nui_keypad01_9");
        jN9 = NuiWidth(jN9, 30.0f);
        jN9 = NuiHeight(jN9, 30.0f);

        jRow = JsonArray();
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jN7);
        jRow      = JsonArrayInsert(jRow, jN8);
        jRow      = JsonArrayInsert(jRow, jN9);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow); //<--

    //BUTTONS ROW 4
    jRow = JsonArray(); {    //<--
        json jNE = NuiImage(
            JsonString("tsw_nui_kp_be"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN0 = NuiImage(
            JsonString("tsw_nui_kp_b00"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jNOK = NuiImage(
            JsonString("tsw_nui_kp_bc"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jNE = NuiId(jNE, "nui_keypad01_erase");
        jNE = NuiWidth(jNE,
30.0f);
        jNE = NuiHeight(jNE,
30.0f);
        jN0 = NuiId(jN0, "nui_keypad01_0");
        jN0 = NuiWidth(jN0, 30.0f);
        jN0 = NuiHeight(jN0, 30.0f);
        jNOK = NuiId(jNOK, "nui_keypad01_OK");
        jNOK = NuiWidth(jNOK, 30.0f);
        jNOK = NuiHeight(jNOK, 30.0f);

        jRow = JsonArray();
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jNE);
        jRow      = JsonArrayInsert(jRow, jN0);
        jRow      = JsonArrayInsert(jRow, jNOK);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow); //<--


        jCol = JsonArrayInsert(jCol, NuiHeight(NuiSpacer(), 15.0f));

        //jRoot = NuiCol(jRoot);  // Transform entire root pane to an element.
        json jRoot = NuiCol(jCol);   //<--
        json nui = NuiWindow(
            jRoot, JsonString("Keypad"),
            NuiBind("geometry"),
            NuiBind("resizable"),
            NuiBind("collapsed"),
            NuiBind("closable"),
            NuiBind("transparent"),
            NuiBind("border"));

        int nToken = NuiCreate(oPlayer, nui, NUI_KEYPAD_WINDOW);
        NuiSetBind(oPlayer, nToken, "geometry", NuiRect(-1.0f, -1.0f, 170.0f, 270.0f));   //220.0f, 310.0f
        NuiSetBind(oPlayer, nToken, "collapsed", JsonBool(FALSE));
        NuiSetBind(oPlayer, nToken, "resizable", JsonBool(FALSE));
        NuiSetBind(oPlayer, nToken, "closable", JsonBool(TRUE));
        NuiSetBind(oPlayer, nToken, "transparent", JsonBool(TRUE));
        NuiSetBind(oPlayer, nToken, "border", JsonBool(FALSE));

        //key combo text label
        string nKeyCombo = GetLocalString(oPlayer, "nui_KeyCombo01");
        NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));

        int nCount = GetLocalInt(oPlayer, "nui_tut_button_clicks");
        NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("# of Digits Entered: " + IntToString(nCount)));
}
