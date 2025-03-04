void main()
{
    object oTrashWand = GetItemActivated();
    object oTgt = GetItemActivatedTarget();
    object oPC = GetItemActivator();

    itemproperty ipCheck;
    int nPropCheck;
    int nValue;
    int nTotal;
    int nItemType;

    if(GetTag(oTrashWand) == "Kitchen_WitchIt")
    {

        if(GetObjectType(oTgt) == OBJECT_TYPE_ITEM && !GetPlotFlag(oTgt) && GetDroppableFlag(oTgt)) {
               nItemType = GetBaseItemType(oTgt);
               if(nItemType == BASE_ITEM_AMULET || nItemType == BASE_ITEM_ARMOR || nItemType == BASE_ITEM_BASTARDSWORD ||
                    nItemType == BASE_ITEM_BATTLEAXE || nItemType == BASE_ITEM_BELT || nItemType == BASE_ITEM_BOOTS ||
                    nItemType == BASE_ITEM_BRACER || nItemType == BASE_ITEM_CLOAK || nItemType == BASE_ITEM_CLUB ||
                    nItemType == BASE_ITEM_DAGGER || nItemType == BASE_ITEM_DIREMACE || nItemType == BASE_ITEM_DOUBLEAXE ||
                    nItemType == BASE_ITEM_DWARVENWARAXE || nItemType == BASE_ITEM_GLOVES || nItemType == BASE_ITEM_GREATAXE ||
                    nItemType == BASE_ITEM_GREATSWORD || nItemType == BASE_ITEM_HALBERD || nItemType == BASE_ITEM_HANDAXE ||
                    nItemType == BASE_ITEM_HEAVYCROSSBOW || nItemType == BASE_ITEM_HEAVYFLAIL || nItemType == BASE_ITEM_HELMET ||
                    nItemType == BASE_ITEM_KAMA || nItemType == BASE_ITEM_KATANA || nItemType == BASE_ITEM_KUKRI ||
                    nItemType == BASE_ITEM_LIGHTCROSSBOW || nItemType == BASE_ITEM_LARGESHIELD || nItemType == BASE_ITEM_LIGHTFLAIL ||
                    nItemType == BASE_ITEM_LONGBOW || nItemType == BASE_ITEM_LONGSWORD || nItemType == BASE_ITEM_MORNINGSTAR ||
                    nItemType == BASE_ITEM_QUARTERSTAFF || nItemType == BASE_ITEM_RAPIER || nItemType == BASE_ITEM_RING ||
                    nItemType == BASE_ITEM_SCIMITAR || nItemType == BASE_ITEM_SCYTHE || nItemType == BASE_ITEM_SHORTBOW ||
                    nItemType == BASE_ITEM_SHORTSPEAR || nItemType == BASE_ITEM_SHORTSWORD || nItemType == BASE_ITEM_SHURIKEN ||
                    nItemType == BASE_ITEM_SICKLE || nItemType == BASE_ITEM_SMALLSHIELD || nItemType == BASE_ITEM_THROWINGAXE ||
                    nItemType == BASE_ITEM_TOWERSHIELD || nItemType == BASE_ITEM_TWOBLADEDSWORD || nItemType == BASE_ITEM_WARHAMMER ||
                    nItemType == BASE_ITEM_WHIP || nItemType == BASE_ITEM_SLING || nItemType == 309) {
                    nValue = GetGoldPieceValue(oTgt);
                    nValue = nValue/10;
                    string sRarity = GetLocalString(oTgt, "RARITY");
                    if(sRarity == "Common" || sRarity == "Uncommon" || sRarity == "Common+" || sRarity == "Uncommon+") {
                         DestroyObject(oTgt);
                         GiveGoldToCreature(oPC,nValue);
                    }
               }
        }

        else if(oTgt == oPC) {
        object oItem = GetFirstItemInInventory(oPC);
               nItemType = GetBaseItemType(oItem);
        while(oItem != OBJECT_INVALID) {
                    if(GetObjectType(oItem) == OBJECT_TYPE_ITEM && !GetPlotFlag(oItem) && GetDroppableFlag(oItem) && oPC == GetItemPossessor(oItem))
                {
                    if(nItemType == BASE_ITEM_AMULET || nItemType == BASE_ITEM_ARMOR || nItemType == BASE_ITEM_BASTARDSWORD ||
                    nItemType == BASE_ITEM_BATTLEAXE || nItemType == BASE_ITEM_BELT || nItemType == BASE_ITEM_BOOTS ||
                    nItemType == BASE_ITEM_BRACER || nItemType == BASE_ITEM_CLOAK || nItemType == BASE_ITEM_CLUB ||
                    nItemType == BASE_ITEM_DAGGER || nItemType == BASE_ITEM_DIREMACE || nItemType == BASE_ITEM_DOUBLEAXE ||
                    nItemType == BASE_ITEM_DWARVENWARAXE || nItemType == BASE_ITEM_GLOVES || nItemType == BASE_ITEM_GREATAXE ||
                    nItemType == BASE_ITEM_GREATSWORD || nItemType == BASE_ITEM_HALBERD || nItemType == BASE_ITEM_HANDAXE ||
                    nItemType == BASE_ITEM_HEAVYCROSSBOW || nItemType == BASE_ITEM_HEAVYFLAIL || nItemType == BASE_ITEM_HELMET ||
                    nItemType == BASE_ITEM_KAMA || nItemType == BASE_ITEM_KATANA || nItemType == BASE_ITEM_KUKRI ||
                    nItemType == BASE_ITEM_LIGHTCROSSBOW || nItemType == BASE_ITEM_LARGESHIELD || nItemType == BASE_ITEM_LIGHTFLAIL ||
                    nItemType == BASE_ITEM_LONGBOW || nItemType == BASE_ITEM_LONGSWORD || nItemType == BASE_ITEM_MORNINGSTAR ||
                    nItemType == BASE_ITEM_QUARTERSTAFF || nItemType == BASE_ITEM_RAPIER || nItemType == BASE_ITEM_RING ||
                    nItemType == BASE_ITEM_SCIMITAR || nItemType == BASE_ITEM_SCYTHE || nItemType == BASE_ITEM_SHORTBOW ||
                    nItemType == BASE_ITEM_SHORTSPEAR || nItemType == BASE_ITEM_SHORTSWORD || nItemType == BASE_ITEM_SHURIKEN ||
                    nItemType == BASE_ITEM_SICKLE || nItemType == BASE_ITEM_SMALLSHIELD || nItemType == BASE_ITEM_THROWINGAXE ||
                    nItemType == BASE_ITEM_TOWERSHIELD || nItemType == BASE_ITEM_TWOBLADEDSWORD || nItemType == BASE_ITEM_WARHAMMER ||
                    nItemType == BASE_ITEM_WHIP || nItemType == BASE_ITEM_SLING || nItemType == 309)
                    {
                     //Gold value
                     nValue = GetGoldPieceValue(oItem);
                     nValue = nValue / 10;

                     string sRarity = GetLocalString(oItem, "RARITY");

                     if(sRarity == "Common" || sRarity == "Uncommon" || sRarity == "Common+" || sRarity == "Uncommon+")
                        {
                         DestroyObject(oItem);
                         nTotal = nTotal + nValue;
                     }
                    }
                }
              oItem = GetNextItemInInventory(oPC);
             nItemType = GetBaseItemType(oItem);
          }
         GiveGoldToCreature(oPC, nTotal);
        }
   }
}





