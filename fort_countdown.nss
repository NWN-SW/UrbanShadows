void main()
{
    string sCountName = "COUNTDOWN_TIMER";
    string sProgress = "IN_PROGRESS";
    int nTimer = GetLocalInt(OBJECT_SELF, sCountName);
    int nProgress = GetLocalInt(OBJECT_SELF, sProgress);
    object oLordWP = GetObjectByTag("GaiaBeaconSpawn");
    object oPC = GetFirstPC();
    location lFortLord = GetLocation(oLordWP);

    if(nProgress == 0 && nTimer == 0)
    {
        /*
        while(oPC != OBJECT_INVALID)
        {
            SendMessageToPC(oPC, "Scouts have reported enemy movement near Fort Myrkur. The fort calls for aid from any available adventurers.");
            oPC = GetNextPC();
        }
        */
    }

    if(nProgress == 0 && nTimer < 15)
    {
        nTimer = nTimer + 1;
        SetLocalInt(OBJECT_SELF, sCountName, nTimer);
    }

    if(nTimer == 5)
    {
        SetLocalInt(OBJECT_SELF, sCountName, 0);
        SetLocalInt(OBJECT_SELF, sProgress, 1);
        CreateObject(1, "gaiabeacon", lFortLord, TRUE);
        SetEventScript(OBJECT_SELF, 4000, "fort_invasion");
    }
}
