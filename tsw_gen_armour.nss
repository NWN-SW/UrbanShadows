//Create random item in temporary chest.
string GetRandomArmour()
{
    int nValue;

    nValue = Random(11);
    switch(nValue)
    {
        case 0:
            return "d_helmet";
            break;
        case 1:
            return "d_smallshield";
            break;
        case 2:
            return "d_towershield";
            break;
        case 3:
            return "d_cloak";
            break;
        case 4:
            return "d_bracer";
            break;
        case 5:
            return "d_boots";
            break;
        case 6:
            return "d_largeshield";
            break;
        //Armour and Clothes
        case 7:
            return "d_clothes";
            break;
        case 8:
            return "d_armour";
            break;
        case 9:
            return "d_larmour";
            break;
        case 10:
            return "d_marmour";
            break;
    }
    return "BROKEN ARMOUR";
}

void LootGenerateArmour(int nAmount, object oPC)
{
    //Create random item in temporary chest.
    object oChest = GetObjectByTag("scriptchest_loot");
    string sSetItem;
    int nItemLoop = 0;

    while(nItemLoop < nAmount)
    {
        sSetItem = GetRandomArmour();
        CreateItemOnObject(sSetItem, oChest, 1);
        nItemLoop = nItemLoop + 1;
    }
}

