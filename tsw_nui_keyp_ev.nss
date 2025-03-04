#include "tsw_inc_nui"
#include "tsw_nui_keyp"
#include "utl_i_sqlplayer"

void main()
{
        object oPlayer   = NuiGetEventPlayer();
        int nToken       = NuiGetEventWindow();
        string sEvent    = NuiGetEventType();
        string sElement  = NuiGetEventElement();
        int nIndex       = NuiGetEventArrayIndex();
        string sWindowId = NuiGetWindowId(oPlayer, nToken);

        //This is the variable set the keypad placable, which also must be the tag on the target door object
        int nCounter = 0;
        string sKeypadCode = GetLocalString(oPlayer, "KEYPAD_CODE");
        object oKeypadDoor = GetNearestObjectByTag(GetLocalString(oPlayer, "KEYPAD_DOOR"), oPlayer, nCounter);

        //This is the popup message that is sent once the door is unlocked. Also set as a variable on the keypad placable.
        string sMessage = GetLocalString(oPlayer, "KEYPAD_MSG");


    /*
        SendMessageToPC(oPlayer, "---------------------------------------");
        SendMessageToPC(oPlayer, "DM-4A: tsw_nui_keyp_ev.nss");
        SendMessageToPC(oPlayer, "---------------------------------------");
        SendMessageToPC(GetFirstPC(), "Receive an OnNuiEvent.");
        SendMessageToPC(GetFirstPC(), "Player: " + GetName(oPlayer));
        SendMessageToPC(GetFirstPC(), "nToken: " + IntToString(nToken));
        SendMessageToPC(GetFirstPC(), "sEvent: " + sEvent);
        SendMessageToPC(GetFirstPC(), "sElement: " + sElement);
        SendMessageToPC(GetFirstPC(), "nIndex: " + IntToString(nIndex));
        SendMessageToPC(GetFirstPC(), "sWindowId: " + sWindowId);
        SendMessageToPC(GetFirstPC(), "" + sWindowId);
    */

        // This is not our window, nothing to do.
        if (sWindowId != NUI_KEYPAD_WINDOW)
        {
                return;
        }

        // Not a mouseup event, nothing to do.
        if (sEvent != "mouseup")
        {
                return;
        }


        //keypad combo
        int nCount = GetLocalInt(oPlayer, "nui_tut_button_clicks");
        string nKeyCombo = GetLocalString(oPlayer, "nui_KeyCombo01");
        if (nCount == 0) {
            nKeyCombo = "";

        }

        //-----------------------
        //BUTTON FUNCTIONALITIES!
        //-----------------------

        //BUTTON FUNCTIONALITY: ERASE
        if (sElement == "nui_keypad01_erase") {
            nKeyCombo = "";
            nCount = 0;
            SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
            NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
            SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
            NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString(IntToString(nCount)));
            return;
        }


        //BUTTON FUNCTIONALITY: CONFIRM
        if (sElement == "nui_keypad01_OK") {

            //door mechanic to unlock and open
            if (sKeypadCode == nKeyCombo) {
                //We loop until we found all valid door objects with the tag, to open all of the same tag.
                while (GetIsObjectValid(oKeypadDoor)) {
                    if (GetIsObjectValid(oKeypadDoor) && ( GetArea(oKeypadDoor) == GetArea(oPlayer) ) ) //ISSUE HERE - GETAREA and GET AREA NOT WORKING //GET OBJECT BY TAG!
                    {
                        SetLocked(oKeypadDoor, FALSE);

                        if (sMessage != "" && nCounter == 0)
                        {
                           /*location lPCLoc = GetLocation(GetEnteringObject());
                           object oPlayerGroup = GetFirstObjectInShape(SHAPE_SPHERE,1.0f,lPCLoc);

                            while (GetIsObjectValid(oPlayerGroup))
                            {
                                if (GetIsPC(oPlayerGroup))
                                {
                                    FloatingTextStringOnCreature(sMessage, oPlayerGroup, FALSE);
                                }
                                 oPlayerGroup = GetNextObjectInShape(SHAPE_SPHERE,1.0f, lPCLoc);
                            }  */
                            FloatingTextStringOnCreature(sMessage,oPlayer,TRUE,FALSE);

                        }
                    }
                nCounter += 1;
                oKeypadDoor = GetNearestObjectByTag(GetLocalString(oPlayer, "KEYPAD_DOOR"), oPlayer, nCounter);
                }
            }
            return;
        }


        //reset of combination and ncount if fifth digit is entered.
        if (nCount > 3) {
            nKeyCombo = "";
            nCount = 0;
        }


        if (sElement == "nui_keypad01_1")
        {
                //SendMessageToPlayer(GetFirstPC(), "Debug Message: Click");
                //add new digit to combination
                nKeyCombo += "1";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString(IntToString(nCount)));
                return;
        }

        if (sElement == "nui_keypad01_2")
        {
                nKeyCombo += "2";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_3")
        {
                nKeyCombo += "3";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_4")
        {
                nKeyCombo += "4";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_5")
        {
                nKeyCombo += "5";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_6")
        {
                nKeyCombo += "6";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_7")
        {
                nKeyCombo += "7";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_8")
        {
                nKeyCombo += "8";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_9")
        {
                nKeyCombo += "9";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }
        if (sElement == "nui_keypad01_0")
        {
                nKeyCombo += "0";
                SetLocalString(oPlayer, "nui_KeyCombo01", nKeyCombo);
                NuiSetBind(oPlayer, nToken, "nui_KeyCombo01_count", JsonString(nKeyCombo));
                //track number of entered digits
                nCount++;
                SetLocalInt(oPlayer, "nui_tut_button_clicks", nCount);
                NuiSetBind(oPlayer, nToken, "nui_tut_label_count", JsonString("Count: " + IntToString(nCount)));
                return;
        }

}
