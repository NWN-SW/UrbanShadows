/////////////////////////////////////////////////////
// Resource NUI by CRYSTAL MAN
// Last edit: 26/07/2022
//
// to use: call DrawResourceBars() on client enter and
// either pass the entering PC as the parameter or assign
// the function to the pc's action queue with the parameter
// empty.
//
// UpdateBinds() must be called any time the resource values
// change, so that the change is reflected in the NUI. If
// it's not already the case, I recommend making a wrapper
// function to access these variables on PCs and call
// UpdateBinds() from there
//
// I have left the constants at values that I think work best
// for what your design document outlined. Both vertical and
// horizontally arranged resource bars are supported, as well
// as % based or specific readouts of the values on the tooltip.
// If you wish to change the colours, the variables are defined
// at the top of the definition of DrawResourceBars()
/////////////////////////////////////////////////////

#include "tsw_inc_nui"
#include "utl_i_sqlplayer"
#include "tsw_flask_charm"

// IMPORTANT: this script must be compiled for changes to constants to take effect:
// either by building the module with 'compile scripts' enabled, or by compiling a script that #includes this one

//const float NUI_RESOURCE_X = 960.0;//for easy tweaking, these values control the screen coordinates for the top-left corner of the resource bars window
//const float NUI_RESOURCE_Y = 950.0;

const float NUI_RESOURCE_HEIGHT = 25.0; //for easy tweaking, these values control the size of the resource bar widgets
const float NUI_RESOURCE_WIDTH = 150.0;

const int NUI_RESOURCE_VERTICAL_ALIGN = 1; //set this to 1 to have the bars in a column, set it to 0 to have the bars side-by-side
const int NUI_RESOURCE_TOOLTIP_PERCENTAGE = 0; //set this to 1 to have the tooltip display the percentage of available resource, instead of the explicit value

//draws the NUI window for oPC, or destroy & redraw it if it is already on-screen
void DrawResourceBars(object oPC = OBJECT_SELF);

//converts PC_ANIMA_CURRENT into a float between 0 and 1 based on PC_ANIMA_MAIN
float GetAnima(object oPC);

//converts PC_STAMINA_CURRENT  into a float between 0 and 1 based on PC_STAMINA_MAIN
float GetStamina(object oPC);

//updates the values drawn on screen, based on the PC_ANIMA_* and PC_STAMINA_* variables set on oPC
void UpdateBinds(object oPC = OBJECT_SELF);

// --------
// ORIGINAL
// --------
/*
void DrawResourceBars(object oPC = OBJECT_SELF)
{
    json jStaminaColour = NuiColor(184, 173, 143); // r, g, b, a=255
    json jAnimaColour = NuiColor(196, 157, 0);   //for easy tweaking

    //Coordinates
    float fPC_X = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_X_POS");
    float fPC_Y = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_Y_POS");
    if(fPC_X < 5.0 || fPC_Y < 5.0)
    {
        fPC_X = 80.0;
        fPC_Y = 1500.0;
    }

    json jRoot = JsonArray();
        json jProg = NuiProgress(NuiBind("cman_resources_anima"));
            jProg = NuiStyleForegroundColor(jProg, jAnimaColour);
            jProg = NuiTooltip(jProg, NuiBind("cman_resources_anima_tooltip"));
            jProg = NuiHeight(jProg, NUI_RESOURCE_HEIGHT);
            jProg = NuiWidth(jProg, NUI_RESOURCE_WIDTH);
        jRoot = JsonArrayInsert(jRoot, jProg);
        jProg = NuiProgress(NuiBind("cman_resources_stamina"));
            jProg = NuiStyleForegroundColor(jProg, jStaminaColour);
            jProg = NuiTooltip(jProg, NuiBind("cman_resources_stamina_tooltip"));
            jProg = NuiHeight(jProg, NUI_RESOURCE_HEIGHT);
            jProg = NuiWidth(jProg, NUI_RESOURCE_WIDTH);
        jRoot = JsonArrayInsert(jRoot, jProg);
    
	
	if(NUI_RESOURCE_VERTICAL_ALIGN)
    {
        jRoot = NuiCol(jRoot);
    }
    else
    {
        jRoot = NuiRow(jRoot);
    }
	
    json jRect = NuiRect(fPC_X - ((1.5 - NUI_RESOURCE_VERTICAL_ALIGN) * NUI_RESOURCE_WIDTH), fPC_Y, (NUI_RESOURCE_WIDTH * (2.0 - NUI_RESOURCE_VERTICAL_ALIGN)) + 15.0, (NUI_RESOURCE_HEIGHT * 2.0) + 15.0);
                                    //title                                 //collapse                      //transparent
    json jWind = NuiWindow(jRoot, JsonString(""), jRect, JsonBool(FALSE), JsonBool(FALSE), JsonBool(FALSE), JsonBool(FALSE), JsonBool(TRUE));
    int nToken = NuiCreate(oPC, jWind, "cman_resources");
    SetLocalInt(oPC, "PC_NUI_RESOURCE", nToken); //this is required for UpdateBinds. If you change this variable name, you must also change UpdateBinds
    UpdateBinds(oPC);
}
*/


void DrawResourceBars(object oPC = OBJECT_SELF)
{
    json jStaminaColour = NuiColor(184, 173, 143); // r, g, b, a=255
    json jAnimaColour = NuiColor(196, 157, 0);   //for easy tweaking
	json jCol = JsonArray();
	json jRow = JsonArray();

    //Coordinates
    float fPC_X = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_X_POS");
    float fPC_Y = SQLocalsPlayer_GetFloat(oPC, "PC_RESOURCE_Y_POS");
    
	if(fPC_X < 5.0 || fPC_Y < 5.0)
    {
        fPC_X = 80.0;
        fPC_Y = 1500.0;
    }
		
	//To Center Spacer, left Side
	jCol = JsonArray(); {
        jCol = JsonArrayInsert(jCol, NuiSpacer());;
    } jRow = JsonArrayInsert(jRow, NuiCol(jCol));
	
	
	//Flask Slot1 (1 Flask Buttons)
	jCol = JsonArray(); {
        json jFlaskSlot01 = NuiImage(
            JsonString("fcs_flask01"),
            JsonInt(NUI_ASPECT_FILL),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jFlaskSlot01 = NuiId(jFlaskSlot01, "b_flaskslot01");
        //jN3 = NuiHeight(jN3, 48.0f);
		//jN3 = NuiWidth(jN3, 36.0f);
        		
		jFlaskSlot01 = NuiGroup(jFlaskSlot01, TRUE, NUI_SCROLLBARS_NONE);
		jFlaskSlot01 = NuiHeight(jFlaskSlot01, 54.0f);
		jFlaskSlot01 = NuiWidth(jFlaskSlot01, 34.0f);
		//jN3 = NuiMargin(jN3, 2.0f);
		//jN3 = NuiTooltip(jN3,"TooltipBindHere");		

        jCol      = JsonArrayInsert(jCol, jFlaskSlot01);
        jCol      = NuiRow(jCol);
	} jRow = JsonArrayInsert(jRow, jCol);

	//Col SPACER
    /*
	jCol = JsonArray(); {
        jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 2.0f));
    } jRow = JsonArrayInsert(jRow, NuiCol(jCol));
	*/
	
	//Flask Slot2 (1 Flask Buttons)
	jCol = JsonArray(); {
        json jFlaskSlot02 = NuiImage(
            JsonString("fcs_flask02"),
            JsonInt(NUI_ASPECT_FILL),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jFlaskSlot02 = NuiId(jFlaskSlot02, "b_flaskslot01");   
        //jN3 = NuiHeight(jN3, 32.0f);
		//jN3 = NuiWidth(jN3, 16.0f);
		
		jFlaskSlot02 = NuiGroup(jFlaskSlot02, TRUE, NUI_SCROLLBARS_NONE);
		jFlaskSlot02 = NuiHeight(jFlaskSlot02, 54.0f);
		jFlaskSlot02 = NuiWidth(jFlaskSlot02, 34.0f);
		//jN3 = NuiMargin(jN3, 2.0f);
		//jN3 = NuiTooltip(jN3,"TooltipBindHere");	
		
        jCol      = JsonArrayInsert(jCol, jFlaskSlot02);
        jCol      = NuiRow(jCol);
	} jRow = JsonArrayInsert(jRow, jCol);	
	
	//Col SPACER
    jCol = JsonArray(); {
        jCol = JsonArrayInsert(jCol, NuiWidth(NuiSpacer(), 2.0f));
    } jRow = JsonArrayInsert(jRow, NuiCol(jCol));
	

	json jBarsCol = JsonArray(); {
		json jProg = NuiProgress(NuiBind("cman_resources_anima"));
			jProg = NuiStyleForegroundColor(jProg, jAnimaColour);
			jProg = NuiTooltip(jProg, NuiBind("cman_resources_anima_tooltip"));
			jProg = NuiHeight(jProg, NUI_RESOURCE_HEIGHT);
			jProg = NuiWidth(jProg, NUI_RESOURCE_WIDTH);
		jBarsCol = JsonArrayInsert(jBarsCol, jProg);
		jProg = NuiProgress(NuiBind("cman_resources_stamina"));
			jProg = NuiStyleForegroundColor(jProg, jStaminaColour);
			jProg = NuiTooltip(jProg, NuiBind("cman_resources_stamina_tooltip"));
			jProg = NuiHeight(jProg, NUI_RESOURCE_HEIGHT);
			jProg = NuiWidth(jProg, NUI_RESOURCE_WIDTH);
		jBarsCol = JsonArrayInsert(jBarsCol, jProg);
	} jRow = JsonArrayInsert(jRow, NuiCol(jBarsCol));
	
	
	//Charm Slots (3 Charm Icons)
	
	//CHARM SLOT 1
	jCol = JsonArray(); {
        json jCharmSlot01 = NuiImage(
            JsonString("fcs_charm01"),
            JsonInt(NUI_ASPECT_FILL),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jCharmSlot01 = NuiId(jCharmSlot01, "b_flaskslot01");
        //jN3 = NuiHeight(jN3, 48.0f);
		//jN3 = NuiWidth(jN3, 36.0f);
        		
		jCharmSlot01 = NuiGroup(jCharmSlot01, TRUE, NUI_SCROLLBARS_NONE);
		jCharmSlot01 = NuiHeight(jCharmSlot01, 54.0f);
		jCharmSlot01 = NuiWidth(jCharmSlot01, 34.0f);
		//jN3 = NuiMargin(jN3, 2.0f);
		//jN3 = NuiTooltip(jN3,"TooltipBindHere");		

        jCol      = JsonArrayInsert(jCol, jCharmSlot01);
        jCol      = NuiRow(jCol);
	} jRow = JsonArrayInsert(jRow, jCol);
	
	//CHARM SLOT 2 
	jCol = JsonArray(); {
        json jCharmSlot02 = NuiImage(
            JsonString("fcs_charm02"),
            JsonInt(NUI_ASPECT_FILL),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jCharmSlot02 = NuiId(jCharmSlot02, "b_flaskslot01");
        //jN3 = NuiHeight(jN3, 48.0f);
		//jN3 = NuiWidth(jN3, 36.0f);
        		
		jCharmSlot02 = NuiGroup(jCharmSlot02, TRUE, NUI_SCROLLBARS_NONE);
		jCharmSlot02 = NuiHeight(jCharmSlot02, 54.0f);
		jCharmSlot02 = NuiWidth(jCharmSlot02, 34.0f);
		//jN3 = NuiMargin(jN3, 2.0f);
		//jN3 = NuiTooltip(jN3,"TooltipBindHere");		

        jCol      = JsonArrayInsert(jCol, jCharmSlot02);
        jCol      = NuiRow(jCol);
	} jRow = JsonArrayInsert(jRow, jCol);
	
	//CHARM SLOT 3 
	jCol = JsonArray(); {
        json jCharmSlot03 = NuiImage(
            JsonString("fcs_charm03"),
            JsonInt(NUI_ASPECT_FILL),
            JsonInt(NUI_HALIGN_CENTER),
            JsonInt(NUI_VALIGN_MIDDLE));

        jCharmSlot03 = NuiId(jCharmSlot03, "b_flaskslot01");
        //jN3 = NuiHeight(jN3, 48.0f);
		//jN3 = NuiWidth(jN3, 36.0f);
        		
		jCharmSlot03 = NuiGroup(jCharmSlot03, TRUE, NUI_SCROLLBARS_NONE);
		jCharmSlot03 = NuiHeight(jCharmSlot03, 54.0f);
		jCharmSlot03 = NuiWidth(jCharmSlot03, 34.0f);
		//jN3 = NuiMargin(jN3, 2.0f);
		//jN3 = NuiTooltip(jN3,"TooltipBindHere");		

        jCol      = JsonArrayInsert(jCol, jCharmSlot03);
        jCol      = NuiRow(jCol);
	} jRow = JsonArrayInsert(jRow, jCol);
	
	
	//To Center Spacer, Right Side
	jCol = JsonArray(); {
        jCol = JsonArrayInsert(jCol, NuiSpacer());;
    } jRow = JsonArrayInsert(jRow, NuiCol(jCol));
	
	
	//Add it all together into jRoot
	json jRoot = NuiRow(jRow);	
	json jRect = NuiRect(800.0f, 850.0f, 405.0f, 80.0f);
	//json jRect = NuiRect(80.0, 1450.0, 165.0, 65.0);
    //json jRect = NuiRect(fPC_X - ((1.5 - NUI_RESOURCE_VERTICAL_ALIGN) * NUI_RESOURCE_WIDTH), fPC_Y, (NUI_RESOURCE_WIDTH * (2.0 - NUI_RESOURCE_VERTICAL_ALIGN)) + 15.0, (NUI_RESOURCE_HEIGHT * 2.0) + 15.0);
	
	json jWind = NuiWindow(jRoot, 
		JsonString(""), //title
		jRect, 
		JsonBool(FALSE), //resizable
		JsonBool(FALSE), //closable
		JsonBool(FALSE), //collapse
		JsonBool(FALSE), //transparent
		JsonBool(TRUE)); //border
    int nToken = NuiCreate(oPC, jWind, "cman_resources");
    SetLocalInt(oPC, "PC_NUI_RESOURCE", nToken); //this is required for UpdateBinds. If you change this variable name, you must also change UpdateBinds
    UpdateBinds(oPC);
}



float GetAnima(object oPC)
{
    int nMax = GetLocalInt(oPC, "PC_ANIMA_MAIN");
    int nCurrent = GetLocalInt(oPC, "PC_ANIMA_CURRENT");
    float f = 0.0;
    if(nMax && nCurrent) //this is to catch potential divide by zero errors
    {
        f = IntToFloat(nCurrent) / IntToFloat(nMax);
    }
    return f;
}

float GetStamina(object oPC)
{
    int nMax = GetLocalInt(oPC, "PC_STAMINA_MAIN");
    int nCurrent = GetLocalInt(oPC, "PC_STAMINA_CURRENT");
    float f = 0.0;
    if(nMax && nCurrent)
    {
        f = IntToFloat(nCurrent) / IntToFloat(nMax);
    }
    return f;
}

void UpdateBinds(object oPC = OBJECT_SELF)
{
    int nToken = GetLocalInt(oPC, "PC_NUI_RESOURCE");
    float fStamina = GetStamina(oPC);
    float fAnima = GetAnima(oPC);

    string sStamina, sAnima;
    if(NUI_RESOURCE_TOOLTIP_PERCENTAGE)
    {
        sStamina = "Stamina:" + FloatToString(fStamina * 100.0, 2, 0) + "%";
        sAnima = "Anima:" + FloatToString(fAnima * 100.0, 2, 0) + "%";
    }
    else
    {
        int nStam = GetLocalInt(oPC, "PC_STAMINA_CURRENT");
        int nStamMax = GetLocalInt(oPC, "PC_STAMINA_MAIN");
        sStamina = "Stamina: " + IntToString(nStam) + "/" + IntToString(nStamMax);
        nStam = GetLocalInt(oPC, "PC_ANIMA_CURRENT");
        nStamMax = GetLocalInt(oPC, "PC_ANIMA_MAIN");
        sAnima = "Anima: " + IntToString(nStam) + "/" + IntToString(nStamMax);
    }
	
	string sFlaskSlot01 = "abc";

    NuiSetBind(oPC, nToken, "cman_resources_anima", JsonFloat(fAnima));
    NuiSetBind(oPC, nToken, "cman_resources_stamina", JsonFloat(fStamina));
    NuiSetBind(oPC, nToken, "cman_resources_stamina_tooltip", JsonString(sStamina));
    NuiSetBind(oPC, nToken, "cman_resources_anima_tooltip", JsonString(sAnima));
	
	NuiSetBind(oPC, nToken, "b_flaskslot01", JsonString(sFlaskSlot01));
}
