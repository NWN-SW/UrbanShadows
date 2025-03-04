//Closes a door after 30 seconds and locks it. Mainly used for boss rooms.
void main()
{
    object oPC = GetFirstPC();
    object oArea = GetArea(OBJECT_SELF);
    int iDoorDelay = GetLocalInt(OBJECT_SELF, "DOOR_DELAY");

    if(iDoorDelay == 6)
    {
        ActionCloseDoor(OBJECT_SELF);
        SetLocked(OBJECT_SELF, TRUE);
        SetLocalInt(OBJECT_SELF, "DOOR_DELAY", 0);
    }
    else if (GetIsOpen(OBJECT_SELF))
    {
        iDoorDelay = iDoorDelay + 1;
        SetLocalInt(OBJECT_SELF, "DOOR_DELAY", iDoorDelay);
    }
}

