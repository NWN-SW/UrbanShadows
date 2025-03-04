//::///////////////////////////////////////////////
//:: Name: pcbl_autoclose
//:://////////////////////////////////////////////
/*
Automatically close a door when no players are in the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Lord Gates
//:: Created On: August, 2020
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
        }
}

