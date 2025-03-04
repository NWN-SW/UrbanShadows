//Create random item in temporary chest.
string GetRandomWeapon()
{
    int nValue;
    //WEAPONS REEEEEEE. I'm tired.
    nValue = Random(35);
    switch(nValue)
    {
        case 0:
            return "d_firearm";
            break;
        case 1:
            return "d_longsword";
            break;
        case 2:
            return "d_dwaxe";
            break;
        case 3:
            return "d_dagger";
            break;
        case 4:
            return "d_doubleaxe";
            break;
        case 5:
            return "d_diremace";
            break;
        case 6:
            return "d_twobladedsword";
            break;
        case 7:
            return "d_gauntlets";
            break;
        case 8:
            return "d_greataxe";
            break;
        case 9:
            return "d_greatsword";
            break;
        case 10:
            return "d_halberd";
            break;
        case 11:
            return "d_sickle";
            break;
        case 12:
            return "d_heavyflail";
            break;
        case 13:
            return "d_kama";
            break;
        case 14:
            return "d_katana";
            break;
        case 15:
            return "d_kukri";
            break;
        case 16:
            return "d_handgun";
            break;
        case 17:
            return "d_longsword";
            break;
        case 18:
            return "d_morningstar";
            break;
        case 19:
            return "d_quarterstaff";
            break;
        case 20:
            return "d_rapier";
            break;
        case 21:
            return "d_scimitar";
            break;
        case 22:
            return "d_scythe";
            break;
        case 23:
            return "d_shortsword";
            break;
        case 24:
            return "d_spear";
            break;
        case 25:
            return "d_warhammer";
            break;
        case 26:
            return "d_whip";
            break;
        case 27:
            return "d_battleaxe";
            break;
        //Mage staff
        case 28:
            return "d_mstaff";
            break;
        case 29:
            return "d_bastardsword";
            break;
        case 30:
            return "d_maul";
            break;
        case 31:
            return "d_mace";
            break;
        case 32:
            return "d_falchion";
            break;
        case 33:
            return "shotgun";
            break;
        //Mage weapons
        case 34:
            nValue = Random(6);
            switch(nValue)
            {
                case 0:
                    return "d_mdagger";
                    break;
                case 1:
                    return "d_massdagger";
                    break;
                case 2:
                    return "d_mclub";
                    break;
                case 3:
                    return "d_msword";
                    break;
                case 4:
                    return "d_mtorch";
                    break;
                case 5:
                    return "d_mmace";
                    break;
            }
            return "BROKEN MAGE WEAPON";
    }
    return "BROKEN WEAPON";
}

void LootGenerateWeapon(int nAmount, object oPC)
{
    //Create random item in temporary chest.
    object oChest = GetObjectByTag("scriptchest_loot");
    string sSetItem;
    int nItemLoop = 0;

    //We want to make sure the player has a decent chance to get the weapon they're wielding.
    //The default chance for a preferred weapon is 1.6%.
    //We'll roll to give the person a 10% chance to get their preferred weapon.
    object oEquipped = GetItemInSlot(4, oPC);
    object oGauntlets = GetItemInSlot(3, oPC);
    string sResRef = GetResRef(oEquipped);
    string sGauntlets = GetResRef(oGauntlets);
    int nRoll;

    //Make sure Shifter forms don't get shifter weapons
    if(sResRef == "shift_shortsword")
    {
        sResRef = "d_shortsword";
    }
    else if(sResRef == "shifter_greataxe")
    {
        sResRef = "d_greataxe";
    }
    else if(sResRef == "shifter_staff")
    {
        sResRef = "d_quarterstaff";
    }
    else if(sResRef == "obsidiansword") //Make sure Astoria quest items don't get rolled.
    {
        sResRef = "d_dagger";
    }

    while(nItemLoop < nAmount)
    {
        sSetItem = GetRandomWeapon();
        CreateItemOnObject(sSetItem, oChest, 1);
        nItemLoop = nItemLoop + 1;
    }
}

