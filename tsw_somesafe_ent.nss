#include "utl_i_sqlplayer"



void main()
{
    object oPC = GetEnteringObject();
    int nBagCheck = SQLocalsPlayer_GetInt(oPC, "HAS_DICEBAG");
    //Clear inventory
    if(nBagCheck != 1)
    {
        object oItem = GetFirstItemInInventory(oPC);
        while(oItem != OBJECT_INVALID)
        {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory(oPC);
        }
    }
    if (GetLocalInt(oPC,"iMarkedForDeath") == 1)
    {

        AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("dreamspawn"))));

    }
}
