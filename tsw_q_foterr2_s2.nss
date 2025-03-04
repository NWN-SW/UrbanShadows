//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//::
//:: Stage 2: Collecting Evidence From 4 Different Files
//:: NPC: Ana Catagena
//:: Location: Egypt Terra Tech Labs
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

void main()
{
    string sPlcTag = GetTag(OBJECT_SELF);
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");
    int nPlcCheck1 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE1");
    int nPlcCheck2 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE2");
    int nPlcCheck3 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE3");
    int nPlcCheck4 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE4");
    object oPC = GetPCSpeaker();

    if(nCheck == 1 || nCheck == 2)
    {

        //check if character is still at quest stage 1, if so move them to 2.
        if(nCheck == 1) {
            SQLocalsPlayer_SetInt(oPC, "Q_FOTERRA2", 2);
            AddJournalQuestEntry("Q_FOTerra2", 2, oPC, FALSE);
        }


        //Check to see if the player character already got the information from this PLC
        if(sPlcTag == "tsw_q_ttlab1" && nPlcCheck1 != 1) {
            //player is set to having received the information from this source
            SQLocalsPlayer_SetInt(oPC, "Q_TTECHLORE1", 1);
        }

        //Check for source 2
        else if(sPlcTag == "tsw_q_ttlab2" && nPlcCheck2 != 1) {
            //player is set to having received the information from this source
            SQLocalsPlayer_SetInt(oPC, "Q_TTECHLORE2", 1);
        }

        //Check for source 3
        else if(sPlcTag == "tsw_q_ttlab3" && nPlcCheck3 != 1) {
            //player is set to having received the information from this source
            SQLocalsPlayer_SetInt(oPC, "Q_TTECHLORE3", 1);
        }

        //Check for source 4
        else if(sPlcTag == "tsw_q_ttlab4" && nPlcCheck4 != 1) {
            //player is set to having received the information from this source
            SQLocalsPlayer_SetInt(oPC, "Q_TTECHLORE4", 1);
        }


        //if the character now has all lore sources, move them to the next quest stage.
        nPlcCheck1 = SQLocalsPlayer_GetInt(oPC, "Q_TTECHLORE1");
        nPlcCheck2 = SQLocalsPlayer_GetInt(oPC, "Q_TTECHLORE2");
        nPlcCheck3 = SQLocalsPlayer_GetInt(oPC, "Q_TTECHLORE3");
        nPlcCheck4 = SQLocalsPlayer_GetInt(oPC, "Q_TTECHLORE4");


        //determine how much of the evidence has been collected.
        int nEvidenceCheck = 0;
        if(nPlcCheck1 == 1) {
            nEvidenceCheck = nEvidenceCheck +1;
        }

        if(nPlcCheck2 == 1) {
            nEvidenceCheck = nEvidenceCheck +1;
        }

        if(nPlcCheck3 == 1) {
            nEvidenceCheck = nEvidenceCheck +1;
        }

        if(nPlcCheck4 == 1) {
            nEvidenceCheck = nEvidenceCheck +1;
        }


        //feedback message on the amount of evidence pieces you have collected.
        switch (nEvidenceCheck) {
            case 1: {
                SendMessageToPC(oPC, "You have collected 1 piece of evidence.");
                break;
            }
            case 2: {
                SendMessageToPC(oPC, "You have collected 2 pieces of evidence.");
                break;
            }
            case 3: {
                SendMessageToPC(oPC, "You have collected 3 pieces of evidence.");
                break;
            }
            case 4: {
                SendMessageToPC(oPC, "You have collected 4 pieces of evidence.");
                break;
            }
            default:
                break;
        }


        if(nPlcCheck1 == 1 && nPlcCheck2 == 1 && nPlcCheck3 == 1 && nPlcCheck4 == 1) {
            SQLocalsPlayer_SetInt(oPC, "Q_FOTERRA2", 3);
            AddJournalQuestEntry("Q_FOTerra2", 3, oPC, FALSE);
            SendMessageToPC(GetFirstPC(), "You have collected all of the sought evidence.");

            //pre-clean-up debug messages
        /*  nPlcCheck1 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE1");
            nPlcCheck2 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE2");
            nPlcCheck3 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE3");
            nPlcCheck4 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE4");
            if(nPlcCheck1 == 1 && nPlcCheck2 == 1 && nPlcCheck3 == 1 && nPlcCheck4 == 1) {
                SendMessageToPC(GetFirstPC(), "Pre-Cleanup Notification");
            } */

            //database cleanup, as the information source (plc) database entries are no longer needed
            SQLocalsPlayer_DeleteInt(oPC, "Q_TTECHLORE1");
            SQLocalsPlayer_DeleteInt(oPC, "Q_TTECHLORE2");
            SQLocalsPlayer_DeleteInt(oPC, "Q_TTECHLORE3");
            SQLocalsPlayer_DeleteInt(oPC, "Q_TTECHLORE4");

            //clean-up debug messages
        /*  nPlcCheck1 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE1");
            nPlcCheck2 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE2");
            nPlcCheck3 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE3");
            nPlcCheck4 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE4");
            if(nPlcCheck1 != 1 && nPlcCheck2 != 1 && nPlcCheck3 != 1 && nPlcCheck4 != 1) {
                SendMessageToPC(GetFirstPC(), "Cleanup Successfull");
            } */
        }
    }
}

