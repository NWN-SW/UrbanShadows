#include "gen_inc_color"
//ARMOUR SETS
string GetSetValue(int nValue)
{
    switch(nValue)
    {
        case 0:
            return "BALANCE";
            break;
        case 1:
            return "POWER";
            break;
        case 2:
            return "VALIANT";
            break;
        case 3:
            return "WILDS";
            break;
        case 4:
            return "HUNTER";
            break;
        case 5:
            return "PREDATOR";
            break;
        case 6:
            return "SPELLSLINGER";
            break;
        case 7:
            return "CRUSADER";
            break;
        case 8:
            return "ILLUMINATE";
            break;
        case 9:
            return "ZEAL";
            break;
        case 10:
            return "PERFORMER";
            break;
        case 11:
            return "DIRGE";
            break;
        case 12:
            return "DUELIST";
            break;
        case 13:
            return "ASSASSIN";
            break;
        case 14:
            return "MIGHT";
            break;
        case 15:
            return "BERSERKER";
            break;
        case 16:
            return "INTELLECT";
            break;
        case 17:
            return "CHANNELING";
            break;
        case 18:
            return "WAREFARE";
            break;
        case 19:
            return "MASTER";
            break;
        case 20:
            return "IVGOROD";
            break;
        case 21:
            return "FALLING SUN";
            break;
        case 22:
            return "LIGHTBLADE";
            break;
        case 23:
            return "TEMPLAR";
            break;
        case 24:
            return "SPELLBLADE";
            break;
        case 25:
            return "FORCEBLADE";
            break;
    }
    return "ERROR";
}

string GetSetName(int nSet, string sItem)
{
    switch(nSet)
    {
        case 0:
            return GetRGB(1,11,1) + sItem + " of Balance"; //Green
            break;
        case 1:
            return GetRGB(7,7,15) + sItem + " of Power";
            break;
        case 2:
            return GetRGB(15,15,10) + sItem + " of the Valiant";
            break;
        case 3:
            return GetRGB(1,11,1) + sItem + " of the Wilds";
            break;
        case 4:
            return GetRGB(3,11,1) + sItem + " of the Hunter";
            break;
        case 5:
            return GetRGB(3,11,1) + sItem + " of the Predator";
            break;
        case 6:
            return GetRGB(7,7,15) + sItem + " of the Spellslinger";
            break;
        case 7:
            return GetRGB(15,15,10) + sItem + " of the Crusader";
            break;
        case 8:
            return GetRGB(13,13,1) + sItem + " of the Illuminate";
            break;
        case 9:
            return GetRGB(13,13,1) + sItem + " of Zeal";
            break;
        case 10:
            return GetRGB(11,9,11) + sItem + " of the Performer";
            break;
        case 11:
            return GetRGB(11,9,11) + sItem + " of the Dirge";
            break;
        case 12:
            return GetRGB(12,12,12) + sItem + " of the Duelist";
            break;
        case 13:
            return GetRGB(12,12,12) + sItem + " of the Assassin";
            break;
        case 14:
            return GetRGB(15,5,1) + sItem + " of Might";
            break;
        case 15:
            return GetRGB(15,5,1) + sItem + " of the Berserker";
            break;
        case 16:
            return GetRGB(1,9,9) + sItem + " of Intellect";
            break;
        case 17:
            return GetRGB(1,9,9) + sItem + " of Channeling";
            break;
        case 18:
            return GetRGB(9,9,15) + sItem + " of the Warfare";
            break;
        case 19:
            return GetRGB(9,9,15) + sItem + " of the Master";
            break;
        case 20:
            return GetRGB(15,15,1) + sItem + " of Ivgorod";
            break;
        case 21:
            return GetRGB(15,15,1) + sItem + " of the Falling Sun";
            break;
        case 22:
            return GetRGB(15,15,10) + sItem + " of the Lightblade";
            break;
        case 23:
            return GetRGB(13,13,1) + sItem + " of the Templar";
            break;
        case 24:
            return GetRGB(13,13,1) + sItem + " of the Spellblade";
            break;
        case 25:
            return GetRGB(13,13,1) + sItem + " of the Forceblade";
            break;
    }
    return "ERROR";
}

string GetSetDesc(int nDesc)
{
    switch(nDesc)
    {
        case 0:
            return "Part of the Nature's Balance set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 1:
            return "Part of the Arcane Power set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 2:
            return "Part of the Valiant set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 3:
            return "Part of the Wilds set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 4:
            return "Part of the Hunter set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 5:
            return "Part of the Predator set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 6:
            return "Part of the Spellslinger set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 7:
            return "Part of the Crusader set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 8:
            return "Part of the Illuminate set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 9:
            return "Part of the Zeal set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 10:
            return "Part of the Performer set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 11:
            return "Part of the Dirge set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 12:
            return "Part of the Duelist set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 13:
            return "Part of the Assassin set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 14:
            return "Part of the Might set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 15:
            return "Part of the Berserker set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 16:
            return "Part of the Intellect set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 17:
            return "Part of the Channeling set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 18:
            return "Part of the Warfare set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 19:
            return "Part of the Master set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 20:
            return "Part of the Ivgorod set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 21:
            return "Part of the Falling Sun set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 22:
            return "Part of the Lightblade set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 23:
            return "Part of the Templar set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 24:
            return "Part of the Spellblade set. Equipping this item will unlock more power on the associated armour.";
            break;
        case 25:
            return "Part of the Forceblade set. Equipping this item will unlock more power on the associated armour.";
            break;
    }
    return "ERROR";
}
