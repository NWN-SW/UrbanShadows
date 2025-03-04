#include "utl_i_sqlplayer"


// --------------------------------------------------------------------------------
// --------------------------------------------------------------------------------
//
// HAT SYSTEM START
//
// --------------------------------------------------------------------------------
// --------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------
// FALLEN DABUS, 30.12.2024
// BRIEF DOCUMENTATION
// --------------------------------------------------------------------------------------

// Cosmetic VFX items have two "slots". Hats, and Glasses/Masks.
// Their items tags and ResRef need to be set up correctly.
//
// The tag is used to identify them as cosmetic VFX items by these scripts, as well as to
// launch the m3_conv_hat.nss (for hat slot VFX) and m3_conv_gls.nss (for mask / glasses
// slot VFX) scripts.
//
// Their ResRef provides the script with the information which specific VFX to fire, as well
// as to save their positioning information into their players SQLocalPlayers database file
// under their ResRef.
//
// Convention for Tags:
// (...)
//
// Convention for ResRefs:
// (...)
//
// Core Functionality
// Each cosmetic VFX upon being activated first checks if there is already a SQLocals database
// entry under its ResRef. If yes, then it pulls the positioning information from that entry's
// string.
//
// This is necessary, as handling it via the local variables of an item would not persist across
// server resets. Meaning the position of cosmetic VFX items would otherwise be reverted by resets.

int GetHatType(object oItem)
{
    int iHatType = 0;
    string sResref = GetResRef(oItem);
    string sVFX = GetSubString(sResref, 7, 4);
    int iVFX = StringToInt(sVFX);

    //SendMessageToPC(GetFirstPC(), "Hat type is "+IntToString(iVFX));
    return iVFX;
}

void RemoveEffectByTag(object oTarget, string sEffectTag)
{
   effect eEffects = GetFirstEffect(oTarget);
   while(GetIsEffectValid(eEffects))
   {
    if(GetEffectTag(eEffects) == sEffectTag)
    {
      RemoveEffect(oTarget, eEffects);
    }
    eEffects = GetNextEffect(oTarget);
   }
}

int M3FirstTimeItem(object oPC, object oItem)
{

    // Every cosmetic VFX for hats, glasses etc. has its display variables saved as a  SQLocalEntry for the player that uses it.
    // This script checks if it exists, and if not, creates it.

    string sResRef = GetResRef(oItem);

    if (SQLocalsPlayer_GetString(oPC, sResRef) == "") {
        SQLocalsPlayer_SetString(oPC, sResRef, "0.000$0.000$0.000$0.000$0.000$0.000$1.000");
        return TRUE; // <------------- HAS TO BE SET TO TRUE ONCE ENTRY GETS SAVED IN SQLocalsPlayer
    }

    else
        return FALSE;
}


void SaveVariableString(object oPC, object oItem)
{
    string sResRef = GetResRef(oItem);
    float tX = GetLocalFloat(oItem, "tX");
    string stX = GetSubString(FloatToString(tX, 0, 5), 0, 5);
    float tY = GetLocalFloat(oItem, "tY");
    string stY = GetSubString(FloatToString(tY, 0, 5), 0, 5);
    float tZ = GetLocalFloat(oItem, "tZ");
    string stZ = GetSubString(FloatToString(tZ, 0, 5), 0, 5);
    float rX = GetLocalFloat(oItem, "rX");
    string srX = GetSubString(FloatToString(rX, 0, 5), 0, 5);
    float rY = GetLocalFloat(oItem, "rY");
    string srY = GetSubString(FloatToString(rY, 0, 5), 0, 5);
    float rZ = GetLocalFloat(oItem, "rZ");
    string srZ = GetSubString(FloatToString(rZ, 0, 5), 0, 5);
    float Scale = GetLocalFloat(oItem, "Scale");
    string sScale = GetSubString(FloatToString(Scale, 0, 5), 0, 5);

    //Set SQLocalPlayer entry, that contains the display variables for the customizationVFX
    string sVarString = stX + "$" + stY + "$" + stZ + "$" + srX + "$" + srY + "$" + srZ + "$" + sScale;
    SQLocalsPlayer_SetString(oPC, sResRef, sVarString);

    //DebugMode, checks if floats are being properly converted to the database string, and database string properly converted to floats
    if (FALSE) {
        SendMessageToPC(oPC, "Test 01: " + FloatToString(tX) + "$" + FloatToString(tY) + "$" + FloatToString(tZ) + "$" + FloatToString(rX) + "$" + FloatToString(rY) + "$" + FloatToString(rZ) + "$" + FloatToString(Scale));
        SendMessageToPC(oPC, "Test 02: " + sVarString);
        tX = StringToFloat(GetSubString(sVarString, 0, 5));
        tY = StringToFloat(GetSubString(sVarString, 6, 5));
        tZ = StringToFloat(GetSubString(sVarString, 12, 5));
        rX = StringToFloat(GetSubString(sVarString, 18, 5));
        rY = StringToFloat(GetSubString(sVarString, 24, 5));
        rZ = StringToFloat(GetSubString(sVarString, 30, 5));
        Scale = StringToFloat(GetSubString(sVarString, 36, 5));
        SendMessageToPC(oPC, "Test 03: " + FloatToString(tX) + "$" + FloatToString(tY) + "$" + FloatToString(tZ) + "$" + FloatToString(rX) + "$" + FloatToString(rY) + "$" + FloatToString(rZ) + "$" + FloatToString(Scale));
    }
}


//This is the core script through which cosmetic VFX are activated and deactivated.

void ActivateCosmeticVFX (object oPC, object oVFXItem, string sVFXItemType, int nDeactivate) {

    float tX;
    float tY;
    float tZ;
    float rX;
    float rY;
    float rZ;
    float Scale;
    int iWhichHat = GetHatType(oVFXItem); 

	//This performs a check if a character has used this cosmetic VFX before. If not, we create a string with the float values
	//for the visual positioning of the VFX, and then save it to the SQLocals database for the character.
    if (M3FirstTimeItem(oPC, oVFXItem) == TRUE) {
        tX = 0.0;
        tY = 0.0;
        tZ = 0.0;
        rX = 0.0;
        rY = 0.0;
        rZ = 0.0;
        Scale = 1.0;
    }

	//If the character has already used this particular cosmetic VFX item before, we simply load the visual positioning
	//information from the string saved in the SQLocals database of their character.
    else {
        string sResRef = GetResRef(oVFXItem);
        string sVarString = SQLocalsPlayer_GetString(oPC, sResRef);
        tX = StringToFloat(GetSubString(sVarString, 0, 5));
        tY = StringToFloat(GetSubString(sVarString, 6, 5));
        tZ = StringToFloat(GetSubString(sVarString, 12, 5));
        rX = StringToFloat(GetSubString(sVarString, 18, 5));
        rY = StringToFloat(GetSubString(sVarString, 24, 5));
        rZ = StringToFloat(GetSubString(sVarString, 30, 5));
        Scale = StringToFloat(GetSubString(sVarString, 36, 5));
    }

    
    //Hats
    if (sVFXItemType == "m3_conv_hat") {

       //Saving item UUID, in case the character uses the hVFX / gVFX tool for it later.
        SetLocalString(oPC, "sHatUUID", GetObjectUUID(oVFXItem));

        //Checks if character is currently already wearing a hat.
        if ( SQLocalsPlayer_GetInt(oPC, "C_HAT_ACTIVE") != 0 )
        {
            SQLocalsPlayer_SetInt(oPC, "C_HAT_ACTIVE", 0);
            RemoveEffectByTag(oPC, "HatVFX");
            //SetLocalString(oPC, "sHatUUID", "");

            if (nDeactivate == 0)
                return;
        }

		if(Scale == 0.0) //Fix scale issue before it happens
        {
          Scale = 1.0;
        }
        
       vector vTranslate = Vector(tX, tY, tZ);
       vector vRotate = Vector(rX, rY, rZ);

       RemoveEffectByTag(oPC, "HatVFX");
       effect eVFX = TagEffect(EffectVisualEffect(iWhichHat, FALSE, Scale, vTranslate, vRotate), "HatVFX");
       DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oPC));
       SQLocalsPlayer_SetInt(oPC, "C_HAT_ACTIVE", 1);
       SQLocalsPlayer_SetString(oPC, "C_HAT_TAG", GetTag(oVFXItem));
       return;
    }

    //Glasses & Masks
    else if (sVFXItemType == "m3_conv_gls") {

        //Saving item UUID, in case the character uses the hVFX / gVFX tool for it later.
        SetLocalString(oPC, "sGlsUUID", GetObjectUUID(oVFXItem));

        //Checks if character is currently already wearing a hat.
        if (SQLocalsPlayer_GetInt(oPC, "C_GLS_ACTIVE") != 0)
        {
            SQLocalsPlayer_SetInt(oPC, "C_GLS_ACTIVE", 0);
            RemoveEffectByTag(oPC, "GlsVFX");
            //SetLocalString(oPC, "sGlsUUID", "");

            if (nDeactivate == 0)
                return;
        }

        if(Scale == 0.0) //Fix scale issue before it happens
        {
          Scale = 1.0;
        }

       vector vTranslate = Vector(tX, tY, tZ);
       vector vRotate = Vector(rX, rY, rZ);

       RemoveEffectByTag(oPC, "GlsVFX");
       effect eVFX = TagEffect(EffectVisualEffect(iWhichHat, FALSE, Scale, vTranslate, vRotate), "GlsVFX");
       DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oPC));
       SQLocalsPlayer_SetInt(oPC, "C_GLS_ACTIVE", 1);
       SQLocalsPlayer_SetString(oPC, "C_GLS_TAG", GetTag(oVFXItem));
       return;
    }
    return;
}
