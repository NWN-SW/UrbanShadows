void main()
{
    //Get the Fort Lord.
    object oTarget = GetObjectByTag("WP_FortLord_WZ_01");

    //Attack Lord if not in combat.
    if(!GetIsInCombat(OBJECT_SELF))
    {
        ClearAllActions(FALSE);
        ActionDoCommand(ActionMoveToObject(oTarget, TRUE));
    }
}

