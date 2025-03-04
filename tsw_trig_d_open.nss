void main()
{

    string sGetDoorOpen = GetLocalString(OBJECT_SELF,"sDoorTrigger");
    string sGetMessage = GetLocalString(OBJECT_SELF,"sMessageDoorOpen");
    object oAreaDoorToOpen = GetNearestObjectByTag(sGetDoorOpen);

    if (GetIsObjectValid(oAreaDoorToOpen) && GetArea(oAreaDoorToOpen) == GetArea(OBJECT_SELF))
    {
        ActionOpenDoor(oAreaDoorToOpen);
		object oPC = GetEnteringObject();
        if (sGetMessage != "" && GetLocalInt(oPC,sGetMessage) ==0)
        {
           FloatingTextStringOnCreature(sGetMessage, oPC, FALSE);
           SetLocalInt(oPC,sGetMessage,1);
           DelayCommand(180.0f, DeleteLocalInt(oPC,sGetMessage));
        }
    }
}
