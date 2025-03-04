void main()
{
    int nTier = GetLocalInt(OBJECT_SELF, "CREATURE_DEF_TIER");
    int nAC;
    int nSaves;
    int nAttack;
    int nDamage;
    int nEleDamage;
    int nBonusDamage = 1;
    string sDamageType;
    int nDamageType;
    int nCheck = GetLocalInt(OBJECT_SELF, "ALREADY_SCALED");

    if(nCheck != 0)
    {
        return;
    }

    //If buffs already applied, leave.

    //Set their anime and stamina to 50 per tier.
    SetLocalInt(OBJECT_SELF, "PC_ANIMA_MAIN", nTier * 50);
    SetLocalInt(OBJECT_SELF, "PC_ANIMA_CURRENT", nTier * 50);
    SetLocalInt(OBJECT_SELF, "PC_STAMINA_MAIN", nTier * 50);
    SetLocalInt(OBJECT_SELF, "PC_STAMINA_CURRENT", nTier * 50);

    //Get bonus damage type if any.
    sDamageType = GetLocalString(OBJECT_SELF, "BONUS_DAMAGE_TYPE");
    if(sDamageType == "Fire")
    {
        nDamageType = DAMAGE_TYPE_FIRE;
    }
    else if(sDamageType == "Cold")
    {
        nDamageType = DAMAGE_TYPE_COLD;
    }
    else if(sDamageType == "Electric")
    {
        nDamageType = DAMAGE_TYPE_ELECTRICAL;
    }
    else if(sDamageType == "Sonic")
    {
        nDamageType = DAMAGE_TYPE_SONIC;
    }
    else if(sDamageType == "Acid")
    {
        nDamageType = DAMAGE_TYPE_ACID;
    }
    else if(sDamageType == "Holy")
    {
        nDamageType = DAMAGE_TYPE_DIVINE;
    }
    else if(sDamageType == "Negative")
    {
        nDamageType = DAMAGE_TYPE_NEGATIVE;
    }

    //Set Temporary HP
    int nTempHP;
    if(nTier == 1)
    {
        nTempHP = 5;
    }
    else if(nTier == 2)
    {
        nTempHP = 5;
    }
    else if(nTier == 3)
    {
        nTempHP = 5;
    }
    else if(nTier == 4)
    {
        nTempHP = 100;
    }
    else if(nTier == 5)
    {
        nTempHP = 200;
    }
    else if(nTier == 6)
    {
        nTempHP = 2000;
    }
    else if(nTier == 7)
    {
        nTempHP = 3000;
    }

    //Set Damage Bonus Damage is base (5 + (nDamage * 2) + nBonusDamage)
    if(nTier == 1)
    {
        nDamage = DAMAGE_BONUS_1;
    }
    else if(nTier == 2)
    {
        nDamage = DAMAGE_BONUS_3;
    }
    else if(nTier == 3)
    {
        nDamage = DAMAGE_BONUS_7;
    }
    else if(nTier == 4)
    {
        nDamage = DAMAGE_BONUS_10;
    }
    else if(nTier == 5)
    {
        nDamage = DAMAGE_BONUS_14;
    }
    else if(nTier == 6)
    {
        nDamage = DAMAGE_BONUS_17;
        nBonusDamage = DAMAGE_BONUS_10;
    }
    else if(nTier == 7)
    {
        nDamage = DAMAGE_BONUS_20;
        nBonusDamage = DAMAGE_BONUS_20;
    }

    //Damage amounts
    nEleDamage = nDamage;
    //Little loop for random physical damage type
    int nRandom = d4(1);
    if(nRandom == 3)
    {
        nRandom = 4;
    }
    //Create effects
    effect eDamage = EffectDamageIncrease(nDamage, nRandom);
    effect eEleDamage = EffectDamageIncrease(nEleDamage, nDamageType);
    effect eBonusDamage = EffectDamageIncrease(nBonusDamage, DAMAGE_TYPE_MAGICAL);
    effect eHP = EffectTemporaryHitpoints(nTempHP);

    //Set Attack Bonus
    //Penalty for tier one to three.
    effect eAttack;
    if(nTier == 1)
    {
        nAttack = 20;
        eAttack = EffectAttackDecrease(nAttack);
    }
    else if(nTier == 2)
    {
        nAttack = 17;
        eAttack = EffectAttackDecrease(nAttack);
    }
    else if(nTier == 3)
    {
        nAttack = 12;
        eAttack = EffectAttackDecrease(nAttack);
    }
    else if(nTier == 4)
    {
        nAttack = 3;
        eAttack = EffectAttackDecrease(nAttack);
    }
    else if(nTier == 5)
    {
        nAttack = 6;
        eAttack = EffectAttackIncrease(nAttack);
    }
    else if(nTier == 6)
    {
        nAttack = 15;
        eAttack = EffectAttackIncrease(nAttack);
    }
    else if(nTier == 7)
    {
        nAttack = 24;
        eAttack = EffectAttackIncrease(nAttack);
    }

    //Set AC Bonus
    nAC = 6 * nTier;
    nAC = nAC / 3;

    effect eAC1 = EffectACIncrease(nAC, AC_DODGE_BONUS);
    effect eAC2 = EffectACIncrease(nAC, AC_DEFLECTION_BONUS);
    effect eAC3 = EffectACIncrease(nAC, AC_ARMOUR_ENCHANTMENT_BONUS);

    //Set Saves
    effect eSaves;
    if(nTier == 1)
    {
        nSaves = 10;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nTier == 2)
    {
        nSaves = 20;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nTier == 3)
    {
        nSaves = 30;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nTier == 4)
    {
        nSaves = 40;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nTier == 5)
    {
        nSaves = 50;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nTier == 6)
    {
        nSaves = 60;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nTier == 7)
    {
        nSaves = 70;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }

    //Skills
    int nSkillAmount = nTier * 5;
    if(nSkillAmount < 15)
    {
        nSkillAmount = 15;
    }
    effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkillAmount);

    //Make all effects supernatural
    effect eLink = EffectLinkEffects(eAC1, eDamage);
    eLink = EffectLinkEffects(eLink, eAC2);
    eLink = EffectLinkEffects(eLink, eAC3);
    eLink = EffectLinkEffects(eLink, eSaves);
    eLink = EffectLinkEffects(eLink, eAttack);
    eLink = EffectLinkEffects(eLink, eEleDamage);
    eLink = EffectLinkEffects(eLink, eBonusDamage);
    eLink = EffectLinkEffects(eLink, eSkill);
    eLink = SupernaturalEffect(eLink);

    //Set eHP Bonuses
    eHP = SupernaturalEffect(eHP);

    //Apply Effects
    float fDelay = 1.0;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHP, OBJECT_SELF));
    SetLocalInt(OBJECT_SELF, "ALREADY_SCALED", 1);
}
