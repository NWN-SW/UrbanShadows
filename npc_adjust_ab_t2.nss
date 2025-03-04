void main()
{
    object oEnemy = GetAttackTarget(OBJECT_SELF);
    int nAC = GetAC(oEnemy);

    //30
    //Make sure the target's AC is higher than our base AB.
    if(nAC >= 40)
    {
        //Math to get the bonus AB for the creature based on their target's AC.
        //20% chance to hit every round.
        int nBonus = nAC - 36;
        int nType = 0;
        effect eBonus = EffectAttackIncrease(nBonus, ATTACK_BONUS_MISC);
        effect eCheck = GetFirstEffect(OBJECT_SELF);

        //Put a cap on nBonus.
        if(nBonus > 8)
        {
            nBonus = 8;
        }
        //Remove any old attack bonus effect.
        while(GetIsEffectValid(eCheck))
        {
            nType = GetEffectType(eCheck);
            if(nType == 40)
            {
                RemoveEffect(OBJECT_SELF, eCheck);
            }
            eCheck = GetNextEffect(OBJECT_SELF);
        }
        //Apply new attack bonus.
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBonus, OBJECT_SELF, 120.0);
    }
    ExecuteScript("nw_c2_default3", OBJECT_SELF);
}
