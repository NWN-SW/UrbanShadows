////////////////////////////////////////////////////////////////////////////////
//:: math_include_v.nss
//:: AML variable support include file
//::
//:: This file is part of "Auxiliary Math Library" project by NWShacker
//:: Version 2.0
////////////////////////////////////////////////////////////////////////////////


#include "math_include_b"
#include "math_include_l"


////////////////////////////////////////////////////////////////////////////////
// CONVERSION FUNCTIONS ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Converts vVector into a string. A supplement to other *ToString functions.
// -vVector: vector to convert
// -iDecimals: number of decimals (between 0 and 9 inclusive)
// Return value: "<x, y, z>" string where x, y, and z are vVector components.
string MATH_VectorToString(vector vVector, int iDecimals=9);
string MATH_VectorToString(vector vVector, int iDecimals=9)
{
    iDecimals = iDecimals < 0 ? 0 : iDecimals > 9 ? 9 : iDecimals;

    return "<" +
        FloatToString(vVector.x, 0, iDecimals) + ", " +
        FloatToString(vVector.y, 0, iDecimals) + ", " +
        FloatToString(vVector.z, 0, iDecimals) + ">";
}


////////////////////////////////////////////////////////////////////////////////
// LOCAL STORAGE FUNCTIONS /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Accesses local vector variable named sName stored on oObject. A supplement to
// other GetLocal* functions. A local location is used to store vector data.
// -oObject: object to retrieve vector from
// -sName: name of the local variable
// Return value: stored vector, or <0, 0, 0> if oObject has no such variable.
vector MATH_GetLocalVector(object oObject, string sName);
vector MATH_GetLocalVector(object oObject, string sName)
{
    return GetPositionFromLocation(GetLocalLocation(oObject, sName));
}


// Stores vVector as a local variable named sName on oObject. A supplement to
// other SetLocal* functions. A local location is used to store vector data.
// -oObject: object to store vector on
// -sName: name of the local variable
// -vVector: vector to store
void MATH_SetLocalVector(object oObject, string sName, vector vVector);
void MATH_SetLocalVector(object oObject, string sName, vector vVector)
{
    SetLocalLocation(oObject, sName, Location(OBJECT_INVALID, vVector, 0.0));
}


// Deletes local vector variable named sName from oObject. A supplement to
// other DeleteLocal* functions. A local location is used to store vector data.
// -oObject: object to delete vector from
// -sName: name of the local variable
void MATH_DeleteLocalVector(object oObject, string sName);
void MATH_DeleteLocalVector(object oObject, string sName)
{
    DeleteLocalLocation(oObject, sName);
}


// Accesses local list variable named sName stored on oObject. A supplement to
// other GetLocal* functions. A local string is used to store list data.
// -oObject: object to retrieve list from
// -sName: name of the local variable
// Return value: stored list (with MATH_LIST_TYPE_INVALID type if oObject has no
// such variable or the list structure is invalid).
struct list MATH_GetLocalList(object oObject, string sName);
struct list MATH_GetLocalList(object oObject, string sName)
{
    return MATH_ListStringLoad(GetLocalString(oObject, sName));
}


// Stores stList as a local variable named sName on oObject. A supplement to
// other SetLocal* functions. A local string is used to store list data.
// -oObject: object to store list on
// -sName: name of the local variable
// -stList: list structure to store
void MATH_SetLocalList(object oObject, string sName, struct list stList);
void MATH_SetLocalList(object oObject, string sName, struct list stList)
{
    SetLocalString(oObject, sName, MATH_ListStringDump(stList));
}


// Deletes local list variable named sName from oObject. A supplement to other
// DeleteLocal* functions. A local string is used to store list data.
// -oObject: object to delete list from
// -sName: name of the local variable
void MATH_DeleteLocalList(object oObject, string sName);
void MATH_DeleteLocalList(object oObject, string sName)
{
    DeleteLocalString(oObject, sName);
}


////////////////////////////////////////////////////////////////////////////////
// VARIABLE DEBUG FUNCTIONS ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Sends message to oPC and writes a time-stamped log entry containing value of
// sString, with sPrefix prefix and sSuffix suffix (and no spaces in between).
// -sString: string to debug
// -sPrefix: message prefix
// -sSuffix: message suffix
// -oPC: PC to send message to (first PC if oPC is not a PC)
void MATH_DebugString(string sString, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF);
void MATH_DebugString(string sString, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF)
{
    string sMessage;

    oPC = GetIsPC(oPC) ? oPC : GetFirstPC();

    sMessage = sPrefix + sString + sSuffix;

    SendMessageToPC(oPC, sMessage);
    WriteTimestampedLogEntry(sMessage);
}


// Sends message to oPC and writes a time-stamped log entry containing value of
// iInt, with sPrefix prefix and sSuffix suffix (and no spaces in between).
// -iInt: int to debug
// -sPrefix: message prefix
// -sSuffix: message suffix
// -oPC: PC to send message to (first PC on the server if oPC is not a PC)
void MATH_DebugInt(int iInt, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF);
void MATH_DebugInt(int iInt, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF)
{
    MATH_DebugString(IntToString(iInt), sPrefix, sSuffix);
}


// Sends message to oPC and writes a time-stamped log entry containing value of
// fFloat, with sPrefix prefix and sSuffix suffix (and no spaces in between).
// -fFloat: float to debug
// -sPrefix: message prefix
// -sSuffix: message suffix
// -oPC: PC to send message to (first PC on the server if oPC is not a PC)
void MATH_DebugFloat(float fFloat, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF);
void MATH_DebugFloat(float fFloat, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF)
{
    MATH_DebugString(FloatToString(fFloat, 0), sPrefix, sSuffix);
}


// Sends message to oPC and writes a time-stamped log entry containing value of
// vVector in form of "<x, y, z>", with sPrefix prefix and sSuffix suffix (and
// no spaces in between).
// -vVector: vector to debug
// -sPrefix: message prefix
// -sSuffix: message suffix
// -oPC: PC to send message to (first PC if oPC is not a PC)
void MATH_DebugVector(vector vVector, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF);
void MATH_DebugVector(vector vVector, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF)
{
    MATH_DebugString(MATH_VectorToString(vVector), sPrefix, sSuffix);
}


// Sends message to oPC and writes a time-stamped log entry containing value of
// lLocation, represented as "(area, position, facing)", with sPrefix prefix and
// sSuffix suffix (and no spaces in between).
// -lLocation: location to debug
// -sPrefix: message prefix
// -sSuffix: message suffix
// -oPC: PC to send message to (first PC if oPC is not a PC)
void MATH_DebugLocation(location lLocation, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF);
void MATH_DebugLocation(location lLocation, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF)
{
    object oArea;
    string sName;

    oArea = GetAreaFromLocation(lLocation);

    if(GetIsObjectValid(oArea))
    {
        sName = GetName(oArea);
    }
    else
    {
        sName = "OBJECT_INVALID";
    }

    MATH_DebugString("(" + sName + ", " +
        MATH_VectorToString(GetPositionFromLocation(lLocation)) + ", " +
        FloatToString(GetFacingFromLocation(lLocation), 0) + ")",
        sPrefix, sSuffix);
}


// Sends message to oPC and writes a time-stamped log entry containing value of
// oObject, represented as "{name, tag, #id, <type>}", with sPrefix prefix and
// sSuffix suffix (and no spaces in between).
// -oObject: object to debug
// -sPrefix: message prefix
// -sSuffix: message suffix
// -oPC: PC to send message to (first PC if oPC is not a PC)
void MATH_DebugObject(object oObject, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF);
void MATH_DebugObject(object oObject, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF)
{
    if(!GetIsObjectValid(oObject))
    {
        MATH_DebugString("{OBJECT_INVALID}", sPrefix, sSuffix);
        return;
    }

    string sObject;
    string sType;
    string sTag;

    if(GetIsPC(oObject))
    {
        sType = "<PC>";
    }
    else if(GetIsDM(oObject))
    {
        sType = "<DM>";
    }
    else
    {
        switch(GetObjectType(oObject))
        {
            case OBJECT_TYPE_AREA_OF_EFFECT: sType = "<area of effect>"; break;
            case OBJECT_TYPE_CREATURE: sType = "<creature>"; break;
            case OBJECT_TYPE_DOOR: sType = "<door>"; break;
            case OBJECT_TYPE_ENCOUNTER: sType = "<encounter>"; break;
            case OBJECT_TYPE_ITEM: sType = "<item>"; break;
            case OBJECT_TYPE_PLACEABLE: "<placeable>"; break;
            case OBJECT_TYPE_STORE: sType = "<store>"; break;
            case OBJECT_TYPE_TRIGGER: sType = "<trigger>"; break;
            case OBJECT_TYPE_WAYPOINT: sType = "<waypoint>"; break;
            default:
            {
                if(GetIsAreaNatural(oObject) != AREA_INVALID)
                {
                    sType = "<area>";
                }
                else if(oObject == GetModule())
                {
                    sType = "<module>";
                }
                else
                {
                    sType = "<unknown>";
                }
            }
        }
    }

    sTag = GetTag(oObject);
    if(sTag == "")
    {
        sTag = "N/A";
    }

    MATH_DebugString("{" + GetName(oObject) + ", " + sTag + ", #" +
        ObjectToString(oObject) + ", " + sType + "}", sPrefix, sSuffix);
}


// Sends messages to oPC and writes time-stamped log entries containing value of
// items of stList in form of "[index] = value", with sPrefix prefix and sSuffix
// suffix (and no spaces in between). Warning: this is an O(n) operation.
// -stList: list structure to debug
// -sPrefix: message prefix (added to each item)
// -sSuffix: message suffix (added to each item)
// -oPC: PC to send message to (first PC if oPC is not a PC)
void MATH_DebugList(struct list stList, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF);
void MATH_DebugList(struct list stList, string sPrefix="", string sSuffix="", object oPC=OBJECT_SELF)
{
    if(stList.length == 0)
    {
        return;
    }

    int i;

    switch(stList.type)
    {
        case MATH_LIST_TYPE_INT:
        {
            for(i = 0; i < stList.length; i++)
            {
                MATH_DebugString("[" + IntToString(i) + "] = " +
                    IntToString(MATH_ListGetInt(stList, i)),
                    sPrefix, sSuffix, oPC);
            }
            break;
        }
        case MATH_LIST_TYPE_FLOAT:
        {
            for(i = 0; i < stList.length; i++)
            {
                MATH_DebugString("[" + IntToString(i) + "] = " +
                    FloatToString(MATH_ListGetFloat(stList, i), 0),
                    sPrefix, sSuffix, oPC);
            }
            break;
        }
        case MATH_LIST_TYPE_VECTOR:
        {
            for(i = 0; i < stList.length; i++)
            {
                MATH_DebugString("[" + IntToString(i) + "] = " +
                    MATH_VectorToString(MATH_ListGetVector(stList, i)),
                    sPrefix, sSuffix, oPC);
            }
            break;
        }
        case MATH_LIST_TYPE_STRING:
        {
            for(i = 0; i < stList.length; i++)
            {
                MATH_DebugString("[" + IntToString(i) + "] = " +
                    MATH_ListGetString(stList, i),
                    sPrefix, sSuffix, oPC);
            }
            break;
        }
        default:
        {
            for(i = 0; i < stList.length; i++)
            {
                MATH_DebugString("[" + IntToString(i) + "] = " +
                    MATH_ListGetRaw(stList, i),
                    sPrefix, sSuffix, oPC);
            }
            break;
        }
    }
}
