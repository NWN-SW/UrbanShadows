void main()
{
    //Ensure minions don't run too far from master.
    string sMasterTag = GetLocalString(OBJECT_SELF, "FILTH_MASTER_TAG");
    object oMaster = GetNearestObjectByTag(sMasterTag);
    float fDistance = GetDistanceToObject(oMaster);
    int nCounter = GetLocalInt(OBJECT_SELF, "FILTH_TETHER_COUNT");

    if(fDistance > 15.0)
    {
        ActionMoveToObject(oMaster, TRUE, 4.0);
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "FILTH_TETHER_COUNT", nCounter);
    }

    if(nCounter >= 3 || !LineOfSightObject(OBJECT_SELF, oMaster))
    {
        ClearAllActions();
        ActionJumpToObject(oMaster);
        SetLocalInt(OBJECT_SELF, "FILTH_TETHER_COUNT", 0);
    }

    ExecuteScript("x2_def_heartbeat");
}
