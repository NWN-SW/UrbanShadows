#include "tsw_inc_nui"
#include "tsw_nui_hat"
#include "utl_i_sqlplayer"
#include "m3_cosmetic_vfx"

void main()
{
    object oPC   = NuiGetEventPlayer();
    int nToken       = NuiGetEventWindow();
    string sEvent    = NuiGetEventType();
    string sElement  = NuiGetEventElement();
    int nIndex       = NuiGetEventArrayIndex();
    string sWindowId = NuiGetWindowId(oPC, nToken);

    float fHowMuch = IntToFloat(GetLocalInt(oPC, "nui_hat_nscale")) / 100;
    object oVFXGlsItem;
    object oVFXHatItem;
    object oVFXSelItem;
    float tX;
    float tY;
    float tZ;
    float rX;
    float rY;
    float rZ;
    float Scale;
    int iWhich;

    int nDebugMode = 1;


        // 1. This is not our window, nothing to do.
        if (sWindowId != NUI_HAT_WINDOW)
        {
                return;
        }

        if (nDebugMode == 1) {
            SendMessageToPC(oPC, "DEBUG 040: fHowMuch == " + FloatToString(fHowMuch));
        }


        // 3. If not a mouseup event, nothing to do. Under the mouseup events you will find the majority of the button functionalities.
        if (sEvent == "mouseup")
        {

            // 3.1. We first check if the object is still within possession of the player character, to avoid potential edge case issues.
            if (GetLocalString(oPC, "sGlsUUID") != "") {
                oVFXGlsItem  = GetObjectByUUID(GetLocalString(oPC, "sGlsUUID"));

                if ( GetItemPossessor(oVFXGlsItem, FALSE) != oPC) {
                    SQLocalsPlayer_SetInt(oPC, "C_GLS_ACTIVE", 0);
                    RemoveEffectByTag(oPC, "GlsVFX");
                    SetLocalString(oPC, "sGlsUUID", "");
                }

                //3.1.1. If everything checks out, and glasses editing is still selected, we start loading in the item variables of the mask / glasses for visual editing.
                else if (GetLocalString(oPC, "NUI_CVFX_Selection") == "glasses") {
                    
					string sVarString = GetResRef(oVFXGlsItem);
					tX = StringToFloat(GetSubString(sVarString, 0, 5));
					tY = StringToFloat(GetSubString(sVarString, 6, 5));
					tZ = StringToFloat(GetSubString(sVarString, 12, 5));
					rX = StringToFloat(GetSubString(sVarString, 18, 5));
					rY = StringToFloat(GetSubString(sVarString, 24, 5));
					rZ = StringToFloat(GetSubString(sVarString, 30, 5));
					Scale = StringToFloat(GetSubString(sVarString, 36, 5)); // <--- FixFloat missing
					
					//Fix scale issue before it happens
					if (Scale <= 0.0)
						Scale = 1.00;

					
                    iWhich = GetHatType(oVFXGlsItem);
                    oVFXSelItem = oVFXGlsItem;
                }
            }

            if (GetLocalString(oPC, "sHatUUID") != "") {
                oVFXHatItem = GetObjectByUUID(GetLocalString(oPC, "sHatUUID"));

                if ( GetItemPossessor(oVFXHatItem, FALSE) != oPC) {
                    SQLocalsPlayer_SetInt(oPC, "C_HAT_ACTIVE", 0);
                    RemoveEffectByTag(oPC, "HatVFX");
                    SetLocalString(oPC, "sHatUUID", "");
                }

                //3.1.2. If everything checks out, and hat editing is still selected, we start loading in the item variables of the hat for visual editing.
                else if (GetLocalString(oPC, "NUI_CVFX_Selection") == "hat") {
                    
					string sVarString = GetResRef(oVFXHatItem);
					tX = StringToFloat(GetSubString(sVarString, 0, 5));
					tY = StringToFloat(GetSubString(sVarString, 6, 5));
					tZ = StringToFloat(GetSubString(sVarString, 12, 5));
					rX = StringToFloat(GetSubString(sVarString, 18, 5));
					rY = StringToFloat(GetSubString(sVarString, 24, 5));
					rZ = StringToFloat(GetSubString(sVarString, 30, 5));
					Scale = StringToFloat(GetSubString(sVarString, 36, 5)); // <--- FixFloat missing
									
                    iWhich = GetHatType(oVFXHatItem);
                    oVFXSelItem = oVFXHatItem;
                }
            }


            //3.x These buttons allow players to select if they want to edit their hatVFX or glassesVFX.

            //gVFX Selection
            if(sElement == "nui_keypad01_1")
            {
                if (GetLocalString(oPC, "sHatUUID") != "") {
                    SetLocalString(oPC, "NUI_CVFX_Selection", "glasses");

                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Debug 027: " + GetLocalString(oPC, "NUI_CVFX_Selection"));
                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Debug 028: " + GetTag(oVFXGlsItem));

                }
                else {
                    SetLocalString(oPC, "NUI_CVFX_Selection", "");
                    SendMessageToPC(oPC, "To adjust a mask or glasses, you will first need to put some on.");
                }

                return;
            }

            //hVFX Selection
            if(sElement == "nui_keypad01_2")
            {
                if (GetLocalString(oPC, "sHatUUID") != "") {
                    SetLocalString(oPC, "NUI_CVFX_Selection", "hat");

                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Debug 029: " + GetLocalString(oPC, "NUI_CVFX_Selection"));
                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Debug 030: " + GetTag(oVFXHatItem));
                }
                else {
                    SetLocalString(oPC, "NUI_CVFX_Selection", "");
                    SendMessageToPC(oPC, "To adjust a hat, you will first need to put on a hat.");
                }

                return;
            }


            // ------------------
            // ADJUSTMENT BUTTONS
            // ------------------

            // 4. VFX Adjustment Buttons should only work if the player selected either the Glasses or Hat VFX for editing.
            if (GetLocalString(oPC, "NUI_CVFX_Selection") != "") {

                // LocalInt "NUI_CVFX_EditMode" set by the dropdown menu selection under the watch events
                // provides the neccesary information for us to tell the buttons in which manner they should change
                // the visual effects position, rotation and scale.
                // 0 = select, 1 = move, 2 = raise, 3 = tilt, 4 = turn, 5 = scale
                int nMode = GetLocalInt(oPC, "NUI_CVFX_EditMode");

                //4.1.1. Button Up
                if(sElement == "nui_keypad01_3") {

                    // Only once a button is pressed, we lock in the value of the edit from the slider.
                    // ...


                    if (nMode == 0) {
                        SendMessageToPC(oPC, "Please select an editing mode in the dropdown menu first.");
                        return;
                    }

                    //4.1.1.2. Move, Button Up (Forward)
                    else if (nMode == 1) {
                        tY = GetLocalFloat(oVFXSelItem, "tY");
                        tY += fHowMuch;

                        if(tY > 5.0 || tY < -5.0)
                        {
                        SendMessageToPC(oPC, "Axis too large.");
                        tY = 0.0;
                        }
                        SetLocalFloat(oVFXSelItem, "tY", tY);
                    }

                    //4.1.1.3. Raise, Button Up (Up)
                    else if (nMode == 2) {
                        tZ = GetLocalFloat(oVFXSelItem, "tZ");
                        tZ += fHowMuch;

                        if(tZ > 5.0 || tZ < -5.0) {
                            SendMessageToPC(oPC, "Axis too large.");
                            tZ = 0.0;
                        }
                        SetLocalFloat(oVFXSelItem, "tZ", tZ);
                    }


                    //4.1.1.3. Tilt, Button Up (Forward Tilt)
                    else if (nMode == 3) {
                        rY = GetLocalFloat(oVFXSelItem, "rY");
                        rY -= (fHowMuch * 10);
                        SetLocalFloat(oVFXSelItem, "rY", rY);
                    }

                    else if (nMode == 4) {  }

                    //4.1.1.6. Scale, Button Up (Enlarge)
                    else if (nMode == 5) {
                        Scale = GetLocalFloat(oVFXSelItem, "Scale");
                        Scale += fHowMuch;

                        if(Scale > 4.0) {
                            SendMessageToPC(oPC, "Size too large.");
                            Scale = 1.0;
                        }
                        SetLocalFloat(oVFXSelItem, "Scale", Scale);
                    }

                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Float 05: " + FloatToString(GetLocalFloat(oVFXSelItem, "rY")));
                    
					string sVFXItemType = GetTag(oVFXSelItem);
					SaveVariableString(oPC, oVFXSelItem);
                    ActivateCosmeticVFX(oPC, oVFXSelItem, sVFXItemType, 1);
                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Float 06: " + FloatToString(GetLocalFloat(oVFXSelItem, "rY")));				
					return;
                }

                //4.1.2. Button DOWN
                if(sElement == "nui_keypad01_7") {

                    // Only once a button is pressed, we lock in the value of the edit from the slider.
                    // ...


                    if (nMode == 0) {
                        SendMessageToPC(oPC, "Please select an editing mode in the dropdown menu first.");
                        return;
                    }

                    //4.1.2.2. Move, Button Down (Back)
                    else if (nMode == 1) {
                        tY = GetLocalFloat(oVFXSelItem, "tY");
                        tY -= fHowMuch;

                        if(tY > 5.0 || tY < -5.0)
                        {
                        SendMessageToPC(oPC, "Axis too large.");
                        tY = 0.0;
                        }
                        SetLocalFloat(oVFXSelItem, "tY", tY);
                    }

                    //4.1.2.3. Raise, Button Down (Lower)
                    else if (nMode == 2) {
                        tZ = GetLocalFloat(oVFXSelItem, "tZ");
                        tZ -= fHowMuch;

                        if(tZ > 5.0 || tZ < -5.0) {
                            SendMessageToPC(oPC, "Axis too large.");
                            tZ = 0.0;
                        }
                        SetLocalFloat(oVFXSelItem, "tZ", tZ);
                    }

                    //4.1.2.3. Tilt, Button Down (Backward Tilt)
                    else if (nMode == 3) {
                        rY = GetLocalFloat(oVFXSelItem, "rY");
                        rY += (fHowMuch * 10);
                        SetLocalFloat(oVFXSelItem, "rY", rY);
                    }

                    else if (nMode == 4) {}

                    //4.1.2.6. Scale, Button Down (Shrink)
                    else if (nMode == 5) {
                        Scale = GetLocalFloat(oVFXSelItem, "Scale");
                        Scale -= fHowMuch;

                        if(Scale < 0.2) {
                            SendMessageToPC(oPC, "Size too large.");
                            Scale = 1.0;
                        }
                        SetLocalFloat(oVFXSelItem, "Scale", Scale);
                    }

                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Float 05: " + FloatToString(GetLocalFloat(oVFXSelItem, "rY")));
					
                    string sVFXItemType = GetTag(oVFXSelItem);
					SaveVariableString(oPC, oVFXSelItem);
                    ActivateCosmeticVFX(oPC, oVFXSelItem, sVFXItemType, 1);				
                    return;
                }

                //4.1.3. Button LEFT
                if(sElement == "nui_keypad01_4") {

                    // Only once a button is pressed, we lock in the value of the edit from the slider.
                    // ...


                    if (nMode == 0) {
                        SendMessageToPC(oPC, "Please select an editing mode in the dropdown menu first.");
                        return;
                    }

                    //4.1.2.2. Move, Button Left (Left)
                    else if (nMode == 1) {
                        tX = GetLocalFloat(oVFXSelItem, "tX");
                        tX -= fHowMuch;

                        if(tX > 5.0 || tX < -5.0)
                        {
                        SendMessageToPC(oPC, "Axis too large.");
                        tX = 0.0;
                        }
                        SetLocalFloat(oVFXSelItem, "tX", tX);
                    }

                    else if (nMode == 2) { }

                    //4.1.2.3. Tilt, Button Left (Leftward Tilt)
                    else if (nMode == 3) {
                        rX = GetLocalFloat(oVFXSelItem, "rX");
                        rX -= (fHowMuch * 10);
                        SetLocalFloat(oVFXSelItem, "rX", rX);
                    }

                    //4.1.2.4. Turn, Button Left (Leftward Turn)
                    else if (nMode == 4) {
                        rZ = GetLocalFloat(oVFXSelItem, "rZ");
                        rZ -= (fHowMuch * 10);
                        SetLocalFloat(oVFXSelItem, "rZ", rZ);
                    }

                    else if (nMode == 5) {}


                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Float 05: " + FloatToString(GetLocalFloat(oVFXSelItem, "rZ")));
					
                    string sVFXItemType = GetTag(oVFXSelItem);
					SaveVariableString(oPC, oVFXSelItem);
                    ActivateCosmeticVFX(oPC, oVFXSelItem, sVFXItemType, 1);					
                    return;
                }

                //4.1.4. Button RIGHT
                if(sElement == "nui_keypad01_6") {

                    // Only once a button is pressed, we lock in the value of the edit from the slider.
                    // ...


                    if (nMode == 0) {
                        SendMessageToPC(oPC, "Please select an editing mode in the dropdown menu first.");
                        return;
                    }

                    //4.1.4.2. Move, Button Right (Right)
                    else if (nMode == 1) {
                        tX = GetLocalFloat(oVFXSelItem, "tX");
                        tX += fHowMuch;

                        if(tX > 5.0 || tX < -5.0)
                        {
                        SendMessageToPC(oPC, "Axis too large.");
                        tX = 0.0;
                        }
                        SetLocalFloat(oVFXSelItem, "tX", tX);
                    }

                    else if (nMode == 2) {  }

                    //4.1.4.3. Tilt, Button Right (Rightward Tilt)
                    else if (nMode == 3) {
                        rX = GetLocalFloat(oVFXSelItem, "rX");
                        rX += (fHowMuch * 10);
                        SetLocalFloat(oVFXSelItem, "rX", rX);
                    }

                    //4.1.4.4. Turn, Button Right (Rightward Turn)
                    else if (nMode == 4) {
                        rZ = GetLocalFloat(oVFXSelItem, "rZ");
                        rZ += (fHowMuch * 10);
                        SetLocalFloat(oVFXSelItem, "rZ", rZ);
                    }

                    else if (nMode == 5) {      }


                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "Float 05: " + FloatToString(GetLocalFloat(oVFXSelItem, "rZ")));
					
                    string sVFXItemType = GetTag(oVFXSelItem);                  
					SaveVariableString(oPC, oVFXSelItem);
					ActivateCosmeticVFX(oPC, oVFXSelItem, sVFXItemType, 1);				
                    return;
                }

                //4.1.5. Button Reset
                if(sElement == "nui_keypad01_5") {

                    // Only once a button is pressed, we lock in the value of the edit from the slider.
                    // ...

                    if (nMode == 0) {
                        SendMessageToPC(oPC, "Please select an editing mode in the dropdown menu first.");
                        return;
                    }

                    //4.1.5.2. Move Reset
                    else if (nMode == 1) {
                        tX = 0.0;
                        SetLocalFloat(oVFXSelItem, "tX", tX);
                        tY = 0.0;
                        SetLocalFloat(oVFXSelItem, "tY", tY);
                    }

                    else if (nMode == 2) {  }

                    //4.1.5.3. Tilt Reset
                    else if (nMode == 3) {
                        rX = 0.0;
                        SetLocalFloat(oVFXSelItem, "rX", rX);
                    }

                    //4.1.5.4. Turn Reset
                    else if (nMode == 4) {
                        rZ = 0.0;
                        SetLocalFloat(oVFXSelItem, "rZ", rZ);
                    }

                    //4.1.5.5 Scale Reset
                    else if (nMode == 5) {
                        Scale = 1.0;
                        SetLocalFloat(oVFXSelItem, "Scale", Scale);
                    }

                    string sVFXItemType = GetTag(oVFXSelItem);										
					SaveVariableString(oPC, oVFXSelItem);
                    ActivateCosmeticVFX(oPC, oVFXSelItem, sVFXItemType, 1);					
                    return;
                }
            }
        }

        //-----------------------
        //    WATCH EVENTS
        //-----------------------

        if(sEvent == "watch") {

            if(sElement == "NUI_HAT_DDMENU_SELECTION" || sElement == "NUI_HAT_SLIDER")
            {
                //Dropdown Menu Functionality
                //If the player selects a different adjustment mode in the dropdown menu, we save it as a LocalInt for the editing buttons to use.
                json jMode = NuiGetBind(oPC, nToken, "NUI_HAT_DDMENU_SELECTION");
                int nMode = JsonGetInt(jMode);
                SetLocalInt(oPC, "NUI_CVFX_EditMode", nMode);


                //MISSING: Visual Feedback which buttons are greyed out depending on dropdown menu



                //Slider Functionality
                int nScale = JsonGetInt(NuiGetBind(oPC, nToken, "NUI_HAT_SLIDER"));
                SetLocalInt (oPC, "nui_hat_nscale", nScale);

                //Slider value is set to 1x for movement, raise, and scale vfx edits.
                if (nMode == 3 || nMode == 4) {
                    if (nScale < 10)
                        SetLocalString(oPC, "nui_hat_adjustment_string", "0." + IntToString(nScale));
                    else if (nScale <= 50)
                        SetLocalString(oPC, "nui_hat_adjustment_string", "" + IntToString(nScale / 10) + "." + IntToString(nScale % 10));
                }

                //Slider value is set to 10x for tilt and rotation vfx edits.
                else {
                    if (nScale < 10)
                        SetLocalString(oPC, "nui_hat_adjustment_string", "0.0" + IntToString(nScale));
                    else if (nScale <= 50)
                        SetLocalString(oPC, "nui_hat_adjustment_string", "0." + IntToString(nScale));
                }

                    string sFloatIncValue = GetLocalString(oPC, "nui_hat_adjustment_string");
                    NuiSetBind(oPC, nToken, "NUI_HAT_SLIDER_LABEL", JsonString(sFloatIncValue));

                    if (nDebugMode == 1)
                        SendMessageToPC(oPC, "DEBUG 024: " + sFloatIncValue);

                return;
            }
        }
}
