void main()
{
    object oEnemy = GetAttackTarget(OBJECT_SELF);
    int nAC = GetAC(oEnemy);
    int nCombat = 0;

    //Check if this creature is in combat.
    nCombat = GetIsInCombat(OBJECT_SELF);
    if(nCombat == 1)
    {
        //Make sure the target's AC is higher than our base AB.
        if(nAC >= 40)
        {
            //Math to get the bonus AB for the creature based on their target's AC.
            //10% chance to hit every round.
            int nBonus = nAC - 38;
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
    }
}
