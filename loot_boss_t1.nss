#include "pals_main"
#include "inc_loot_rolls"

void main()
{
    object oMob = OBJECT_SELF;
    int nLootCount = 1;
    string sRarity;
    int nRandom;

    //Make creature bigger
    SetObjectVisualTransform(OBJECT_SELF, 10, 1.20);

    //Create token on creature
    int nItemLoop = 0;
    while(nItemLoop < nLootCount)
    {
        //Determine rarity of item
        sRarity = "Uncommon";

        //Rarity determines loot token
        string sToken;

        //Centralized loot token get
        sToken = GetParcelByRarity(sRarity);

        //Add item to creature
        CreateItemOnObject(sToken, oMob, 1);
        nItemLoop = nItemLoop + 1;
    }

    //Random Name
    ExecuteScript("npc_randomname", OBJECT_SELF);
    ExecuteScript("NW_C2_DEFAULT9", OBJECT_SELF);
    ExecuteScript("tsw_scale_npcs", OBJECT_SELF);

    //Set rarity and add boss mods
    SetLocalString(oMob, "BOSS_RARITY", sRarity);
    SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND, "tsw_boss_mod");

}
