#include "inc_timer"

void main()
{
    int nCount = 0;
    int nRandom;
    object oPC = GetEnteringObject();
    object oWP = GetObjectByTag("FILTH_SPAWN", nCount);
    string sRef;

    //Set timer for this attempt
    if(GetTimerEnded("FILTH_COOLDOWN", OBJECT_SELF))
    {
        SetTimer("FILTH_COOLDOWN", 310, OBJECT_SELF);
    }
    else
    {
        return;
    }

    //Loop through waypoints. 10% chance to spawn Filth.
    while(oWP != OBJECT_INVALID)
    {
        nRandom = d10(1);
        if(GetArea(oWP) == GetArea(OBJECT_SELF))
        {
            if(nRandom == 2)
            {
                //Determine tier of Filth
                int nTier = GetLocalInt(oWP, "FILTH_SPAWN_TIER");
                if(nTier == 1)
                {
                    sRef = "filth_t1_hive";
                }
                else if(nTier == 2)
                {
                    sRef = "filth_t2_hive";
                }
                else if(nTier == 3)
                {
                    sRef = "filth_t3_hive";
                }
                else if(nTier == 4)
                {
                    sRef = "filth_t4_hive";
                }

                object oHive = CreateObject(OBJECT_TYPE_CREATURE, sRef, GetLocation(oWP));
                return;
            }
        }
        nCount = nCount + 1;
        oWP = GetObjectByTag("FILTH_SPAWN", nCount);
    }
}
