//agartha teleportation
#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();
    //Intro quest step
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    object oWP = GetWaypointByTag("tp_recall");
    location lWP = GetLocation(oWP);

    if(nQuest == 0)
    {
        oWP = GetWaypointByTag("tp_agartha_start");
        lWP = GetLocation(oWP);
        DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lWP)));
    }

    else
    {
        //oWP = GetWaypointByTag("tp_recall");
        //lWP = GetLocation(oWP);
        DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lWP)));
    }
}


