#include "inc_timer"

void main()
{
    //Run Filth Hive spawner
    ExecuteScript("tsw_filth_spawn");

    int nCount = 0;
    int nRandom;
    object oPC = GetEnteringObject();
    object oWP = GetObjectByTag("CIVILIAN_SPAWN", nCount);
    int nGender = Random(2);
    string sRef;

    //Set timer for this attempt
    if(GetTimerEnded("CIVILIAN_COOLDOWN", OBJECT_SELF))
    {
        SetTimer("CIVILIAN_COOLDOWN", 310, OBJECT_SELF);
    }
    else
    {
        return;
    }

    //Determine gender of civilian
    if(nGender == 0)
    {
        sRef = "civi_rescue_m";
    }
    else
    {
        sRef = "civi_rescue_f";
    }

    //Loop through waypoints. 16% chance to spawn a civilian.
    while(oWP != OBJECT_INVALID)
    {
        nRandom = d6(1);
        if(GetArea(oWP) == GetArea(OBJECT_SELF))
        {
            if(nRandom == 2)
            {
                object oCiv = CreateObject(OBJECT_TYPE_CREATURE, sRef, GetLocation(oWP));
                SetLocalInt(oCiv, "CIVILIAN_TIER", 3);
                return;
            }
        }
        nCount = nCount + 1;
        oWP = GetObjectByTag("CIVILIAN_SPAWN", nCount);
    }
}
