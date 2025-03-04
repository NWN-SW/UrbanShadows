void main()
{
    object oOrigin = GetFirstObjectInArea(OBJECT_SELF);
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetFirstPC();
    string sVarName = "iLocal";
    int iCount = 0;
    int iCheck = 0;
    int iLocal = GetLocalInt(OBJECT_SELF, sVarName);
    object oCreature = GetNearestCreature(4, TRUE, oOrigin, iCount);
    object oCorpse = GetNearestCreature(4, FALSE, oOrigin, iCount);
    object oWP = GetWaypointByTag("tp_recall");

    //Reset Fort Variables
    string sVarStart = "DEFENSE_START";
    string sCountName = "COUNTDOWN_TIMER";
    string sProgress = "IN_PROGRESS";
    string sWave = "INVASION_WAVE";
    SetLocalInt(oArea, sVarStart, 0);
    SetLocalInt(oArea, sCountName, 0);
    SetLocalInt(oArea, sProgress, 0);
    SetLocalInt(oArea, sWave, 0);

    //Check for players and DM avatars.
    while(oPC != OBJECT_INVALID)
    {
        if(GetArea(oPC) == oArea)
        {
            SendMessageToAllDMs("Player found.");
            SetLocalInt(OBJECT_SELF, sVarName, 1);
            AssignCommand(oPC, ClearAllActions(TRUE));
            AssignCommand(oPC, ActionJumpToObject(oWP));
            iCheck = 1;
        }
        oPC = GetNextPC();
    }

    //If iCheck isn't set due to empty area, destroy all creatures.
    if(iCheck != 1 && iLocal < 6)
    {
        iCount = 0;
        SendMessageToAllDMs("No players found. Cleaning.");
        oCreature = GetNearestCreature(4, TRUE, oOrigin, ++iCount);
        oCorpse = GetNearestCreature(4, FALSE, oOrigin, iCount);
        while(oCreature != OBJECT_INVALID)
        {
            DestroyObject(oCreature);
            DestroyObject(oCorpse);
            oCreature = GetNearestCreature(4, TRUE, oOrigin, ++iCount);
            oCorpse = GetNearestCreature(4, FALSE, oOrigin, iCount);
            SetLocalInt(OBJECT_SELF, sVarName, 0);
        }
        iLocal = iLocal + 1;
        SetLocalInt(OBJECT_SELF, sVarName, iLocal);
    }
    else if(iCheck != 1 && iLocal == 6)
    {
        SetLocalInt(OBJECT_SELF, sVarName, 0);
        SetEventScript(oArea, 4000, "fort_start");
    }
}



