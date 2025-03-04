//::///////////////////////////////////////////////
//:: Name: pcbl_autoclose3
//:://////////////////////////////////////////////
/*
Automatically close a door and relock when no players are in the area.
*/

void main()
{
    object oPC = GetFirstPC();
    object oArea = GetArea(OBJECT_SELF);
    object oDoor = OBJECT_SELF;

    int iNay = 0;
    while(oPC != OBJECT_INVALID)
    {
        object oCheck = GetArea(oPC);
        if(oArea == oCheck)
        {
            iNay = 1;
            break;
        }
        oPC = GetNextPC();
    }
    if(iNay != 1)
        {
            ActionCloseDoor(oDoor);
            AssignCommand(oDoor,ActionLockObject(oDoor));

        }
}
