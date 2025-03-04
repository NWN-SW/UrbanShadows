#include "inc_timer"


void debug(string dstring)
{
    int isdebug = 0;
    if (isdebug == 1)
        SendMessageToPC(GetFirstPC(), dstring);
}

void CloseAllDoorsAndLock()
{
    object oDoor=GetFirstObjectInArea(OBJECT_SELF,OBJECT_TYPE_DOOR);
    while (oDoor != OBJECT_INVALID)
    {
        AssignCommand(oDoor,ActionCloseDoor(oDoor));
        if ( GetLockLockable(oDoor))
        {
            AssignCommand(oDoor,ActionLockObject(oDoor));
        }

        oDoor = GetNextObjectInArea(OBJECT_SELF,OBJECT_TYPE_DOOR);

    }
}

void CleanUpSpecialInteractions ()
{

    int iNbQuestObject = GetLocalInt(OBJECT_SELF,"iNbQuestObject");
    if (iNbQuestObject !=0)
    {
        string sQuestObjectRef;
        object oQuestObjectInArea;
        int iCount;
        int iWhileCount;

        for (iCount=0;iCount<iNbQuestObject;iCount++)
        {
            sQuestObjectRef = GetLocalString(OBJECT_SELF,"sQuestObject"+IntToString(iCount));
            oQuestObjectInArea = GetNearestObjectByTag(sQuestObjectRef,GetFirstObjectInArea(OBJECT_SELF),1);
            effect eObjectVFX=GetFirstEffect(oQuestObjectInArea);
            iWhileCount=2;
            while (oQuestObjectInArea != OBJECT_INVALID)
            {
                while(GetIsEffectValid(eObjectVFX))
                {
                    RemoveEffect(oQuestObjectInArea,GetFirstEffect(oQuestObjectInArea));
                    eObjectVFX = GetNextEffect(oQuestObjectInArea);
                }

                AssignCommand(oQuestObjectInArea,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                DeleteLocalInt(oQuestObjectInArea, "ON_COOLDOWN");
                oQuestObjectInArea=GetNearestObjectByTag(sQuestObjectRef,GetFirstObjectInArea(OBJECT_SELF),iWhileCount);
                iWhileCount++;

            }
        }
    }
}

void TrashObject(object oObject)
{
    if (GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE) {
        object oItem = GetFirstItemInInventory(oObject);
        while (GetIsObjectValid(oItem))
        {
            TrashObject(oItem);
           oItem = GetNextItemInInventory(oObject);
        }
    }
    else
    AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE, FALSE));
    DestroyObject(oObject);
}

void CloseAndLockDoorResetQuest()
{

    object oPC = GetFirstPC();

    CleanUpSpecialInteractions();
    CloseAllDoorsAndLock();
    if (GetLocalInt(OBJECT_SELF,"iProgressQuest") > 0)
    {
        SetLocalInt(OBJECT_SELF,"iProgressQuest",0);
    }

    while (oPC != OBJECT_INVALID)
    {
        if (OBJECT_SELF == GetArea(oPC))
            return;
        else oPC = GetNextPC();
    }

    object oObject = GetFirstObjectInArea(OBJECT_SELF);

    while (oObject != OBJECT_INVALID)
    {
        if (GetIsEncounterCreature(oObject) && FindSubString(GetTag(oObject), "_BOSS") == -1)
            DestroyObject(oObject);

        int iObjectType = GetObjectType(oObject);

        switch (iObjectType)
        {

            case OBJECT_TYPE_PLACEABLE:
                if (GetTag(oObject) != "BodyBag")
                {
                    break;
                }

            case OBJECT_TYPE_ITEM:
                TrashObject(oObject);
                break;
        }
        oObject = GetNextObjectInArea(OBJECT_SELF);
    }
}

void main()
{

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
            SetLocalInt(OBJECT_SELF,"iAreaWasVisited",1);
            return;
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
            return;
        }
        oCreature = GetNearestCreature(4, TRUE, oOrigin, ++iCount);
    }

        if (GetLocalInt(OBJECT_SELF,"iAreaWasVisited")==1)
    {

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
            CloseAndLockDoorResetQuest();
            DeleteLocalInt(OBJECT_SELF, sVarName);
            DeleteLocalInt(OBJECT_SELF,"iAreaWasVisited");
        }
        else if(iCheck != 1 && iLocal<=50 )
        {
            iLocal = iLocal + iLocalVal;
            SetLocalInt(OBJECT_SELF, sVarName, iLocal);
        }



    }
}




