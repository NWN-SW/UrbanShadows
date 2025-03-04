/* areacleanup script
checks the area that it was called for for the presence of pc's,
if there aren't any then it systematically cleans up the area
of extra encounters and loot
*/
void debug(string dstring)
{
    int isdebug = 0;
    if (isdebug == 1)
        SendMessageToPC(GetFirstPC(), dstring);
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
            oQuestObjectInArea = GetNearestObjectByTag(sQuestObjectRef);
            iWhileCount=2;
            while (oQuestObjectInArea != OBJECT_INVALID)
            {
                AssignCommand(oQuestObjectInArea,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                DeleteLocalInt(oQuestObjectInArea, "ON_COOLDOWN");
                oQuestObjectInArea=GetNearestObjectByTag(sQuestObjectRef,OBJECT_SELF,iWhileCount);
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

void main()
{
    object oPC = GetFirstPC();

    CleanUpSpecialInteractions();
    DeleteLocalInt(OBJECT_SELF,"iProgressQuest");
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
            case OBJECT_TYPE_DOOR:
                ActionCloseDoor(oObject);
                   if ( GetLockLockable(oObject))
                   {
                        ActionLockObject(oObject);
                   }
            break;

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
