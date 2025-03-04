void main()
{

    string sGetDoorClose = GetLocalString(OBJECT_SELF,"sDoorTrigger");
    string sGetMessage = GetLocalString(OBJECT_SELF,"sMessageDoorClose");
    object oAreaDoorToClose = GetNearestObjectByTag(sGetDoorClose);

    if (GetIsObjectValid(oAreaDoorToClose) && GetArea(oAreaDoorToClose) == GetArea(OBJECT_SELF))
    {
        ActionCloseDoor(oAreaDoorToClose);
        object oPC = GetEnteringObject();
		
        if (sGetMessage != "" && GetLocalInt(oPC,sGetMessage) ==0)
        {
           FloatingTextStringOnCreature(sGetMessage, oPC, FALSE);
           SetLocalInt(oPC,sGetMessage,1);
           DelayCommand(180.0f, DeleteLocalInt(oPC,sGetMessage));
        }
    }
}
