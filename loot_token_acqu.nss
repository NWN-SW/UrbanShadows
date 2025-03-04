#include "loot_token_rward"
#include "loot_token_shop"


void main()
{
    //Global Variables
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();
    string sTag = GetTag(oItem);
    //Loot Token
    if(GetIsPC(oPC))
    {
        if(sTag == "LootTokenT1")
        {
            LootTokenReward("Common", 1, 0, "", 0);
        }
        else if(sTag == "mwLootTokenT1")
        {
            LootTokenReward("Common", 1, 0, "", 1);
        }
        else if(sTag == "LootTokenT2")
        {
            LootTokenReward("Uncommon", 1, 0, "", 0);
        }
        else if(sTag == "mwLootTokenT2")
        {
            LootTokenReward("Uncommon", 1, 0, "", 1);
        }
        else if(sTag == "LootTokenT3")
        {
            LootTokenReward("Rare", 1, 0, "", 0);
        }
        else if(sTag == "mwLootTokenT3")
        {
            LootTokenReward("Rare", 1, 0, "", 1);
        }
        else if(sTag == "LootTokenT4")
        {
            LootTokenReward("Legendary", 1, 0, "", 0);
        }
    }
    //Shop Tokens
    if(GetIsPC(oPC))
    {
        if(sTag == "ShopTokenT1")
        {
            LootTokenShop("Common", 1, 0);
        }
        else if(sTag == "ShopTokenT2")
        {
            LootTokenShop("Uncommon", 1, 0);
        }
        else if(sTag == "ShopTokenT3")
        {
            LootTokenShop("Rare", 1, 0);
        }
        else if(sTag == "ShopTokenT4")
        {
            LootTokenShop("Legendary", 1, 0);
        }
    }

    //Caster focus tracking
    ExecuteScript("loot_focus_acqu");

    //Default Script
    // ExecuteScript("x2_mod_def_aqu");
}

