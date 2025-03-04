void main()
{
    //Check actions. If none, move toward enemy.
    object oTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    float fDistance = GetDistanceToObject(oTarget);
    if(GetCurrentAction(OBJECT_SELF) != ACTION_ATTACKOBJECT && GetCurrentAction(OBJECT_SELF) != ACTION_CASTSPELL && fDistance >= 10.0)
    {
        ClearAllActions(FALSE);
        ActionMoveToObject(oTarget, TRUE, 9.0);
    }

    ExecuteScript("nw_c2_default3", OBJECT_SELF);
}
