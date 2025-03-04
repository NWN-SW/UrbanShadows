void main()
{
    //Get the nearest player
    int nCount = 0;
    object oTarget = GetNearestCreature(1, TRUE, OBJECT_SELF, nCount);

    //Get player stealth mode.
    int nStealth;

    while(oTarget != OBJECT_INVALID)
    {
        nStealth = GetStealthMode(oTarget);

        if(!GetIsInCombat(OBJECT_SELF) && nStealth == 0 && !GetHasSpellEffect(90, oTarget) && !GetHasSpellEffect(88, oTarget) && !GetHasSpellEffect(154, oTarget) && !GetHasSpellEffect(443, oTarget))
        {
            DelayCommand(1.5, ActionDoCommand(ActionAttack(oTarget, FALSE)));
            break;
        }
        nCount++;
        oTarget = GetNearestCreature(1, TRUE, OBJECT_SELF, nCount);
    }

    ExecuteScript("tsw_loot_mobs", OBJECT_SELF);
    ExecuteScript("tsw_npc_models", OBJECT_SELF);

    if(GetTag(OBJECT_SELF) == "ast_t5_H")
    {
        ExecuteScript("npc_horror_moan1", OBJECT_SELF);
        SetObjectVisualTransform(OBJECT_SELF, 10, 2.0);
    }
}

