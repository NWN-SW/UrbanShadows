#include "spell_dmg_inc"

int GetEleDamageType(string sDamageType)
{
    int nDamageType;
    if(sDamageType == "Fire")
    {
        nDamageType = DAMAGE_TYPE_FIRE;
        return nDamageType;
    }
    else if(sDamageType == "Cold")
    {
        nDamageType = DAMAGE_TYPE_COLD;
        return nDamageType;
    }
    else if(sDamageType == "Electric")
    {
        nDamageType = DAMAGE_TYPE_ELECTRICAL;
        return nDamageType;
    }
    else if(sDamageType == "Sonic")
    {
        nDamageType = DAMAGE_TYPE_SONIC;
        return nDamageType;
    }
    else if(sDamageType == "Acid")
    {
        nDamageType = DAMAGE_TYPE_ACID;
        return nDamageType;
    }
    else if(sDamageType == "Holy")
    {
        nDamageType = DAMAGE_TYPE_DIVINE;
        return nDamageType;
    }
    else if(sDamageType == "Negative")
    {
        nDamageType = DAMAGE_TYPE_NEGATIVE;
        return nDamageType;
    }
    else if(sDamageType == "Magic")
    {
        nDamageType = DAMAGE_TYPE_MAGICAL;
        return nDamageType;
    }
    else
    {
        return nDamageType;
    }
}

void main()
{
    //Global Variables
    object oMaster = GetMaster(OBJECT_SELF);
    string sTag;
    string sTier;

    //SendMessageToPC(GetFirstPC(), "My master is " + GetName(oMaster));
    int nBonus = GetSummFocus(oMaster);
    int nAC;
    int nAttack;
    int nDamage;
    int nEleDam;
    int nSaves;
    int nHP;
    string sElement = GetLocalString(OBJECT_SELF, "BONUS_DAMAGE_TYPE");
    int nDamageType = GetEleDamageType(sElement);
    int nCheck = GetLocalInt(OBJECT_SELF, "ALREADY_SCALED");

    //Set Faction to PC
    object oPC = GetFirstPC();
    ChangeFaction(OBJECT_SELF, oPC);

    //Make sure we have a tier if oMaster is still empty
    if(oMaster == OBJECT_INVALID)
    {
        oMaster = GetLocalObject(OBJECT_SELF, "MY_SUMMON_MASTER");
    }

    if(oMaster == OBJECT_INVALID)
    {
        sTag = GetTag(OBJECT_SELF);
        sTier = GetStringRight(sTag, 2);

        if(sTier == "T4")
        {
            nBonus = 4;
        }
        else if(sTier == "T3")
        {
            nBonus = 3;
        }
        else if(sTier == "T2")
        {
            nBonus = 2;
        }
        else if(sTier == "T1")
        {
            nBonus = 1;
        }
    }

    //If buffs already applied, leave.
    if(nCheck != 0)
    {
        return;
    }

    //Set Damage Bonus Damage is base (5 + (nDamage * 2) + nBonusDamage)
    if(nBonus == 1)
    {
        nDamage = DAMAGE_BONUS_5;
    }
    else if(nBonus == 2)
    {
        nDamage = DAMAGE_BONUS_10;
    }
    else if(nBonus == 3)
    {
        nDamage = DAMAGE_BONUS_15;
    }
    else if(nBonus == 4)
    {
        nDamage = DAMAGE_BONUS_20;
    }

    //Damage amounts
    nEleDam = nDamage;
    //Little loop for random physical damage type
    int nRandom = d4(1);
    if(nRandom == 3)
    {
        nRandom = 4;
    }
    //Create effects
    effect eDamage = EffectDamageIncrease(nDamage, nRandom);
    effect eEleDamage = EffectDamageIncrease(nEleDam, nDamageType);

    //Set Attack Bonus
    effect eAttack;
    if(nBonus == 1)
    {
        nAttack = 0;
        eAttack = EffectAttackIncrease(nAttack);
    }
    else if(nBonus == 2)
    {
        nAttack = 5;
        eAttack = EffectAttackIncrease(nAttack);
    }
    else if(nBonus == 3)
    {
        nAttack = 10;
        eAttack = EffectAttackIncrease(nAttack);
    }
    else if(nBonus == 4)
    {
        nAttack = 15;
        eAttack = EffectAttackIncrease(nAttack);
    }

    //Set CON Bonus
    effect eCON;
    if(nBonus == 1)
    {
        nHP = 3;
        eCON = EffectAbilityIncrease(ABILITY_CONSTITUTION, nHP);
    }
    else if(nBonus == 2)
    {
        nHP = 6;
        eCON = EffectAbilityIncrease(ABILITY_CONSTITUTION, nHP);
    }
    else if(nBonus == 3)
    {
        nHP = 9;
        eCON = EffectAbilityIncrease(ABILITY_CONSTITUTION, nHP);
    }
    else if(nBonus == 4)
    {
        nHP = 12;
        eCON = EffectAbilityIncrease(ABILITY_CONSTITUTION, nHP);
    }

    //Set AC Bonus
    nAC = 5 * nBonus;

    effect eAC1 = EffectACIncrease(nAC, AC_DODGE_BONUS);
    effect eAC2 = EffectACIncrease(0, AC_DEFLECTION_BONUS);
    effect eAC3 = EffectACIncrease(nAC, AC_ARMOUR_ENCHANTMENT_BONUS);

    //Set Saves
    effect eSaves;
    if(nBonus == 1)
    {
        nSaves = 5;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nBonus == 2)
    {
        nSaves = 15;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nBonus == 3)
    {
        nSaves = 25;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }
    else if(nBonus == 4)
    {
        nSaves = 35;
        eSaves = EffectSavingThrowIncrease(SAVING_THROW_ALL, nSaves);
    }

    //Skills
    int nSkillAmount = nBonus * 10;
    if(nSkillAmount < 20)
    {
        nSkillAmount = 20;
    }
    effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkillAmount);

    //Make all effects supernatural
    effect eLink = EffectLinkEffects(eAC1, eAttack);
    eLink = EffectLinkEffects(eLink, eAC2);
    eLink = EffectLinkEffects(eLink, eAC3);
    eLink = EffectLinkEffects(eLink, eSaves);
	if (GetLocalInt(OBJECT_SELF,"sNoAtkBonusSum") ==0)
	{
		eLink = EffectLinkEffects(eLink, eEleDamage);
		eLink = EffectLinkEffects(eLink, eDamage);
	}
    eLink = EffectLinkEffects(eLink, eCON);
    eLink = EffectLinkEffects(eLink, eSkill);
    eLink = SupernaturalEffect(eLink);

    //Apply Effects
    float fDelay = 1.0;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF));
    SetLocalInt(OBJECT_SELF, "ALREADY_SCALED", 1);

    //Set their anime and stamina to 50 per tier.
    DelayCommand(fDelay, SetLocalInt(OBJECT_SELF, "PC_ANIMA_MAIN", (nBonus * 50) + 50));
    DelayCommand(fDelay, SetLocalInt(OBJECT_SELF, "PC_ANIMA_CURRENT", (nBonus * 50) + 50));
    DelayCommand(fDelay, SetLocalInt(OBJECT_SELF, "PC_STAMINA_MAIN", (nBonus * 50) + 50));
    DelayCommand(fDelay, SetLocalInt(OBJECT_SELF, "PC_STAMINA_CURRENT", (nBonus * 50) + 50));
}
