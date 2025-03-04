#include "pals_main"
#include "inc_loot_rolls"
#include "tsw_boss_tester1"

void main()
{
    object oMob = OBJECT_SELF;
    int nLootCount = 1;

    //Determine rarity of item
    string sRarity;
    sRarity = GetT3Rarity();

    //Regular enemies have a 10% chance to drop loot.
    int nLootRoll = Random(10);

    //Rarity determines loot token
    string sToken;
    if(sRarity == "Common")
    {
        sToken = "loottokent1";
    }
    else if(sRarity == "Uncommon")
    {
        sToken = "loottokent2";
    }
    else if(sRarity == "Rare")
    {
        sToken = "loottokent3";
    }

    //Create token on creature if nDo is hit by random.
    if(nLootRoll == 2)
    {
        int nItemLoop = 0;
        while(nItemLoop < nLootCount)
        {
            CreateItemOnObject(sToken, oMob, 1);
            nItemLoop = nItemLoop + 1;
        }
    }

    ChanceForBoss(sRarity);

    AutoSplitGold(OBJECT_SELF,GetLastKiller());
    //Random Name
    ExecuteScript("npc_randomwalk", OBJECT_SELF);
    ExecuteScript("NW_C2_DEFAULT9", OBJECT_SELF);

    //Delete PC Prop
    object oItem = GetFirstItemInInventory();
    object oSlot = GetItemInSlot(17, OBJECT_SELF);
    string sRef = GetResRef(oItem);
    string sTag = GetTag(oItem);
    string sName = GetName(oItem);
    while (GetIsObjectValid(oItem))
    {
        if(sRef == "x3_it_pchide")
        {
            DestroyObject(oItem);
        }

        if(sTag == "x3_it_pchide")
        {
            DestroyObject(oItem);
        }
        if(sName == "PC Properties" && oItem == oSlot)
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory();
    }

}
