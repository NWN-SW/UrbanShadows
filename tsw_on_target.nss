#include "tsw_faction_func"

string SetFirstAsUpper(string sNewName)
{
    string sUpperName = GetStringUpperCase(sNewName);
    string sUpperLetter = GetStringLeft(sUpperName, 1);

    sUpperName = sUpperLetter + GetStringRight(sNewName,GetStringLength(sNewName)-1);

    return sUpperName;
}

void TogglePlotOnItem(object oItem, object oPC)
{
    if (GetObjectType(oItem) != OBJECT_TYPE_ITEM)
    {
        FloatingTextStringOnCreature("This command can only be used on items",oPC);
        return;
    }else
    {
    if (!GetPlotFlag(oItem))
    {
        SetPlotFlag(oItem,TRUE);
        FloatingTextStringOnCreature(GetName(oItem) + "'s plot flag applied",oPC);
    }
    else
    {
        SetPlotFlag(oItem,FALSE );
        FloatingTextStringOnCreature(GetName(oItem) + "'s plot flag removed",oPC);
    }
    EnterTargetingMode(oPC,OBJECT_TYPE_ITEM);
    }

}

// -----------------------------
// 30.12.2024, Fallen Dabus.
// ON_TARGET_MODE DOCUMENTATION
// -----------------------------
// ON_TARGET_MODE is a local int set by different scripts (particularly NUI scripts) in order to provide the necessary
// information for this script to know what the on_target_mode is trying to do. 
// -----------------------------
// ON_TARGET_MODE = int 0 = no target mode chosen.
// ON_TARGET_MODE = int 1 = hatVFX & glassesVFX items in player inventory. See tsw_nui_hat.nss and tsw_nui_hat_e.nss
// ON_TARGET_MODE = int 2 = flask slot items. (Reserved for future script)
// ON_TARGET_MODE = int 3 = charm slot items. (Reserved for future script)
// -----------------------------


void main()
{
    object oTargeter = GetLastPlayerToSelectTarget();
    object oTargeted = GetTargetingModeSelectedObject();
    string sTag;
	int nTargetMode = GetLocalInt (oTargeter, "ON_TARGET_MODE");

	//1. Targeting for the hVFX and gVFX system. Relevant scripts: tsw_nui_hat.nss, tsw_nui_hat_e.nss
	//Note by FD: This targeting mode is not yet being actively used, but reserved for future use.
	/*
	
	if (nTargetMode == 1) {
		
		if ( GetTag(oTargeted) == "m3_conv_hat") {
			sTag = GetObjectUUID(oTargeted);
			SetLocalString(oTargeter, "sHatUUID", sTag);
			SendMessageToPC (oTargeter, "You have selected " + GetName (oTargeted) + " for editing.");
			//reset current hatVFX, and re-activate the item. 
			return;
		}

		else if ( GetTag(oTargeted) == "m3_conv_gls") {
			sTag = GetObjectUUID(oTargeted);
			SetLocalString(oTargeter, "sGlsUUID", sTag);
			SendMessageToPC (oTargeter, "You have selected " + GetName (oTargeted) + " for editing.");
			//reset current glsVFX, and re-activate the item.
			return;
		}		
	}
	*/
	
	

	//x. Written by Raccoon. 
    if (GetIsDM(oTargeter) || GetIsDMPossessed(oTargeter))
    {
        string sEmote = GetLocalString(oTargeter,"sDMCommand");
        //SendMessageToPC(GetFirstPC(),sEmote);
        sEmote = GetStringLowerCase(sEmote);

        //Too lazy to perform checks because JSON but ideally we would want to check if whatever comes after dmodel or dmsize is only composed of integers
        if (FindSubString(sEmote,"msg",0) == 0)
        {
            string sDMsg = GetStringRight(sEmote,GetStringLength(sEmote)-4);
            FloatingTextStringOnCreature(sDMsg,oTargeted,TRUE);
        }
        else if (FindSubString(sEmote,"model",0) == 0)
        {
            string sModel = GetStringRight(sEmote,GetStringLength(sEmote)-5);
            SetCreatureAppearanceType(oTargeted,StringToInt(sModel));
        }
        // Calling example : /dmname Toto .dmname (space included) is 7 characters which is why we retrieve whatever comes after the first seven characters.
        //Same Logic applies to a few other commands
        else if (FindSubString(sEmote,"name",0)  == 0)
        {
            string sNewDMName = GetStringRight(sEmote,GetStringLength(sEmote)-5);
            SetName(oTargeted,SetFirstAsUpper(sNewDMName));
        }

        else if (FindSubString(sEmote,"size",0) == 0)
        {
            string sNewSize = GetStringRight(sEmote,GetStringLength(sEmote)-5);
            float fNewSize = StringToFloat(sNewSize);
            if (FindSubString(sNewSize,".",0) != -1)
            {
                if (fNewSize > 0.2f)
                {
                    SetObjectVisualTransform(oTargeted,OBJECT_VISUAL_TRANSFORM_SCALE,fNewSize);

                }
                else
                {
                    SendMessageToPC(oTargeter,"Specified size is too low!");
                }
            }

        }
        else if (FindSubString(sEmote,"vfx")  == 0)
        {
          string sVFX = GetStringRight(sEmote,GetStringLength(sEmote)-4);
          float fNewScale = 1.0f;
          int iDurationType =DURATION_TYPE_PERMANENT;
          if (FindSubString(sVFX,"_") != -1 && FindSubString(sVFX,".") != -1)
          {
            int iOffset = FindSubString(sVFX,"_");
            fNewScale = StringToFloat(GetStringRight(sVFX,GetStringLength(sVFX) - iOffset-1));
          }

          effect eNewVFX = EffectVisualEffect(StringToInt(sVFX),FALSE,fNewScale);

          if (FindSubString(sVFX,"i") != -1)
          {
            iDurationType = DURATION_TYPE_INSTANT;
          }
            ApplyEffectToObject(iDurationType, eNewVFX, oTargeted);
        }

        else if (FindSubString(sEmote,"getfct")  == 0)
        {
            string sMessageToTargeter  = GetName(oTargeted) + " is a member of the " + GetFaction(oTargeted) + " faction.";
            SendMessageToPC(oTargeter, sMessageToTargeter);
        }

         else if (FindSubString(sEmote,"giverep")  == 0)
         {

                    string sRepGiven = GetStringRight(sEmote,GetStringLength(sEmote)-8);
                    int nRepCheck = StringToInt(sRepGiven);
                    nRepCheck = AddReputation(oTargeted, nRepCheck);

                    if(nRepCheck != 0)
                    {
                        FloatingTextStringOnCreature("You have earned " + sRepGiven + " faction reputation. (Doubled for Hardcore characters)", oTargeted, FALSE);
                        SendMessageToPC(oTargeter, sRepGiven + " Reputation points granted to " + GetName(oTargeted)+ "(Doubled for Hardcore characters)");
                    }

        }

             else if (FindSubString(sEmote,"takerep")  == 0)
         {

                    string sRepGiven = GetStringRight(sEmote,GetStringLength(sEmote)-8);
                    int nRepCheck = StringToInt(sRepGiven);
                    nRepCheck = TakeReputation(oTargeted, nRepCheck);

                    if(nRepCheck != 0)
                    {
                        FloatingTextStringOnCreature(" " + sRepGiven + " faction reputation have been stripped from your count.", oTargeted, FALSE);
                        SendMessageToPC(oTargeter, sRepGiven + " Reputation points granted to " + GetName(oTargeted)+ "(Doubled for Hardcore characters)");
                    }

        }
     DeleteLocalString(oTargeter,"sDMCommand");
     DeleteLocalInt(oTargeter,"iDMTarget");
    }

    string sTargetCommand = GetLocalString(oTargeter,"sTargetMode");

    if (sTargetCommand == "setplot")
    {
        TogglePlotOnItem(oTargeted,oTargeter);
    }
}



