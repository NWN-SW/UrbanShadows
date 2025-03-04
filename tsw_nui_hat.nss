#include "tsw_inc_nui"
#include "tsw_inc_nui_insp"

const string NUI_HAT_WINDOW = "nui_hat_window";

const string NUI_HAT_DDMENU_ID = "NUI_HAT_DDMENU_ID";
const string NUI_HAT_DDMENU_SELECTION = "NUI_HAT_DDMENU_SELECTION";
const string NUI_HAT_DDMENU_ELEMENTS = "NUI_HAT_DDMENU_ELEMENTS";

const string NUI_HAT_SLIDER_MIN = "NUI_HAT_SLIDER_MIN";
const string NUI_HAT_SLIDER_MAX = "NUI_HAT_SLIDER_MAX";
const string NUI_HAT_SLIDER_INCR = "NUI_HAT_SLIDER_INCR";

//string sFloatIncValue;
string sFloatIncValue;



void Nui_Hat_Window(object oPlayer){

        int nPreviousToken = NuiFindWindow(oPlayer, NUI_HAT_WINDOW);
        if (nPreviousToken != 0)
        {
                NuiDestroy(oPlayer, nPreviousToken);
        }

        json jCol = JsonArray();
        json jRow = JsonArray();


    //ROW SPACER
    jRow = JsonArray(); {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 10.0f));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //BUTTONS ROW 1
    jRow = JsonArray(); {    //<--
        json jN1 = NuiImage(
            JsonString("tsw_nui_kp_b01"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_LEFT),
            JsonInt(NUI_VALIGN_MIDDLE));
        json jN2 = NuiImage(
            JsonString("tsw_nui_kp_b02"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_LEFT),
            JsonInt(NUI_VALIGN_MIDDLE));

        jN1 = NuiId(jN1, "nui_keypad01_1");
        jN1 = NuiWidth(jN1, 30.0f);
        jN1 = NuiHeight(jN1, 30.0f);
        jN2 = NuiId(jN2, "nui_keypad01_2");
        jN2 = NuiWidth(jN2, 30.0f);
        jN2 = NuiHeight(jN2, 30.0f);

        jRow = JsonArrayInsert(jRow, NuiWidth(NuiSpacer(), 5.0f));
        jRow = JsonArrayInsert(jRow, jN1);
        jRow = JsonArrayInsert(jRow, jN2);
        jRow = JsonArrayInsert(jRow, NuiSpacer());
        jRow = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow);


    //ROW SPACER
    jRow = JsonArray(); {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 10.0f));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //LIST FOR DROPDOWN MENU IN FOLLOWING ROW
    json jEntries    = JsonArray();
        jEntries     = JsonArrayInsert(jEntries, NuiComboEntry("Select", 0));
        jEntries     = JsonArrayInsert(jEntries, NuiComboEntry("Move",  1));
        jEntries     = JsonArrayInsert(jEntries, NuiComboEntry("Raise", 2));
        jEntries     = JsonArrayInsert(jEntries, NuiComboEntry("Tilt", 3));
        jEntries     = JsonArrayInsert(jEntries, NuiComboEntry("Turn", 4));
		jEntries     = JsonArrayInsert(jEntries, NuiComboEntry("Scale", 5));

    //ROW 3: ADJUSTMENT TYPE SELECTION
    jRow = JsonArray(); {
        json jHatDropDownMenu = JsonArray();
        {
            json jHatDropDownList = NuiCombo(NuiBind(NUI_HAT_DDMENU_ELEMENTS), NuiBind(NUI_HAT_DDMENU_SELECTION));
                 jHatDropDownList = NuiId(jHatDropDownList, NUI_HAT_DDMENU_ID);
                 jHatDropDownList = NuiWidth(jHatDropDownList, 150.0);
                 jHatDropDownList = NuiHeight(jHatDropDownList, 30.0);
                 jHatDropDownMenu = JsonArrayInsert(jHatDropDownMenu, jHatDropDownList);
        }
        jRow = JsonArrayInsert(jRow, NuiRow(jHatDropDownMenu));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //ROW SPACER
    jRow = JsonArray(); {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 2.0f));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //BUTTONS ROW 1
    jRow = JsonArray(); {    //<--
        json jN3 = NuiImage(
            JsonString("tsw_nui_kp_b03"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jN3 = NuiId(jN3, "nui_keypad01_3");
        jN3 = NuiWidth(jN3, 30.0f);
        jN3 = NuiHeight(jN3, 30.0f);

        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jN3);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow); //<--


    //ROW SPACER
    jRow = JsonArray(); {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 1.0f));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


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

        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jN4);
        jRow      = JsonArrayInsert(jRow, jN5);
        jRow      = JsonArrayInsert(jRow, jN6);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow); //<--


    //ROW SPACER
    jRow = JsonArray(); {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 1.0f));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //BUTTONS ROW 3
    jRow = JsonArray(); {    //<--
        json jN7 = NuiImage(
            JsonString("tsw_nui_kp_b07"),
            JsonInt(NUI_ASPECT_FIT),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jN7 = NuiId(jN7, "nui_keypad01_7");
        jN7 = NuiWidth(jN7, 30.0f);
        jN7 = NuiHeight(jN7, 30.0f);

        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jN7);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow);


    //ROW SPACER
    jRow = JsonArray(); {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 5.0f));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //Row Slider
    jRow = JsonArray(); {

        json HatSlider = NuiSlider(
        NuiBind("NUI_HAT_SLIDER"),
        JsonInt(1),
        JsonInt(50),
        JsonInt(1));

        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, HatSlider);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);
    } jCol = JsonArrayInsert(jCol, jRow);


    jRow = JsonArray(); {

        json jLabelSliderVal = NuiLabel(NuiBind("NUI_HAT_SLIDER_LABEL"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));
        //json jLabelSliderVal = NuiLabel(JsonString ("TEST"), JsonInt(NUI_HALIGN_CENTER), JsonInt(NUI_VALIGN_TOP));
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = JsonArrayInsert(jRow, jLabelSliderVal);
        jRow      = JsonArrayInsert(jRow, NuiSpacer());
        jRow      = NuiRow(jRow);

    } jCol = JsonArrayInsert(jCol, jRow);


    //ROW SPACER
    jRow = JsonArray(); {
        jRow = JsonArrayInsert(jRow, NuiHeight(NuiSpacer(), 12.0f));
    } jCol = JsonArrayInsert(jCol, NuiRow(jRow));


    //ROOT
    json jRoot = NuiCol(jCol);
    json nui = NuiWindow(
        jRoot, JsonString("hVFX & gVFX"),
        NuiBind("geometry"),
        NuiBind("resizable"),
        NuiBind("collapsed"),
        NuiBind("closable"),
        NuiBind("transparent"),
        NuiBind("border"));

    int nToken = NuiCreate(oPlayer, nui, NUI_HAT_WINDOW);

    NuiSetBind(oPlayer, nToken, "geometry", NuiRect(-1.0f, -1.0f, 185.0f, 380.0f));   //220.0f, 310.0f
    NuiSetBind(oPlayer, nToken, "collapsed", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "resizable", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "closable", JsonBool(TRUE));
    NuiSetBind(oPlayer, nToken, "transparent", JsonBool(FALSE));
    NuiSetBind(oPlayer, nToken, "border", JsonBool(TRUE));

    NuiSetBind(oPlayer, nToken, NUI_HAT_DDMENU_ELEMENTS, jEntries);
    NuiSetBind(oPlayer, nToken, NUI_HAT_DDMENU_SELECTION, JsonInt(0));

	NuiSetBindWatch(oPlayer, nToken, "NUI_HAT_DDMENU_SELECTION", TRUE);
    NuiSetBindWatch(oPlayer, nToken, "NUI_HAT_SLIDER", TRUE);

    string sFloatIncValue = GetLocalString(oPlayer, "nui_hat_adjustment_string");
    NuiSetBind(oPlayer, nToken, "NUI_HAT_SLIDER_LABEL", JsonString(sFloatIncValue));







}
