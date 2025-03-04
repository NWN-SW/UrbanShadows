void main()
{
    //Get Waypoint
    object oTarget = GetObjectByTag("GaiaBeaconSpawn");

    //Move if not in combat.
    if(!GetIsInCombat(OBJECT_SELF))
    {
        ClearAllActions(FALSE);
        ActionDoCommand(ActionMoveToObject(oTarget, TRUE, 1.0));
    }
}

