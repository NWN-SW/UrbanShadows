void main()
{
    string sVariable = GetLocalString(OBJECT_SELF, "DOOR_LOCK_TAG");
    object oDoor = GetNearestObjectByTag(sVariable);
    int nStatus = GetLocalInt(oDoor, "DOOR_STATUS");

    if(nStatus == 1)
    {
        //Open door and unlock it
        SetLocked(oDoor, FALSE);
        AssignCommand(oDoor, ActionCloseDoor(oDoor));
        SetLocalInt(oDoor, "DOOR_STATUS", 0);
    }
    else
    {
        //Close door and lock it
        AssignCommand(oDoor, ActionCloseDoor(oDoor));
        SetLocked(oDoor, TRUE);
        SetLocalInt(oDoor, "DOOR_STATUS", 1);
    }


    //Lever animation
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(1.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
