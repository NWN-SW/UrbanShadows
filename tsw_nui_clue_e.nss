#include "tsw_inc_nui"
#include "tsw_nui_clue"
#include "utl_i_sqlplayer"


void main()
{
    object oPC       = NuiGetEventPlayer();
    int nToken       = NuiGetEventWindow();
    string sEvent    = NuiGetEventType();
    string sElement  = NuiGetEventElement();
    int nIndex       = NuiGetEventArrayIndex();
    string sWindowId = NuiGetWindowId(oPC, nToken);

    //------------------------------------------------
    // FUNCTIONALITY FOR CLUE INTERFACE
    // -----------------------------------------------
    // NUI interactions are registered and directed
    // here via tracked through the tsw_mod_nui.nss
    // script.
    //---------------------------------------   ------

    // If not a mouseup event, nothing to do.
    if (sEvent != "mouseup")
    {
       return;
    }


    //Debug: NUI Event
    /*
        SendMessageToPC(oPC, "---------------------------------------");
        SendMessageToPC(oPC, "DM-4A: tsw_nui_keyp_ev.nss");
        SendMessageToPC(oPC, "---------------------------------------");
        SendMessageToPC(GetFirstPC(), "Receive an OnNuiEvent.");
        SendMessageToPC(GetFirstPC(), "Player: " + GetName(oPC));
        SendMessageToPC(GetFirstPC(), "nToken: " + IntToString(nToken));
        SendMessageToPC(GetFirstPC(), "sEvent: " + sEvent);
        SendMessageToPC(GetFirstPC(), "sElement: " + sElement);
        SendMessageToPC(GetFirstPC(), "nIndex: " + IntToString(nIndex));
        SendMessageToPC(GetFirstPC(), "sWindowId: " + sWindowId);
        SendMessageToPC(GetFirstPC(), "" + sWindowId);
    */


    //Every clue has its own window, and hence needs its own section for the button interactions.

    //Filth Oasis Clue 1 - Yellow Notepad with security codes
    if (NuiGetWindowId(oPC, nToken) == "fo_clue01_window") {
       string sClueImage;
	   string sClueText;


	   if (sElement == "clue_switch_btn1") {
            //SendMessageToPC(oPC, "Button 1 Pressed!");
            //SetLocalString(oPC, "CLUE_IMG", "img_fo_clue01"); //String Variable for Image
			sClueImage = "img_fo_clue01";
			sClueText = "";
			NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
			NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
        }

        else if (sElement == "clue_switch_btn2") {
            //SendMessageToPC(oPC, "Button 2 Pressed!");
			sClueImage = "img_fo_clue01b";
			sClueText = "Dr. Petrescu,\n\ndestroy this note as soon as your team has received the new security codes.\n\nLab A01: 9842\nLab A02: 7001\nSpecimen Cells (Individual): Original codes\nSpeciment Cells (Section) 5316\n\nDigsite D13 - Restricted to Dr. Khan's team\n\n- Akhan";
			NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
			NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
        }
	
	
		return;
    }

	if (NuiGetWindowId(oPC, nToken) == "fo_clue02_window") {
       string sClueImage;
	   string sClueText;


	   if (sElement == "clue_switch_btn1") {
            //SendMessageToPC(oPC, "Button 1 Pressed!");
            //SetLocalString(oPC, "CLUE_IMG", "img_fo_clue01"); //String Variable for Image
			sClueImage = "img_fo_clue02";
			sClueText = "";
			NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
			NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
        }

        else if (sElement == "clue_switch_btn2") {
            //SendMessageToPC(oPC, "Button 2 Pressed!");
			sClueImage = "img_fo_clue02b";
			sClueText = "9842\nShred this as soon as you manage to finally remember the damn code.";
			NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
			NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
        }
	
	
		return;
    }
	
	
	if (NuiGetWindowId(oPC, nToken) == "fo_clue03_window") {
       string sClueImage;
	   string sClueText;


	   if (sElement == "clue_switch_btn1") {
            //SendMessageToPC(oPC, "Button 1 Pressed!");
			sClueImage = "img_fo_clue03";
			sClueText = "";
			NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
			NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
        }

        else if (sElement == "clue_switch_btn2") {
            //SendMessageToPC(oPC, "Button 2 Pressed!");
			sClueImage = "img_fo_clue03b";
			sClueText = "DISAPPEARANCE OF FOREIGN WORKER LEADS TO INQUIRY\nby Gazette Staff\n\nAn official inquiry begins to take shape as the New Valley administration faces accusations of police incompetence. This comes after last week's disappearance of a British national in the village of Anum.\n\nThe original incident report states that the foreign national, an employee of TerraTech Inc. by the name of Dr. Anwar Khan, disappeared from police custody following his arrest on Tuesday evening. Dr. Khan had been detained in the aftermath of an altercation between him and three patrons of the Palmyra shisha bar located in the same.\n\nHowever, conflicting witness reports have arisen. Several claim that the arriving pair of police officers had failed to subdue the belligerent and likely intoxicated stranger. They further claim that the situation quickly escalated, that the officers resorted to the use of force, and that they fired multiple shots at Dr. Khan before detaining him.\n\nThe local police precinct has been scant in issuing any information regarding the incident. Several of Dr. Khan's colleagues have inquired after his whereabouts, yet these have been either dismissed or detained under suspicion of harbouring the fugitive, as was the case for Ms. Fearn. By Monday this week their voices had been joined by an official inquiry by the British Embassy in Cairo. Speaking on behalf of the Egyptian Government, Colonel El Misri has confirmed that in the coming days a full audit into the situation will take place at government level, as well as confirming that a search for a missing person is currently underway.\n\nThis incident has intensified the region-wide discussion of the role of police in the community. Critics have brought up last year's incident where a police officer failed to pay attention while driving along a usually-empty road at night, and subsequently lost his life after crashing into a date truck.";
			
			NuiSetBind (oPC, nToken, "displayed_clue", JsonString (sClueImage));
			NuiSetBind (oPC, nToken, "sClueText", JsonString (sClueText));
        }
	
	
		return;
    }



    return;

}




