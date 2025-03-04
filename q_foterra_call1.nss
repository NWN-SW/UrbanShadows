//:: This script opens a dialogue window with a nearby invisible placable.
//:: This is used in the following quest:
//:: SQL Name: Q_FOTERRA1
//:: Journal Name: Q_FOTerra1

//includes for nui clue window
#include "tsw_inc_nui"
#include "utl_i_sqlplayer"
#include "tsw_nui_clue"


void main()
{

    //-------------------------
    // Clue Functionality
    //-------------------------

    object oPC = GetLastUsedBy();
    //Set SQL entries clue tag. This will allow different clues to target their respective nui windows.
    SetLocalString(oPC, "CLUE_NAME", GetLocalString(OBJECT_SELF,"sClueName"));


    //Filth Oasis: Newspaper Clue
    if (GetLocalString(oPC,"CLUE_NAME") == "fo_clue03") {
        FO_Clue03_Window(oPC);
        //return;
    }



    //-------------------------
    // Phone Call Functionality
    //-------------------------

    //DebugMessage
    //SendMessageToPC(GetFirstPC(), "Debug Message");

    // Getting the area tag
    string sAreaTag = GetTag(GetArea(OBJECT_SELF));

    // Declare a variable for the conversation ResRef
    string sConvo;
    //object oPhone;
    //object oPC = GetLastUsedBy();

    // Assign the right conversation by area
    if (sAreaTag == "OS_Egypt2BuriedRuins") {
        sConvo = "conv_q_foterra_1";
        AssignCommand(oPC, ActionStartConversation(oPC, sConvo, TRUE, FALSE));
        //BeginConversation(sConvo, oPC);
        //oPhone = GetObjectByTag("CellPh_CoV", 0);
    }

    // Start the appropriate conversation between the target placable object and the player character.
    //AssignCommand(oPC, ActionStartConversation(oPhone, sConvo, TRUE, FALSE));

}

