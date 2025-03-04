object LootGenerateModel(object oItem)
{
    //Determine the type of item we're getting. We only accept Belts, Amulets, Rings, Gauntlets, and Bracers
    object oNewItem;
    int nType = GetBaseItemType(oItem);

    //Amulet
    if(nType == 19)
    {
        int nRanAmulet = Random(82) + 1;
        oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nRanAmulet, FALSE);
        return oNewItem;
    }
    //Ring
    else if(nType == 52)
    {
        int nRanRing = Random(141) + 1;
        oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nRanRing, FALSE);
        return oNewItem;
    }
    //Gauntlet
    else if(nType == 36)
    {
        int nRandomSelect = Random(4);
        int nRanGaunt1 = Random(11) + 1;
        int nRanGaunt2 = Random(7) + 20;
        int nRanGaunt3 = Random(12) + 51;
        int nRanGaunt4 = Random(4) + 97;
        switch(nRandomSelect)
        {
            case 0:
                nRandomSelect = nRanGaunt1;
                break;
            case 1:
                nRandomSelect = nRanGaunt2;
                break;
            case 2:
                nRandomSelect = nRanGaunt3;
                break;
            case 3:
                nRandomSelect = nRanGaunt4;
                break;
        }
        oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nRandomSelect, FALSE);
        return oNewItem;
    }
    //Belt
    else if(nType == 21)
    {
        int nRandomSelect = Random(2);
        int nRanBelt1 = Random(9) + 1;
        int nRanBelt2 = Random(18) + 51;
        switch(nRandomSelect)
        {
            case 0:
                nRandomSelect = nRanBelt1;
                break;
            case 1:
                nRandomSelect = nRanBelt2;
                break;
        }
        oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nRandomSelect, FALSE);
        return oNewItem;
    }
    //Bracer
    else if(nType == 78)
    {
        int nRandomSelect = Random(2);
        int nRanBracer1 = Random(12) + 1;
        int nRanBracer2 = Random(10) + 51;
        switch(nRandomSelect)
        {
            case 0:
                nRandomSelect = nRanBracer1;
                break;
            case 1:
                nRandomSelect = nRanBracer2;
                break;
        }
        oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nRandomSelect, FALSE);
        return oNewItem;
    }
    else
    {
        return oItem;
    }
}
