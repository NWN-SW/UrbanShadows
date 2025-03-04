#include "tsw_inc_nui"
#include "tsw_inc_nui_insp"

const float WINDOW_X = -1.0;
const float WINDOW_Y = -1.0;
float WINDOW_WIDTH;
float WINDOW_HEIGHT;
float IMAGE_WIDTH;
float IMAGE_HEIGHT;

const string FO_ClUE01_WINDOW  = "fo_clue01_window";
const string FO_ClUE02_WINDOW  = "fo_clue02_window";
const string FO_ClUE03_WINDOW  = "fo_clue03_window";


void FO_Clue01_Window(object oPC) {

	IMAGE_WIDTH = 600.0f;
    IMAGE_HEIGHT = 730.0f;
    WINDOW_WIDTH = 600.0f;
    WINDOW_HEIGHT = 780.0f;

	// First we look for any previous windows, if found (ie, non-zero) we destory them so we can start fresh.
    int nPreviousToken = NuiFindWindow(oPC, FO_ClUE01_WINDOW);
    if (nPreviousToken != 0)
    {
        NuiDestroy(oPC, nPreviousToken);
    }
	
    json jCol = JsonArray(); 
    json jBackground = JsonArray(); 
	{ //Background
       json jSpacer = NuiSpacer();

       json jDrawImage = NuiDrawListImage(
           JsonBool(TRUE),
           NuiBind("displayed_clue"),
           NuiRect(0.0, 0.0,  IMAGE_WIDTH, IMAGE_HEIGHT),
           JsonInt(NUI_ASPECT_EXACTSCALED),
           JsonInt(NUI_HALIGN_CENTER),
           JsonInt(NUI_VALIGN_MIDDLE),
           NUI_DRAW_LIST_ITEM_ORDER_BEFORE,
           NUI_DRAW_LIST_ITEM_RENDER_ALWAYS);

		
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);     
          jDrawImage = JsonArrayInsert(JsonArray(), jDrawImage);
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);
          jBackground = JsonArrayInsert(jBackground, jSpacer);		  
    } jCol = JsonArrayInsert(jCol, NuiRow(jBackground));
	
	//SCREEN BORDER LEFT
    //jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 85.0f));


	json jColText = JsonArray(); {			
		json tClueDescription = NuiText( NuiBind("sClueText"), FALSE, NUI_SCROLLBARS_NONE);	
		jColText = JsonArrayInsert(jColText, NuiHeight(NuiSpacer(), 60.0f));
		jColText = JsonArrayInsert(jColText, tClueDescription);
		jColText = JsonArrayInsert(jColText, NuiWidth(NuiSpacer(), 480.0f));
		jColText = NuiCol(jColText);	
	} jCol = JsonArrayInsert(jCol, jColText);
	json jRoot = NuiRow(jCol);



	json jColButtons = JsonArray(); {
	   
	   //Image Button
            
			json jBIMG1 = NuiImage(
                JsonString("nui_clue_b_img"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));
            //Text Button
            json jBIMG2 = NuiImage(
                JsonString("nui_clue_b_txt"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));
				
		jBIMG1 = NuiId(jBIMG1, "clue_switch_btn1");
            jBIMG1 = NuiWidth(jBIMG1, 30.0f);
            jBIMG1 = NuiHeight(jBIMG1, 30.0f);
            jBIMG2 = NuiId(jBIMG2, "clue_switch_btn2");
            jBIMG2 = NuiWidth(jBIMG2, 30.0f);
            jBIMG2 = NuiHeight(jBIMG2, 30.0f);
	   
	    jColButtons = JsonArray();
            jColButtons = JsonArrayInsert(jColButtons, NuiHeight(NuiSpacer(), 60.0f));
            jColButtons = JsonArrayInsert(jColButtons, jBIMG1);
            jColButtons = JsonArrayInsert(jColButtons, jBIMG2);
			jColButtons = JsonArrayInsert(jColButtons, NuiWidth(NuiSpacer(), 60.0f));
			jColButtons = JsonArrayInsert(jColButtons, NuiHeight(NuiSpacer(), (WINDOW_HEIGHT - 190.0f)));
            //jColButtons = JsonArrayInsert(jColButtons, NuiSpacer());
            jColButtons = NuiCol(jColButtons);
	} jCol = JsonArrayInsert(jCol, jColButtons); 
    jRoot = NuiRow(jCol);
	
   
	
	// This is the main window with jRoot as the main pane.  It includes titles and parameters (more on those later)
    json nui = NuiWindow(jRoot, JsonString(""), 
	NuiBind("geometry"), 
	NuiBind("resizable"), 
	NuiBind("collapsed"), 
	NuiBind("closable"), 
	NuiBind("transparent"), 
	NuiBind("border"));

    // finally create it and it'll return us a non-zero token.
    int nToken = NuiCreate(oPC, nui, FO_ClUE01_WINDOW);

    // This are binds, which are like varaiables to NUI elements that can be changed latter.  Or in this case, changed now.
    NuiSetBind(oPC, nToken, "geometry", NuiRect(-1.0f, -1.0f, WINDOW_WIDTH + 10.0f, WINDOW_HEIGHT + 10.0f)); 
    NuiSetBind(oPC, nToken, "collapsed", JsonBool(FALSE));
    NuiSetBind(oPC, nToken, "resizable", JsonBool(FALSE));
    NuiSetBind(oPC, nToken, "closable", JsonBool(TRUE));
    NuiSetBind(oPC, nToken, "transparent", JsonBool(TRUE));
    NuiSetBind(oPC, nToken, "border", JsonBool(FALSE));

	

	
	//------------------------------------------------------------------------------
	// ELEMENT BINDS SECTION
	// Binds are used so these elements can be updated at runtime, and not be static.
	//-------------------------------------------------------------------------------
    string sClueImage = "";
    if (sClueImage != "img_fo_clue01" && sClueImage != "img_fo_clue01b") {
        sClueImage = "img_fo_clue01";
    }
		
    NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
	NuiSetBindWatch (oPC, nToken, "displayed_clue", TRUE);
	
	string sClueText = "";
	
	NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
	NuiSetBindWatch (oPC, nToken, "sClueText", TRUE);

}



void FO_Clue02_Window(object oPC) {

	IMAGE_WIDTH = 500.0f;
    IMAGE_HEIGHT = 426.0f;
    WINDOW_WIDTH = 506.0f;
    WINDOW_HEIGHT = 456.0f;

	// First we look for any previous windows, if found (ie, non-zero) we destory them so we can start fresh.
    int nPreviousToken = NuiFindWindow(oPC, FO_ClUE02_WINDOW);
    if (nPreviousToken != 0)
    {
        NuiDestroy(oPC, nPreviousToken);
    }

    json jCol = JsonArray(); 
    json jBackground = JsonArray(); 
	{ //Background
       json jSpacer = NuiSpacer();

       json jDrawImage = NuiDrawListImage(
           JsonBool(TRUE),
           NuiBind("displayed_clue"),
           NuiRect(0.0, 0.0,  IMAGE_WIDTH, IMAGE_HEIGHT),
           JsonInt(NUI_ASPECT_EXACTSCALED),
           JsonInt(NUI_HALIGN_CENTER),
           JsonInt(NUI_VALIGN_MIDDLE),
           NUI_DRAW_LIST_ITEM_ORDER_BEFORE,
           NUI_DRAW_LIST_ITEM_RENDER_ALWAYS);

		
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);     
          jDrawImage = JsonArrayInsert(JsonArray(), jDrawImage);
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);
          jBackground = JsonArrayInsert(jBackground, jSpacer);		  
    } jCol = JsonArrayInsert(jCol, NuiRow(jBackground));
	
	//SCREEN BORDER LEFT
    //jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 85.0f));


	json jColText = JsonArray(); {			
		json tClueDescription = NuiText( NuiBind("sClueText"), FALSE, NUI_SCROLLBARS_NONE);	
		jColText = JsonArrayInsert(jColText, NuiHeight(NuiSpacer(), 60.0f));
		jColText = JsonArrayInsert(jColText, tClueDescription);
		jColText = JsonArrayInsert(jColText, NuiWidth(NuiSpacer(), 400.0f));
		jColText = NuiCol(jColText);	
	} jCol = JsonArrayInsert(jCol, jColText);
	json jRoot = NuiRow(jCol);



	json jColButtons = JsonArray(); {
	   
	   //Image Button
            
			json jBIMG1 = NuiImage(
                JsonString("nui_clue_b_img"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));
            //Text Button
            json jBIMG2 = NuiImage(
                JsonString("nui_clue_b_txt"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));
				
		jBIMG1 = NuiId(jBIMG1, "clue_switch_btn1");
            jBIMG1 = NuiWidth(jBIMG1, 30.0f);
            jBIMG1 = NuiHeight(jBIMG1, 30.0f);
            jBIMG2 = NuiId(jBIMG2, "clue_switch_btn2");
            jBIMG2 = NuiWidth(jBIMG2, 30.0f);
            jBIMG2 = NuiHeight(jBIMG2, 30.0f);
	   
	    jColButtons = JsonArray();
            jColButtons = JsonArrayInsert(jColButtons, NuiHeight(NuiSpacer(), 60.0f));
            jColButtons = JsonArrayInsert(jColButtons, jBIMG1);
            jColButtons = JsonArrayInsert(jColButtons, jBIMG2);
			jColButtons = JsonArrayInsert(jColButtons, NuiWidth(NuiSpacer(), 60.0f));
			jColButtons = JsonArrayInsert(jColButtons, NuiHeight(NuiSpacer(), (WINDOW_HEIGHT - 190.0f)));
            //jColButtons = JsonArrayInsert(jColButtons, NuiSpacer());
            jColButtons = NuiCol(jColButtons);
	} jCol = JsonArrayInsert(jCol, jColButtons); 
    jRoot = NuiRow(jCol);
	
   
	
	// This is the main window with jRoot as the main pane.  It includes titles and parameters (more on those later)
    json nui = NuiWindow(jRoot, JsonString(""), 
	NuiBind("geometry"), 
	NuiBind("resizable"), 
	NuiBind("collapsed"), 
	NuiBind("closable"), 
	NuiBind("transparent"), 
	NuiBind("border"));

    // finally create it and it'll return us a non-zero token.
    int nToken = NuiCreate(oPC, nui, FO_ClUE02_WINDOW);

    // This are binds, which are like varaiables to NUI elements that can be changed latter.  Or in this case, changed now.
    NuiSetBind(oPC, nToken, "geometry", NuiRect(-1.0f, -1.0f, WINDOW_WIDTH + 10.0f, WINDOW_HEIGHT + 10.0f)); 
    NuiSetBind(oPC, nToken, "collapsed", JsonBool(FALSE));
    NuiSetBind(oPC, nToken, "resizable", JsonBool(FALSE));
    NuiSetBind(oPC, nToken, "closable", JsonBool(TRUE));
    NuiSetBind(oPC, nToken, "transparent", JsonBool(TRUE));
    NuiSetBind(oPC, nToken, "border", JsonBool(FALSE));

	

	
	//------------------------------------------------------------------------------
	// ELEMENT BINDS SECTION
	// Binds are used so these elements can be updated at runtime, and not be static.
	//-------------------------------------------------------------------------------
    string sClueImage = "";
    if (sClueImage != "img_fo_clue02" && sClueImage != "img_fo_clue02b") {
        sClueImage = "img_fo_clue02";
    }
		
    NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
	NuiSetBindWatch (oPC, nToken, "displayed_clue", TRUE);
	
	string sClueText = "";
	
	NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
	NuiSetBindWatch (oPC, nToken, "sClueText", TRUE);

}

void FO_Clue03_Window(object oPC) {

	IMAGE_WIDTH = 616.0f;
    IMAGE_HEIGHT = 808.0f;
    WINDOW_WIDTH = 626.0f;
    WINDOW_HEIGHT = 868.0f;

	// First we look for any previous windows, if found (ie, non-zero) we destory them so we can start fresh.
    int nPreviousToken = NuiFindWindow(oPC, FO_ClUE03_WINDOW);
    if (nPreviousToken != 0)
    {
        NuiDestroy(oPC, nPreviousToken);
    }

    json jCol = JsonArray(); 
    json jBackground = JsonArray(); 
	{ //Background
       json jSpacer = NuiSpacer();

       json jDrawImage = NuiDrawListImage(
           JsonBool(TRUE),
           NuiBind("displayed_clue"),
           NuiRect(0.0, 0.0,  IMAGE_WIDTH, IMAGE_HEIGHT),
           JsonInt(NUI_ASPECT_EXACTSCALED),
           JsonInt(NUI_HALIGN_CENTER),
           JsonInt(NUI_VALIGN_MIDDLE),
           NUI_DRAW_LIST_ITEM_ORDER_BEFORE,
           NUI_DRAW_LIST_ITEM_RENDER_ALWAYS);

		
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);     
          jDrawImage = JsonArrayInsert(JsonArray(), jDrawImage);
          jSpacer = NuiDrawList(jSpacer, JsonBool(FALSE), jDrawImage);
          jBackground = JsonArrayInsert(jBackground, jSpacer);		  
    } jCol = JsonArrayInsert(jCol, NuiRow(jBackground));


	json jColText = JsonArray(); {			
		json tClueDescription = NuiText( NuiBind("sClueText"), FALSE, NUI_SCROLLBARS_NONE);	
		jColText = JsonArrayInsert(jColText, NuiHeight(NuiSpacer(), 20.0f));
		jColText = JsonArrayInsert(jColText, tClueDescription);
		jColText = JsonArrayInsert(jColText, NuiWidth(NuiSpacer(), 530.0f));
		//jColText = JsonArrayInsert(jColText, NuiHeight(NuiSpacer(), 20.0f));
		jColText = NuiCol(jColText);	
	} jCol = JsonArrayInsert(jCol, jColText);
	json jRoot = NuiRow(jCol);



	json jColButtons = JsonArray(); {
	   
	   //Image Button
            
			json jBIMG1 = NuiImage(
                JsonString("nui_clue_b_img"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));
            //Text Button
            json jBIMG2 = NuiImage(
                JsonString("nui_clue_b_txt"),
                JsonInt(NUI_ASPECT_FIT),
                JsonInt(NUI_HALIGN_CENTER),
                JsonInt(NUI_VALIGN_MIDDLE));
				
		jBIMG1 = NuiId(jBIMG1, "clue_switch_btn1");
            jBIMG1 = NuiWidth(jBIMG1, 30.0f);
            jBIMG1 = NuiHeight(jBIMG1, 30.0f);
            jBIMG2 = NuiId(jBIMG2, "clue_switch_btn2");
            jBIMG2 = NuiWidth(jBIMG2, 30.0f);
            jBIMG2 = NuiHeight(jBIMG2, 30.0f);
	   
	    jColButtons = JsonArray();
            jColButtons = JsonArrayInsert(jColButtons, NuiHeight(NuiSpacer(), 60.0f));
            jColButtons = JsonArrayInsert(jColButtons, jBIMG1);
            jColButtons = JsonArrayInsert(jColButtons, jBIMG2);
			jColButtons = JsonArrayInsert(jColButtons, NuiWidth(NuiSpacer(), 42.0f));
			jColButtons = JsonArrayInsert(jColButtons, NuiHeight(NuiSpacer(), (WINDOW_HEIGHT - 160.0f)));
            //jColButtons = JsonArrayInsert(jColButtons, NuiSpacer());
            jColButtons = NuiCol(jColButtons);
	} jCol = JsonArrayInsert(jCol, jColButtons); 
    jRoot = NuiRow(jCol);
	
   
	
	// This is the main window with jRoot as the main pane.  It includes titles and parameters (more on those later)
    json nui = NuiWindow(jRoot, JsonString(""), 
	NuiBind("geometry"), 
	NuiBind("resizable"), 
	NuiBind("collapsed"), 
	NuiBind("closable"), 
	NuiBind("transparent"), 
	NuiBind("border"));

    // finally create it and it'll return us a non-zero token.
    int nToken = NuiCreate(oPC, nui, FO_ClUE03_WINDOW);

    // This are binds, which are like varaiables to NUI elements that can be changed latter.  Or in this case, changed now.
    NuiSetBind(oPC, nToken, "geometry", NuiRect(-1.0f, -1.0f, WINDOW_WIDTH + 10.0f, WINDOW_HEIGHT + 10.0f)); 
    NuiSetBind(oPC, nToken, "collapsed", JsonBool(FALSE));
    NuiSetBind(oPC, nToken, "resizable", JsonBool(FALSE));
    NuiSetBind(oPC, nToken, "closable", JsonBool(TRUE));
    NuiSetBind(oPC, nToken, "transparent", JsonBool(TRUE));
    NuiSetBind(oPC, nToken, "border", JsonBool(FALSE));

	

	
	//------------------------------------------------------------------------------
	// ELEMENT BINDS SECTION
	// Binds are used so these elements can be updated at runtime, and not be static.
	//-------------------------------------------------------------------------------
    string sClueImage = "";
    if (sClueImage != "img_fo_clue03" && sClueImage != "img_fo_clue03b") {
        sClueImage = "img_fo_clue03";
    }
		
    NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
	NuiSetBindWatch (oPC, nToken, "displayed_clue", TRUE);
	
	string sClueText = "";
	
	NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
	NuiSetBindWatch (oPC, nToken, "sClueText", TRUE);

}