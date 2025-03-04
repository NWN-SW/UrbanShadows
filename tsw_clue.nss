//:://////////////////////////////////////////////
//:: Created By: FD
//:: Created On: 06.06.2024
//:://////////////////////////////////////////////

#include "tsw_inc_nui"
#include "utl_i_sqlplayer"
#include "tsw_nui_clue"


void main()
{
    object oPC 		 = GetLastUsedBy();
    //Set SQL entries clue tag. This will allow different clues to target their respective nui windows.
    SetLocalString(oPC, "CLUE_NAME", GetLocalString(OBJECT_SELF,"sClueName"));



    // --------------------------------------
    // List of clues and their target windows
    // --------------------------------------
	
	//Filth Oasis: Legal Pad Clue
	if (GetLocalString(oPC,"CLUE_NAME") == "fo_clue01") {
		FO_Clue01_Window(oPC);
		return;
	}

	//Filth Oasis: Posted Note Clue
	if (GetLocalString(oPC,"CLUE_NAME") == "fo_clue02") {
		FO_Clue02_Window(oPC);
		return;
	}
	
	//Filth Oasis: Newspaper Clue
	if (GetLocalString(oPC,"CLUE_NAME") == "fo_clue03") {
		FO_Clue03_Window(oPC);
		return;
	}


	//DEBUG: Catch if clue tag does not correspond to list of clue windows
	else {
		SendMessageToPC(oPC, "DEBUG ERROR N12: NUI Clue Window Not Found!");
	}
		
	return;
}




