//Create random item in temporary chest.
string GetSetItem(int nCount)
{
    switch(nCount)
    {
        //Normal Items
        case 0:
            return "kc_helm";
            break;
        case 1:
            return "kc_sshield";
            break;
        case 2:
            return "kc_tshield";
            break;
        case 3:
            return "kc_cloak";
            break;
        case 4:
            return "kc_bracers";
            break;
        case 5:
            return "kc_belt";
            break;
        case 6:
            return "kc_boots";
            break;
        case 7:
            return "kc_ring";
            break;
        case 8:
            return "kc_signet";
            break;
        case 9:
            return "kc_amulet";
            break;
        //Repeat normal items to keep loot fair
        case 10:
            return "kc_helm";
            break;
        case 11:
            return "kc_cloak";
            break;
        case 12:
            return "kc_bracers";
            break;
        case 13:
            return "kc_boots";
            break;
        case 14:
            return "kc_ring";
            break;
        case 15:
            return "kc_signet";
            break;
        case 16:
            return "kc_amulet";
            break;
        case 17:
            return "bardshield";
            break;
        //Special class specific items
        case 18:
            return "wizardcloak";
            break;
        case 19:
            return "sorcerercloak";
            break;
        case 20:
            return "arcanebelt";
            break;
        case 21:
            return "decoratedbelt";
            break;
        case 22:
            return "divinebelt";
            break;
        case 23:
            return "elementalbelt";
            break;
        case 24:
            return "infusedbelt";
            break;
        case 25:
            return "overgrownbelt";
            break;
        case 26:
            return "righteousbelt";
            break;
        case 27:
            return "sacredbelt";
            break;
        case 28:
            return "trackingbelt";
            break;
        case 29:
            return "stalwartcloak";
            break;
        case 30:
            return "bardcloak";
            break;
        //WEAPONS REEEEEEE. I'm tired.
        case 31:
            return "bastardsword";
            break;
        case 32:
            return "battleaxe";
            break;
        case 33:
            return "club";
            break;
        case 34:
            return "dagger";
            break;
        case 35:
            return "doubleaxe";
            break;
        case 36:
            return "doublemace";
            break;
        case 37:
            return "doublesword";
            break;
        case 38:
            return "monksgauntnew";
            break;
        case 39:
            return "greataxe";
            break;
        case 40:
            return "greatsword";
            break;
        case 41:
            return "halberd";
            break;
        case 42:
            return "handaxe";
            break;
        case 43:
            return "heavyflail";
            break;
        case 44:
            return "kama";
            break;
        case 45:
            return "katana";
            break;
        case 46:
            return "kukri";
            break;
        case 47:
            return "lightflail";
            break;
        case 48:
            return "longsword";
            break;
        case 49:
            return "mace";
            break;
        case 50:
            return "morningstar";
            break;
        case 51:
            return "quarterstaff001";
            break;
        case 52:
            return "rapier";
            break;
        case 53:
            return "scimitar";
            break;
        case 54:
            return "scythe";
            break;
        case 55:
            return "shortsword";
            break;
        case 56:
            return "spear";
            break;
        case 57:
            return "waraxe";
            break;
        case 58:
            return "warhammer";
            break;
        case 59:
            return "whip";
            break;
        case 60:
            return "d_handgun";
            break;
    }
    return "BROKEN";
}

