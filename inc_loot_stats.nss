                #include "inc_loot_rolls"
#include "tsw_class_consts"

void GenGloveStats(string sRarity, object oItem, int nUptier)
{
    int nQnty;
    int nACRoll;
    int nAbilityRoll;
    int nRandom;
    int nAbility;
    int nAbility2;
    int nSpellFail;
    int nSpellFailBase;
    int nResistType;
    int nResistAmount;
    int nSavingThrow;
    int nSavingRoll;
    int nRegen;
    int nLoop;
    itemproperty ipMain;
    //Get item resref
    string sResRef = GetResRef(oItem);

    //We'll use these to make sure we don't try to apply the same property twice.
    int oneDone = 0;
    int twoDone = 0;
    int threeDone = 0;
    int fourDone = 0;
    int fiveDone = 0;
    int sixDone = 0;
    int sevenDone = 0;
    int eightDone = 0;
    int nineDone = 0;
    int tenDone = 0;
    int elevenDone = 0;

    //Determine how many times we'll loop through to add properties to an item.
    if(sRarity == "Common")
    {
        nQnty = 4;
    }
    else if(sRarity == "Uncommon")
    {
        nQnty = 6;
    }
    else if(sRarity == "Rare")
    {
        nQnty = 8;
    }
    else if(sRarity == "Legendary")
    {
        nQnty = 10;
    }

    if(nUptier == 1)
    {
        nQnty++;
        nQnty++; //Uptier by adding 2 more properties
    }

    //SendMessageToPC(GetFirstPC(), "1");

    //Make sure the spell fail range is correct for the given rarity.
    if(sRarity == "Common")
    {
        nSpellFailBase = 9;
    }
    else if(sRarity == "Uncommon")
    {
        nSpellFailBase = 8;
    }
    else if(sRarity == "Rare")
    {
        nSpellFailBase = 7;
    }
    else if(sRarity == "Legendary")
    {
        nSpellFailBase = 6;
    }

    //SendMessageToPC(GetFirstPC(), "2");

    //Random roll to determine damage resistance type
    nRandom = Random(11);
    switch(nRandom)
    {
        case 0:
            //Acid
            nResistType = 6;
            break;
        case 1:
            //Bludge
            nResistType = 0;
            break;
        case 2:
            //Pierce
            nResistType = 1;
            break;
        case 3:
            //Slash
            nResistType = 2;
            break;
        case 4:
            //Fire
            nResistType = 10;
            break;
        case 5:
            //Cold
            nResistType = 7;
            break;
        case 6:
            //Elec
            nResistType = 9;
            break;
        case 7:
            //Sonic
            nResistType = 13;
            break;
        case 8:
            //Neg
            nResistType = 11;
            break;
        case 9:
            //Div
            nResistType = 8;
            break;
        case 10:
            //Mag
            nResistType = 5;
            break;
    }

    //SendMessageToPC(GetFirstPC(), "3");

    //Resist amounts
    if(sRarity == "Common")
    {
        nResistAmount = 1;
    }
    else if(sRarity == "Uncommon")
    {
        nResistAmount = 1;
    }
    else if(sRarity == "Rare")
    {
        nResistAmount = 1;
    }
    else if(sRarity == "Legendary")
    {
        nResistAmount = 2;
    }

    //Get regeneration amount based on rarity.
    if(sRarity == "Common")
    {
        nRegen = 1;
    }
    else if(sRarity == "Uncommon")
    {
        nRegen = 1;
    }
    else if(sRarity == "Rare")
    {
        nRegen = 1;
    }
    else if(sRarity == "Legendary")
    {
        nRegen = 2;
    }

    //SendMessageToPC(GetFirstPC(), "4");

    //Saving Throw Roll
    if(sRarity == "Common")
    {
        nSavingRoll = 4;
    }
    else if(sRarity == "Uncommon")
    {
        nSavingRoll = 6;
    }
    else if(sRarity == "Rare")
    {
        nSavingRoll = 8;
    }
    else if(sRarity == "Legendary")
    {
        nSavingRoll = 12;
    }

    //SendMessageToPC(GetFirstPC(), "5");

    //Skill Bonuses Type and Amount
    int nSkillBonus;
    if(sRarity == "Common")
    {
        nSkillBonus = 15;
    }
    else if(sRarity == "Uncommon")
    {
        nSkillBonus = 20;
    }
    else if(sRarity == "Rare")
    {
        nSkillBonus = 25;
    }
    else if(sRarity == "Legendary")
    {
        nSkillBonus = 30;
    }

    //SendMessageToPC(GetFirstPC(), "6");

    int nSkillType;
    nRandom = Random(8);
    switch(nRandom)
    {
        case 0:
            //Discipline
            nSkillType = SKILL_DISCIPLINE;
            break;
        case 1:
            //Concentration
            nSkillType = SKILL_CONCENTRATION;
            break;
        case 2:
            //Hide
            nSkillType = SKILL_HIDE;
            break;
        case 3:
            //Move Silently
            nSkillType = SKILL_MOVE_SILENTLY;
            break;
        case 4:
            //Spot
            nSkillType = SKILL_SPOT;
            break;
        case 5:
            //Listen
            nSkillType = SKILL_LISTEN;
            break;
        case 6:
            //Spellcraft
            nSkillType = SKILL_SPELLCRAFT;
            break;
        case 7:
            //Tumble
            nSkillType = SKILL_TUMBLE;
            break;
    }

    //SendMessageToPC(GetFirstPC(), "7");

    //Stamina and Anima amounts
    int nResourceBonus;
    if(sRarity == "Common")
    {
        nResourceBonus = 2;
    }
    else if(sRarity == "Uncommon")
    {
        nResourceBonus = 3;
    }
    else if(sRarity == "Rare")
    {
        nResourceBonus = 4;
    }
    else if(sRarity == "Legendary")
    {
        nResourceBonus = 5;
    }

    //SendMessageToPC(GetFirstPC(), "8");

    //Stamina and Anima Random
    int nResource;
    nRandom = Random(2);
    switch(nRandom)
    {
        case 0:
            //Discipline
            nResource = TSW_SKILL_ANIMA;
            break;
        case 1:
            //Concentration
            nResource = TSW_SKILL_STAMINA;
            break;
    }

    //SendMessageToPC(GetFirstPC(), "9");

    //Determine which ability score will get the bonus
    nAbility = Random(3);
    nAbility2 = Random(3) + 3;

    if(nAbility == nAbility2)
    {
        while(nAbility == nAbility2)
        {
            nAbility2 = Random(6);
        }
    }

    //SendMessageToPC(GetFirstPC(), "10");
    int nCounter = 0;

    //Randomly determine the armour properties.
    while(nLoop < nQnty)
    {
        //Determine AC bonus
        nACRoll = GetACRoll(sRarity);
        string sItemType = GetLocalString(oItem, "BASE_ITEM_TYPE");
        if(sItemType != "Armour" && sItemType != "Gear")
        {
            oneDone = 1;
            nLoop = nLoop + 1;
        }
        //Determine ability score bonus
        nAbilityRoll = GetAbilityRoll(sRarity);
        //Determine the amount of negative spell-failure
        nSpellFail = nSpellFailBase;
        //Determine which saving throw gets the bonus. We'll use nQnty to determine how much to increase the save.
        nSavingThrow = Random(3)+1;
        //Determine which properties are added to the item
        nRandom = d10(1);

        //SendMessageToPC(GetFirstPC(), IntToString(nQnty));
        //SendMessageToPC(GetFirstPC(), IntToString(nRandom));
        //SendMessageToPC(GetFirstPC(), IntToString(nLoop));

        if(nRandom == 1 && oneDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add AC.");
            ipMain = ItemPropertyACBonus(nACRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            oneDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 2 && twoDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Ability.");
            ipMain = ItemPropertyAbilityBonus(nAbility, nAbilityRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            twoDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 3 && threeDone != 1)
        {
            //SendMessageToPC(GetFirstPC(), "Attempting to add Saving Throw.");
            ipMain = ItemPropertyDamageResistance(nResistType, nResistAmount);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            threeDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 4 && fourDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Resist.");
            ipMain = ItemPropertyBonusSavingThrow(SAVING_THROW_FORT, nSavingRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            fourDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 5 && fiveDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Saving Throw.");
            ipMain = ItemPropertyBonusSavingThrow(SAVING_THROW_REFLEX, nSavingRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            fiveDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 6 && sixDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Regen.");
            ipMain = ItemPropertyRegeneration(nRegen);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            sixDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 7 && sevenDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Skill.");
            ipMain = ItemPropertySkillBonus(nSkillType, nSkillBonus);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            sevenDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 8 && eightDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Ability 2.");
            ipMain = ItemPropertyAbilityBonus(nAbility2, nAbilityRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            eightDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 9 && nineDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Resource.");
            ipMain = ItemPropertySkillBonus(nResource, nResourceBonus);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            nineDone = 1;
            nLoop = nLoop + 1;
        }

        if(nRandom == 10 && tenDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Saving Throw.");
            ipMain = ItemPropertyBonusSavingThrow(SAVING_THROW_WILL, nSavingRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            tenDone = 1;
            nLoop = nLoop + 1;
        }
    }
}

void GenArmourStats(string sRarity, object oItem, int nUptier)
{
    int nQnty;
    int nACRoll;
    int nAbilityRoll;
    int nRandom;
    int nAbility;
    int nAbility2;
    int nSpellFail;
    int nSpellFailBase;
    int nResistType;
    int nResistAmount;
    int nSavingThrow;
    int nSavingRoll;
    int nRegen;
    int nLoop = 0;
    itemproperty ipMain;
    //Get item resref
    string sResRef = GetResRef(oItem);

    //We'll use these to make sure we don't try to apply the same property twice.
    int oneDone = 0;
    int twoDone = 0;
    int threeDone = 0;
    int fourDone = 0;
    int fiveDone = 0;
    int sixDone = 0;
    int sevenDone = 0;
    int eightDone = 0;
    int nineDone = 0;

    //Determine how many times we'll loop through to add properties to an item.
    if(sRarity == "Common")
    {
        nQnty = 2;
    }
    else if(sRarity == "Uncommon")
    {
        nQnty = 3;
    }
    else if(sRarity == "Rare")
    {
        nQnty = 4;
    }
    else if(sRarity == "Legendary")
    {
        nQnty = 5;
    }

    if(nUptier == 1)
    {
        nQnty++; //Uptier by adding 1 more properties
    }

    //Make sure the spell fail range is correct for the given rarity.
    if(sRarity == "Common")
    {
        nSpellFailBase = 9;
    }
    else if(sRarity == "Uncommon")
    {
        nSpellFailBase = 8;
    }
    else if(sRarity == "Rare")
    {
        nSpellFailBase = 7;
    }
    else if(sRarity == "Legendary")
    {
        nSpellFailBase = 6;
    }

    //Random roll to determine damage resistance type
    nRandom = Random(11);
    switch(nRandom)
    {
        case 0:
            //Acid
            nResistType = 6;
            break;
        case 1:
            //Bludge
            nResistType = 0;
            break;
        case 2:
            //Pierce
            nResistType = 1;
            break;
        case 3:
            //Slash
            nResistType = 2;
            break;
        case 4:
            //Fire
            nResistType = 10;
            break;
        case 5:
            //Cold
            nResistType = 7;
            break;
        case 6:
            //Elec
            nResistType = 9;
            break;
        case 7:
            //Sonic
            nResistType = 13;
            break;
        case 8:
            //Neg
            nResistType = 11;
            break;
        case 9:
            //Div
            nResistType = 8;
            break;
        case 10:
            //Mag
            nResistType = 5;
            break;
    }

    //Resist amounts
    if(sRarity == "Common")
    {
        nResistAmount = 1;
    }
    else if(sRarity == "Uncommon")
    {
        nResistAmount = 1;
    }
    else if(sRarity == "Rare")
    {
        nResistAmount = 1;
    }
    else if(sRarity == "Legendary")
    {
        nResistAmount = 2;
    }

    //Get regeneration amount based on rarity.
    if(sRarity == "Common")
    {
        nRegen = 1;
    }
    else if(sRarity == "Uncommon")
    {
        nRegen = 1;
    }
    else if(sRarity == "Rare")
    {
        nRegen = 1;
    }
    else if(sRarity == "Legendary")
    {
        nRegen = 2;
    }

    //Saving Throw Roll
    if(sRarity == "Common")
    {
        nSavingRoll = 4;
    }
    else if(sRarity == "Uncommon")
    {
        nSavingRoll = 6;
    }
    else if(sRarity == "Rare")
    {
        nSavingRoll = 8;
    }
    else if(sRarity == "Legendary")
    {
        nSavingRoll = 12;
    }

    //Skill Bonuses Type and Amount
    int nSkillBonus;
    if(sRarity == "Common")
    {
        nSkillBonus = 15;
    }
    else if(sRarity == "Uncommon")
    {
        nSkillBonus = 20;
    }
    else if(sRarity == "Rare")
    {
        nSkillBonus = 25;
    }
    else if(sRarity == "Legendary")
    {
        nSkillBonus = 30;
    }

    int nSkillType;
    nRandom = Random(8);
    switch(nRandom)
    {
        case 0:
            //Discipline
            nSkillType = SKILL_DISCIPLINE;
            break;
        case 1:
            //Concentration
            nSkillType = SKILL_CONCENTRATION;
            break;
        case 2:
            //Hide
            nSkillType = SKILL_HIDE;
            break;
        case 3:
            //Move Silently
            nSkillType = SKILL_MOVE_SILENTLY;
            break;
        case 4:
            //Spot
            nSkillType = SKILL_SPOT;
            break;
        case 5:
            //Listen
            nSkillType = SKILL_LISTEN;
            break;
        case 6:
            //Spellcraft
            nSkillType = SKILL_SPELLCRAFT;
            break;
        case 7:
            //Tumble
            nSkillType = SKILL_TUMBLE;
            break;
    }

    //Stamina and Anima amounts
    int nResourceBonus;
    if(sRarity == "Common")
    {
        nResourceBonus = 2;
    }
    else if(sRarity == "Uncommon")
    {
        nResourceBonus = 3;
    }
    else if(sRarity == "Rare")
    {
        nResourceBonus = 4;
    }
    else if(sRarity == "Legendary")
    {
        nResourceBonus = 5;
    }

    //Stamina and Anima Random
    int nResource;
    nRandom = Random(2);
    switch(nRandom)
    {
        case 0:
            //Discipline
            nResource = TSW_SKILL_ANIMA;
            break;
        case 1:
            //Concentration
            nResource = TSW_SKILL_STAMINA;
            break;
    }

    //Determine which ability score will get the bonus
    nAbility = Random(6);
    nAbility2 = Random(6);

    if(nAbility == nAbility2)
    {
        while(nAbility == nAbility2)
        {
            nAbility2 = Random(6);
        }
    }

    //Randomly determine the armour properties.
    while(nLoop < nQnty)
    {
        //Determine AC bonus
        nACRoll = GetACRoll(sRarity);
        string sItemType = GetLocalString(oItem, "BASE_ITEM_TYPE");
        if(sItemType != "Armour" && sItemType != "Gear")
        {
            oneDone = 1;
        }
        //Determine ability score bonus
        nAbilityRoll = GetAbilityRoll(sRarity);
        //Determine the amount of negative spell-failure
        nSpellFail = nSpellFailBase;
        //Determine which saving throw gets the bonus. We'll use nQnty to determine how much to increase the save.
        nSavingThrow = Random(3)+1;
        //Determine which properties are added to the item
        nRandom = Random(8);

        if(nRandom == 0 && oneDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add AC.");
            ipMain = ItemPropertyACBonus(nACRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            oneDone = 1;
            nLoop++;
        }
        else if(nRandom == 1 && twoDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Ability.");
            ipMain = ItemPropertyAbilityBonus(nAbility, nAbilityRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            twoDone = 1;
            nLoop++;
        }
        else if(nRandom == 2 && threeDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Spell Failure.");
            ipMain = ItemPropertySkillBonus(nResource, nResourceBonus);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            threeDone = 1;
            nLoop++;
        }
        else if(nRandom == 3 && fourDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Resist.");
            ipMain = ItemPropertyDamageResistance(nResistType, nResistAmount);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            fourDone = 1;
            nLoop++;
        }
        else if(nRandom == 4 && fiveDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Saving Throw.");
            ipMain = ItemPropertyBonusSavingThrow(nSavingThrow, nSavingRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            fiveDone = 1;
            nLoop++;
        }
        else if(nRandom == 5 && sixDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Regen.");
            ipMain = ItemPropertyRegeneration(nRegen);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            sixDone = 1;
            nLoop++;
        }
        else if(nRandom == 6 && sevenDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Skill.");
            ipMain = ItemPropertySkillBonus(nSkillType, nSkillBonus);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            sevenDone = 1;
            nLoop++;
        }
        else if(nRandom == 7 && eightDone != 1)
        {
            //DebugLine
            //SendMessageToPC(GetFirstPC(), "Attempting to add Ability 2.");
            ipMain = ItemPropertyAbilityBonus(nAbility2, nAbilityRoll);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            eightDone = 1;
            nLoop++;
        }
    }
}

//Generate weapon stats
void GenWeaponStats(string sRarity, object oItem, int nUptier)
{
    int nQnty;
    int nACRoll;
    int nRandom;
    int nAttack;
    int nDamage;
    int nDamageType;
    int nDamageType2;
    int nVamp;
    int nLoop;
    int nAC;
    itemproperty ipMain;
    itemproperty ipDam2;

    //We'll use these to make sure we don't try to apply the same property twice.
    int oneDone = 0;
    int twoDone = 0;
    int threeDone = 0;
    int fourDone = 0;
    int fiveDone = 0;
    int sixDone = 0;

    //Determine how many times we'll loop through to add properties to an item.
    if(sRarity == "Common")
    {
        nQnty = 2;
    }
    else if(sRarity == "Uncommon")
    {
        nQnty = 3;
    }
    else if(sRarity == "Rare")
    {
        nQnty = 4;
    }
    else if(sRarity == "Legendary")
    {
        nQnty = 5;
    }

    if(nUptier == 1)
    {
        nQnty++; //Uptier by adding 1 more properties
    }

    //Determine AC bonus
    if(sRarity == "Common")
    {
        nAC = 1;
    }
    else if(sRarity == "Uncommon")
    {
        nAC = 2;
    }
    else if(sRarity == "Rare")
    {
        nAC = 3;
    }
    else if(sRarity == "Legendary")
    {
        nAC = 4;
    }

    //Get Attack Amount
    if(sRarity == "Common")
    {
        nAttack = Random(2) + 1;
    }
    else if(sRarity == "Uncommon")
    {
        nAttack = Random(2) + 2;
    }
    else if(sRarity == "Rare")
    {
        nAttack = Random(3) + 3;
    }
    else if(sRarity == "Legendary")
    {
        nAttack = 5;
    }

    //Get damage amount
    if(sRarity == "Common")
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d6;
    }
    else if(sRarity == "Uncommon")
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d8;
    }
    else if(sRarity == "Rare")
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d10;
    }
    else if(sRarity == "Legendary")
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d12;
    }

    //Random roll to determine damage type
    nDamageType = GetDamageType();

    //Vamp regen damage bonus
    if(sRarity == "Common")
    {
        nVamp = 1;
    }
    else if(sRarity == "Uncommon")
    {
        nVamp = 2;
    }
    else if(sRarity == "Rare")
    {
        nVamp = 3;
    }
    else if(sRarity == "Legendary")
    {
        nVamp = 4;
    }

    //Lowering quantity of properties by one because weapons have a 100% for bonus damage.
    nLoop = nLoop + 1;
    ipMain = ItemPropertyDamageBonus(nDamageType, nDamage);
    AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);

    //Adding two damage bonuses Make sure they don't conflict.
    nDamageType2 = GetDamageType();
    if(nDamageType2 == nDamageType)
    {
        while(nDamageType2 == nDamageType)
        {
            nDamageType2 = GetDamageType();
        }
    }
    //ipDam2 = ItemPropertyDamageBonus(nDamageType, nDamage);
    //AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);

    //Ranged weapons cannot take the vampiric regen property. So we'll swap it with Mighty instead.
    int nWepType = GetBaseItemType(oItem);

    //Randomly determine the weapon properties.
    while(nLoop < nQnty)
    {
        nRandom = d6(1);

        if(nRandom == 1 && oneDone != 1)
        {
            //Ranged weapons cannot take the vampiric regen property. So we'll swap it with regular regen instead.
            if(nWepType == 6 || nWepType == 8 || nWepType == 11)
            {
                ipMain = ItemPropertyRegeneration(nVamp);
                AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            }
            else
            {
                ipMain = ItemPropertyVampiricRegeneration(nVamp);
                AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            }
            oneDone = 1;
            nLoop++;
        }
        else if(nRandom == 2 && twoDone != 1)
        {
            ipMain = ItemPropertyAttackBonus(nAttack);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            twoDone = 1;
            nLoop++;
        }
        else if(nRandom == 3 && threeDone != 1)
        {
            ipMain = ItemPropertyKeen();
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            threeDone = 1;
            nLoop++;
        }
        else if(nRandom == 4 && fourDone != 1)
        {
            ipMain = ItemPropertyMassiveCritical(nDamage);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            fourDone = 1;
            nLoop++;
        }
        else if(nRandom == 5 && fiveDone != 1)
        {
            ipMain = ItemPropertyACBonus(nAC);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            fiveDone = 1;
            nLoop++;
        }
        else if(nRandom == 6 && sixDone != 1)
        {
            ipMain = ItemPropertyDamageBonus(nDamageType2, nDamage);
            AddItemProperty(DURATION_TYPE_PERMANENT, ipMain, oItem);
            sixDone = 1;
            nLoop++;
        }
    }
}

