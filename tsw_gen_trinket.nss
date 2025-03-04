//Create random item in temporary chest.
string GetRandomTrinket()
{
    //Trinkets are rings, amulets, and belts
    int nValue;

    nValue = Random(3);
    switch(nValue)
    {
        case 0:
            return "d_belt";
            break;
        case 1:
            return "d_ring";
            break;
        case 2:
            return "d_amulet";
            break;
    }
    return "BROKEN TRINKET";

}

void LootGenerateTrinket(int nAmount, object oPC)
{
    //Create random item in temporary chest.
    object oChest = GetObjectByTag("scriptchest_loot");
    string sSetItem;
    int nItemLoop = 0;

    while(nItemLoop < nAmount)
    {
        sSetItem = GetRandomTrinket();
        CreateItemOnObject(sSetItem, oChest, 1);
        nItemLoop = nItemLoop + 1;
    }
}

