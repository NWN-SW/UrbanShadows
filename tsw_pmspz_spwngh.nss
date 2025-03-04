void main()
{
    object oGhostGirl = GetObjectByTag("MN_Ghost_Girl");
    object oPC = GetEnteringObject();
    object oSpawn = GetWaypointByTag("PMS_Spawn_1");
    location lSpawn = GetLocation(oSpawn);
    object oPCTest = GetFirstPC();

    //Get time
    int nTime = GetTimeHour();

    if(oGhostGirl == OBJECT_INVALID && GetIsPC(oPC))
    {
        if(nTime > 17 || nTime < 6)
        {
            CreateObject(1, "mn_ghost_girl", lSpawn, TRUE);
        }
    }
}
