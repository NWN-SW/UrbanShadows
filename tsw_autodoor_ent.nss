void main()
{
    string sVariable = GetLocalString(OBJECT_SELF, "AUTO_DOOR_TAG");
    object oDoor = GetNearestObjectByTag(sVariable);

    AssignCommand(oDoor, ActionOpenDoor(oDoor));
}
