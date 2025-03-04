#include "inc_timer"

void main()
{
    string sScript = GetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_EXIT);
    if(sScript != "her_onexit")
    {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_EXIT, "her_onexit");
    }
/* OLD CHUNK
    object oOrigin = GetFirstObjectInArea(OBJECT_SELF);
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetFirstPC();
    string sVarName = "iLocal";
    int iCount = 0;
    int iCheck = 0;
    int iLocalVal = 1;
    int iLocal = GetLocalInt(OBJECT_SELF, sVarName);
    object oCreature = GetNearestCreature(4, TRUE, oOrigin, iCount);
    object oCorpse = GetNearestCreature(4, FALSE, oOrigin, iCount);

    //Check for players and DM avatars.
    while(oPC != OBJECT_INVALID)
    {
        if(GetArea(oPC) == oArea)
        {
            iCheck = 1;
            SetLocalInt(OBJECT_SELF, sVarName, iLocalVal);
            break;
        }
        oPC = GetNextPC();
    }

    //Check if any creatures are possessed by a DM.
    while(oCreature != OBJECT_INVALID && iCheck != 1)
    {
        if(GetIsDMPossessed(oCreature))
        {
            iCheck = 1;
            SetLocalInt(OBJECT_SELF, sVarName, iLocalVal);
            break;
        }
        oCreature = GetNearestCreature(4, TRUE, oOrigin, ++iCount);
    }

    //If iCheck isn't set due to empty area, destroy all creatures.
    if(iCheck != 1 && iLocal >= 50)
    {
        iCount = 0;
        oCreature = GetNearestCreature(4, TRUE, oOrigin, ++iCount);
        oCorpse = GetNearestCreature(4, FALSE, oOrigin, iCount);
        while(oCreature != OBJECT_INVALID)
        {
            DestroyObject(oCreature);
            DestroyObject(oCorpse);
            oCreature = GetNearestCreature(4, TRUE, oOrigin, ++iCount);
            oCorpse = GetNearestCreature(4, FALSE, oOrigin, iCount);
            SetLocalInt(OBJECT_SELF, sVarName, iLocalVal);
        }
    }
    else if(iCheck != 1)
    {
        iLocal = iLocal + iLocalVal;
        SetLocalInt(OBJECT_SELF, sVarName, iLocal);
    }
*/
}




