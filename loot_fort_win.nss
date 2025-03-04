#include "inc_loot_sets"
#include "inc_loot_items"
#include "gen_inc_color"

void LootFortWin(object oPC, int nPCount)
{
    object oMob = oPC;
    object oChest = GetObjectByTag("scriptchest_loot");
    int nRewardCount = nPCount / 2;

    if(nRewardCount < 1)
    {
        nRewardCount = 1;
    }

    //Create random item in temporary chest.
    string sSetItem;
    int nItemLoop = 0;
    int nItem = Random(9) + 10;
    while(nItemLoop < nRewardCount)
    {
        sSetItem = GetSetItem(nItem);
        CreateItemOnObject(sSetItem, oChest, 1);
        nItem = Random(10);
        nItemLoop = nItemLoop + 1;
    }
    //Create variables for set items
    object oItem = GetFirstItemInInventory(oChest);
    int nSet = Random(24);
    string sVar = "SET_TAG_0";
    string sValue;
    string sSetName;
    string sName;

    //Apply random set bonus to item then give to dying creature.
    nItemLoop = 0;

    while(oItem != OBJECT_INVALID && nItemLoop < nRewardCount)
    {
        sName = GetName(oItem);
        //Apply Set Name and Desc to Item
        sValue = GetSetValue(nSet);
        sSetName = GetSetName(nSet, sName);
        SetDescription(oItem, GetSetDesc(nSet), TRUE);
        SetName(oItem, sSetName);
        //Put item in dying creature's inventory.
        AssignCommand(oChest, ActionGiveItem(oItem, oMob));
        SetDroppableFlag(oItem, TRUE);
        //Apply Set Tag to Item
        SetLocalString(oItem, sVar, sValue);
        //Roll for a new set
        nSet = Random(24);
        oItem = GetNextItemInInventory(oChest);
        nItemLoop = nItemLoop + 1;
    }
}



