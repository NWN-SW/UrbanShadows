//::///////////////////////////////////////////////
//:: Name: x2_close_door
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   This script does nothing right now. Just
   added as a hook in case its needed for the
   individual portal doors that appear on both
   their aborted and their end conversation normally
   scripts
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 15 2003
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetFirstPC();
    object oArea = GetArea(OBJECT_SELF);
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
            ActionCloseDoor(OBJECT_SELF);
            SetLocked(OBJECT_SELF, TRUE);
        }
}

