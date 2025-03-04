#include "gen_inc_color"

string GetParcelByRarity(string sRarity)
{
    if(sRarity == "Common")
    {
        return "loottokent1";
    }
    else if(sRarity == "Common+")
    {
        return "loottokent1mw";
    }
    else if(sRarity == "Uncommon")
    {
        return "loottokent2";
    }
    else if(sRarity == "Uncommon+")
    {
        return "loottokent2mw";
    }
    else if(sRarity == "Rare")
    {
        return "loottokent3";
    }
    else if(sRarity == "Rare+")
    {
        return "loottokent3mw";
    }
    else if(sRarity == "Legendary")
    {
        return "loottokent4";
    }
    else
    {
        return "loottokent1";
    }
}

string GetT1Rarity()
{
    int nValue = Random(20);
    switch(nValue)
    {
        case 0:
            return "Common";
            break;
        case 1:
            return "Common";
            break;
        case 2:
            return "Common";
            break;
        case 3:
            return "Common";
            break;
        case 4:
            return "Common";
            break;
        case 5:
            return "Common";
            break;
        case 6:
            return "Common";
            break;
        case 7:
            return "Common";
            break;
        case 8:
            return "Common+";
            break;
        case 9:
            return "Common+";
            break;
        case 10:
            return "Common+";
            break;
        case 11:
            return "Common+";
            break;
        case 12:
            return "Common+";
            break;
        case 13:
            return "Common+";
            break;
        case 14:
            return "Common+";
            break;
        case 15:
            return "Common+";
            break;
        case 16:
            return "Uncommon";
            break;
        case 17:
            return "Uncommon";
            break;
        case 18:
            return "Uncommon";
            break;
        case 19:
            return "Uncommon";
            break;
    }
    return "ERROR";
}

string GetT2Rarity()
{
    int nValue = Random(20);
    switch(nValue)
    {
        case 0:
            return "Uncommon";
            break;
        case 1:
            return "Uncommon";
            break;
        case 2:
            return "Uncommon";
            break;
        case 3:
            return "Uncommon";
            break;
        case 4:
            return "Uncommon";
            break;
        case 5:
            return "Uncommon";
            break;
        case 6:
            return "Uncommon";
            break;
        case 7:
            return "Uncommon";
            break;
        case 8:
            return "Uncommon+";
            break;
        case 9:
            return "Uncommon+";
            break;
        case 10:
            return "Uncommon+";
            break;
        case 11:
            return "Uncommon+";
            break;
        case 12:
            return "Uncommon+";
            break;
        case 13:
            return "Uncommon+";
            break;
        case 14:
            return "Uncommon+";
            break;
        case 15:
            return "Uncommon+";
            break;
        case 16:
            return "Uncommon+";
            break;
        case 17:
            return "Uncommon+";
            break;
        case 18:
            return "Uncommon+";
            break;
        case 19:
            return "Rare";
            break;
    }
    return "ERROR";
}

string GetT3Rarity()
{
    int nValue = Random(20);
    switch(nValue)
    {
        case 0:
            return "Uncommon+";
            break;
        case 1:
            return "Uncommon+";
            break;
        case 2:
            return "Uncommon+";
            break;
        case 3:
            return "Uncommon+";
            break;
        case 4:
            return "Uncommon+";
            break;
        case 5:
            return "Uncommon+";
            break;
        case 6:
            return "Uncommon+";
            break;
        case 7:
            return "Uncommon+";
            break;
        case 8:
            return "Uncommon+";
            break;
        case 9:
            return "Uncommon+";
            break;
        case 10:
            return "Uncommon+";
            break;
        case 11:
            return "Uncommon+";
            break;
        case 12:
            return "Uncommon+";
            break;
        case 13:
            return "Uncommon+";
            break;
        case 14:
            return "Uncommon+";
            break;
        case 15:
            return "Rare";
            break;
        case 16:
            return "Rare";
            break;
        case 17:
            return "Rare";
            break;
        case 18:
            return "Rare";
            break;
        case 19:
            return "Rare+";
            break;
    }
    return "ERROR";
}

string GetT4Rarity()
{
    int nValue = Random(20);
    switch(nValue)
    {
        case 0:
            return "Rare";
            break;
        case 1:
            return "Rare";
            break;
        case 2:
            return "Rare";
            break;
        case 3:
            return "Rare";
            break;
        case 4:
            return "Rare";
            break;
        case 5:
            return "Rare";
            break;
        case 6:
            return "Rare";
            break;
        case 7:
            return "Rare";
            break;
        case 8:
            return "Rare";
            break;
        case 9:
            return "Rare";
            break;
        case 10:
            return "Rare";
            break;
        case 11:
            return "Rare";
            break;
        case 12:
            return "Rare";
            break;
        case 13:
            return "Rare";
            break;
        case 14:
            return "Rare+";
            break;
        case 15:
            return "Rare+";
            break;
        case 16:
            return "Rare+";
            break;
        case 17:
            return "Rare+";
            break;
        case 18:
            return "Legendary";
            break;
        case 19:
            return "Legendary";
            break;
    }
    return "ERROR";
}

int GetSlotClass(int nValue)
{
    int nClass;
    switch(nValue)
    {
        case 0:
            nClass = 1;
            return nClass;
            break;
        case 1:
            nClass = 2;
            return nClass;
            break;
        case 2:
            nClass = 3;
            return nClass;
            break;
        case 3:
            nClass = 6;
            return nClass;
            break;
        case 4:
            nClass = 7;
            return nClass;
            break;
        case 5:
            nClass = 9;
            return nClass;
            break;
        case 6:
            nClass = 10;
            return nClass;
            break;
    }
    return nClass;
}

//Determine the AC value of the item propery
int GetACRoll(string nRarity)
{
    int nRoll;
    if(nRarity == "Common")
    {
        int nRoll = Random(2) + 1;
        return nRoll;
    }
    else if(nRarity == "Uncommon")
    {
        int nRoll = Random(2) + 3;
        return nRoll;
    }
    else if(nRarity == "Rare")
    {
        int nRoll = Random(2) + 5;
        return nRoll;
    }
    else if(nRarity == "Legendary")
    {
        int nRoll = 6;
        return nRoll;
    }
    else
    {
        return nRoll;
    }
}

//Determine the Ability value of the item propery
int GetAbilityRoll(string nRarity)
{
    int nRoll;
    if(nRarity == "Common")
    {
        int nRoll = Random(2) + 1;
        return nRoll;
    }
    else if(nRarity == "Uncommon")
    {
        int nRoll = Random(2) + 2;
        return nRoll;
    }
    else if(nRarity == "Rare")
    {
        int nRoll = Random(2) + 3;
        return nRoll;
    }
    else if(nRarity == "Legendary")
    {
        int nRoll = 4;
        return nRoll;
    }
    else
    {
        return nRoll;
    }
}

//Weapon damage type
int GetDamageType()
    {
        int nRandom = Random(11);
        int nDamageType = 2;

        switch(nRandom)
        {
            case 0:
                //Acid
                nDamageType = 6;
                return nDamageType;
                break;
            case 1:
                //Bludge
                nDamageType = 0;
                return nDamageType;
                break;
            case 2:
                //Pierce
                nDamageType = 1;
                return nDamageType;
                break;
            case 3:
                //Slash
                nDamageType = 2;
                return nDamageType;
                break;
            case 4:
                //Fire
                nDamageType = 10;
                return nDamageType;
                break;
            case 5:
                //Cold
                nDamageType = 7;
                return nDamageType;
                break;
            case 6:
                //Elec
                nDamageType = 9;
                return nDamageType;
                break;
            case 7:
                //Sonic
                nDamageType = 13;
                return nDamageType;
                break;
            case 8:
                //Neg
                nDamageType = 11;
                return nDamageType;
                break;
            case 9:
                //Div
                nDamageType = 8;
                return nDamageType;
                break;
            case 10:
                //Mag
                nDamageType = 5;
                return nDamageType;
                break;
        }
        return nDamageType;
    }

void SetQuality(object oItem, string sRarity, int nUptier)
{
    itemproperty ipQuality;
    if(sRarity == "Common")
    {
        ipQuality = ItemPropertyQuality(1);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipQuality, oItem);
    }

    if(sRarity == "Uncommon")
    {
        ipQuality = ItemPropertyQuality(2);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipQuality, oItem);
    }

    if(sRarity == "Rare")
    {
        ipQuality = ItemPropertyQuality(3);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipQuality, oItem);
    }

    if(sRarity == "Legendary")
    {
        ipQuality = ItemPropertyQuality(4);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipQuality, oItem);
    }

    if(nUptier == 1)
    {
        ipQuality = ItemPropertyQuality(11);
        AddItemProperty(DURATION_TYPE_PERMANENT, ipQuality, oItem);
    }
}

//Magic item name generator
string GetItemPrefix(int nValue)
{
    switch(nValue)
    {
        case 0:
            return "Giant";
            break;
        case 1:
            return "Fiend";
            break;
        case 2:
            return "Vermin";
            break;
        case 3:
            return "Ghoul";
            break;
        case 4:
            return "Law";
            break;
        case 5:
            return "Demon";
            break;
        case 6:
            return "Eternal";
            break;
        case 7:
            return "Abyss";
            break;
        case 8:
            return "River";
            break;
        case 9:
            return "Celestial";
            break;
        case 10:
            return "Heavenly";
            break;
        case 11:
            return "Foe";
            break;
        case 12:
            return "Sublime";
            break;
        case 13:
            return "Heart";
            break;
        case 14:
            return "Night";
            break;
        case 15:
            return "Bright";
            break;
        case 16:
            return "Wind";
            break;
        case 17:
            return "Astral";
            break;
        case 18:
            return "Lumionous";
            break;
        case 19:
            return "Death";
            break;
        case 20:
            return "War";
            break;
        case 21:
            return "Chaos";
            break;
        case 22:
            return "Order";
            break;
        case 23:
            return "Empyrean";
            break;
        case 24:
            return "Sky";
            break;
        case 25:
            return "Skitter";
            break;
        case 26:
            return "Eternal";
            break;
        case 27:
            return "Steel";
            break;
        case 28:
            return "Skull";
            break;
        case 29:
            return "Fell";
            break;
        case 30:
            return "Sly";
            break;
        case 31:
            return "Draken";
            break;
        case 32:
            return "Stone";
            break;
        case 33:
            return "Flame";
            break;
        case 34:
            return "Mist";
            break;
        case 35:
            return "Silver";
            break;
        case 36:
            return "Wave";
            break;
        case 37:
            return "Cruel";
            break;
        case 38:
            return "Grace";
            break;
        case 39:
            return "Stark";
            break;
        case 40:
            return "Vicious";
            break;
        case 41:
            return "Wicked";
            break;
        case 42:
            return "Fate";
            break;
        case 43:
            return "Frost";
            break;
        case 44:
            return "Wraith";
            break;
        case 45:
            return "Vile";
            break;
        case 46:
            return "Curse";
            break;
        case 47:
            return "Doom";
            break;
        case 48:
            return "Spirit";
            break;
        case 49:
            return "Divine";
            break;
    }
    return "ERROR";
}

string GetItemSuffix(int nValue)
{
    switch(nValue)
    {
        case 0:
            return "seer";
            break;
        case 1:
            return "sear";
            break;
        case 2:
            return "ruin";
            break;
        case 3:
            return "spear";
            break;
        case 4:
            return "grinder";
            break;
        case 5:
            return "killer";
            break;
        case 6:
            return "razor";
            break;
        case 7:
            return "slayer";
            break;
        case 8:
            return "reaver";
            break;
        case 9:
            return "gasp";
            break;
        case 10:
            return "haze";
            break;
        case 11:
            return "bane";
            break;
        case 12:
            return "piercer";
            break;
        case 13:
            return "spike";
            break;
        case 14:
            return "shear";
            break;
        case 15:
            return "crusher";
            break;
        case 16:
            return "thorn";
            break;
        case 17:
            return "storm";
            break;
        case 18:
            return "biter";
            break;
        case 19:
            return "wrath";
            break;
        case 20:
            return "surge";
            break;
        case 21:
            return "axe";
            break;
        case 22:
            return "hammer";
            break;
        case 23:
            return "claw";
            break;
        case 24:
            return "fury";
            break;
        case 25:
            return "light";
            break;
        case 26:
            return "star";
            break;
        case 27:
            return "tooth";
            break;
        case 28:
            return "wrack";
            break;
        case 29:
            return "gore";
            break;
        case 30:
            return "destiny";
            break;
        case 31:
            return "lance";
            break;
        case 32:
            return "scourge";
            break;
        case 33:
            return "singer";
            break;
        case 34:
            return "stinger";
            break;
        case 35:
            return "dance";
            break;
        case 36:
            return "dancer";
            break;
        case 37:
            return "fang";
            break;
        case 38:
            return "blade";
            break;
        case 39:
            return "reaper";
            break;
        case 40:
            return "keeper";
            break;
        case 41:
            return "ward";
            break;
        case 42:
            return "warden";
            break;
        case 43:
            return "cutter";
            break;
        case 44:
            return "glory";
            break;
        case 45:
            return "mind";
            break;
        case 46:
            return "slicer";
            break;
        case 47:
            return "tyrant";
            break;
        case 48:
            return "scythe";
            break;
        case 49:
            return "soul";
            break;
    }
    return "ERROR";
}

string GetMasterworkPrefix(int nValue, string sItemType)
{
    if (sItemType == "Armour")
    {
        switch(nValue)
        {
            case 0:
                return "Sturdy ";
                break;
            case 1:
                return "Intricate ";
                break;
            case 2:
                return "Resilient ";
                break;
            case 3:
                return "Layered ";
                break;
            case 4:
                return "Reinforced ";
                break;
        }
    }
    else if (sItemType == "Gear")
    {
        switch(nValue)
        {
            case 0:
                return "Intricate ";
                break;
            case 1:
                return "Improved ";
                break;
            case 2:
                return "Precious ";
                break;
            case 3:
                return "Stylish ";
                break;
            case 4:
                return "Ornate ";
                break;
        }
    }
    else if (sItemType == "1H_Weapon")
    {
        switch(nValue)
        {
            case 0:
                return "Gilded ";
                break;
            case 1:
                return "Infused ";
                break;
            case 2:
                return "Durable ";
                break;
            case 3:
                return "Annelated ";
                break;
            case 4:
                return "Reliable ";
                break;
        }
    }
    else if (sItemType == "2H_Weapon")
    {
        switch(nValue)
        {
            case 0:
                return "Brutal ";
                break;
            case 1:
                return "Vicious ";
                break;
            case 2:
                return "Balanced ";
                break;
            case 3:
                return "Savage ";
                break;
            case 4:
                return "Imbued ";
                break;
        }
    }
    else if (sItemType == "Ranged_Weapon")
    {
        switch(nValue)
        {
            case 0:
                return "Calibrated ";
                break;
            case 1:
                return "Runed ";
                break;
            case 2:
                return "Modified ";
                break;
            case 3:
                return "Custom ";
                break;
            case 4:
                return "Accurized ";
                break;
        }
    }
    else
    {
        return "Masterwork ";
    }
    return "ERROR";
}

string GetItemName(string sName, int nPrefixRoll, int nSuffixRoll, string sRarity, int nUptier, string sItemType)
{
    string sPrefix;
    string sSuffix;
    string sMasterwork;
    int nMWRoll;

    sPrefix = GetItemPrefix(nPrefixRoll);
    sSuffix = GetItemSuffix(nSuffixRoll);
    if(nUptier == 1)
    {
        int nMWRoll = Random(5);
        sMasterwork = GetMasterworkPrefix(nMWRoll, sItemType);
    }
    else
    {
        sMasterwork = "";
    }

    if(sRarity == "Common")
    {
        return GetRGB(12,12,12) + sMasterwork + sPrefix + sSuffix + " " + sName;
    }
    else if(sRarity == "Uncommon")
    {
        return GetRGB(8,8,14) + sMasterwork + sPrefix + sSuffix + " " + sName;
    }
    else if(sRarity == "Rare")
    {
        return GetRGB(14,14,1) + sMasterwork + sPrefix + sSuffix + " " + sName;
    }
    else if(sRarity == "Legendary")
    {
        return GetRGB(15,7,1) + sMasterwork + sPrefix + sSuffix + " " + sName;
    }
    else
    {
        return "Poodoo";
    }
}

string GetFocusNameColour(string sName, string sRarity)
{

    if(sRarity == "Common")
    {
        return GetRGB(12,12,12) + sName;
    }
    else if(sRarity == "Uncommon")
    {
        return GetRGB(8,8,14) + sName;
    }
    else if(sRarity == "Rare")
    {
        return GetRGB(14,14,1) + sName;
    }
    else if(sRarity == "Legendary")
    {
        return GetRGB(15,7,1) + sName;
    }
    else
    {
        return "Poodoo";
    }
}

