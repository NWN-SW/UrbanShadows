#include "pals_main"
#include "inc_loot_rolls"

void main()
{
    object oMob = OBJECT_SELF;
    int nLootCount = 1;
    string sRarity;
    int nRandom;

    //Make creature bigger
    string sTag = GetTag(OBJECT_SELF);
    if(sTag != "Shanuud" && sTag != "Fathomless")
    {
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.25);
    }
    else if(sTag == "Shanuud")
    {
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.5);
    }
    else if(sTag == "Fathomless")
    {
        SetObjectVisualTransform(OBJECT_SELF, 10, 0.75);
    }
    else if(sTag == "TyrantTrueFlame")
    {
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.5);
    }
    if (sTag == "oasisfilthboss")
    {
      SetObjectVisualTransform(oMob, 10, 2.0f);
    }
    //Create token on creature
    int nItemLoop = 0;
    while(nItemLoop < nLootCount)
    {
        //Determine rarity of item
        sRarity = GetT4Rarity();

        //Rarity determines loot token
        string sToken;

        //Centralized loot token get
        sToken = GetParcelByRarity(sRarity);

        //Add item to creature
        CreateItemOnObject(sToken, oMob, 1);
        nItemLoop = nItemLoop + 1;
    }

    //Random Name
    if(sTag != "Shanuud" &&
    sTag != "N12DoctorVladmirova"&&
    sTag != "SubjectA1" &&
    sTag != "Fathomless" &&
    sTag != "TyrantTrueFlame" &&
    sTag !="oasisfilthboss")
    {
        ExecuteScript("npc_randomname", OBJECT_SELF);
        //Set rarity and add boss mods
        SetLocalString(oMob, "BOSS_RARITY", sRarity);
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND, "tsw_boss_mod");
    }
    ExecuteScript("NW_C2_DEFAULT9", OBJECT_SELF);
    ExecuteScript("tsw_scale_npcs", OBJECT_SELF);

    //Add Reputation onDeath Variable
    int nRep;
    if(sRarity == "Common")
    {
        nRep = 1;
    }
    else if(sRarity == "Uncommon")
    {
        nRep = 1;
    }
    else if(sRarity == "Rare")
    {
        nRep = 2;
        SetLocalInt(OBJECT_SELF, "GIVE_DEATH_REP", nRep);
    }
    else if(sRarity == "Legendary")
    {
        nRep = 4;
        SetLocalInt(OBJECT_SELF, "GIVE_DEATH_REP", nRep);
    }
}
