#include "pals_main"
#include "inc_loot_rolls"

void ChanceForBoss(string sRarity)
{
    int nRandom = Random(50);
    if(nRandom == 20)
    {
        object oMob = OBJECT_SELF;
        int nLootCount = 1;
        int nRandom;

        //Make creature bigger
        SetObjectVisualTransform(OBJECT_SELF, 10, 1.25);

        //Apply glow
        effect eVis = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oMob);

        //Apply rarity variable
        SetLocalString(oMob, "BOSS_RARITY", sRarity);

        //Add HP
        int nMaxHP = GetMaxHitPoints(oMob);
        int nBonusHP = nMaxHP;
        effect eDamage = EffectDamageIncrease(10);
        effect eAttack = EffectAttackIncrease(15);
        effect eLink = EffectLinkEffects(eDamage, eAttack);
        effect eHP = EffectTemporaryHitpoints(nBonusHP);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHP, oMob);
        //Only add other bonuses to higher tier enemies
        if(sRarity == "Rare" || sRarity == "Legendary")
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oMob);
        }

        //Create token on creature
        int nItemLoop = 0;
        while(nItemLoop < nLootCount)
        {
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
            else if(sRarity == "Legendary")
            {
                sToken = "loottokent4";
            }
            //Add item to creature
            CreateItemOnObject(sToken, oMob, 1);
            nItemLoop = nItemLoop + 1;
        }
        //Random Name
        ExecuteScript("npc_randomname", OBJECT_SELF);
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND, "tsw_boss_mod");

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
        }
        else if(sRarity == "Legendary")
        {
            nRep = 4;
        }
        SetLocalInt(OBJECT_SELF, "GIVE_DEATH_REP", nRep);

        //Set Models
        string sTag = GetTag(OBJECT_SELF);
        if(sTag == "hive_t1")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 1125));
        }
        else if(sTag == "hive_t3a")
        {
           DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 3253));
        }
        else if(sTag == "hive_t4a")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 1935));
        }
        else if(sTag == "hive_t4")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 2136));
        }
        else if(sTag == "hive_t2")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 1732));
        }
        else if(sTag == "EG_AshConvertF" || sTag == "EG_AshConvertM")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 4234));
        }
        else if(sTag == "djinn_t5a")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 4106));
        }
        else if(sTag == "djinn_t5b")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 4135));
        }
        else if(sTag == "djinn_t4a")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 3245));
        }
        else if(sTag == "djinn_t4")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 1348));
        }
        else if(sTag == "ghost_t4b")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 2973));
        }
        else if(sTag == "ghost_t4mob")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 2180));
        }
        else if(sTag == "Mockery")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 1048));
        }
        else if(sTag == "ghost_t5c")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 3897));
        }
        else if(sTag == "Hate")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 1104));
        }
        else if(sTag == "AST_Drowned_Main")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 4235));
        }
        else if(sTag == "ast_t6a")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 4043));
        }
        else if(sTag == "ast_t5_3")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 4237));
        }
        else if(sTag == "ast_t5_2")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 6768));
        }
        else if(sTag == "n12_t5b")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 6501));
        }
        else if(sTag == "n12_t5a")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 1883));
        }
        else if(sTag == "n12_t6a")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 3862));
        }
        else if(sTag == "Cannibal")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 3890));
        }
        else if(sTag == "CannibalFleshHunter")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 3878));
        }
        else if(sTag == "CannibalBoneChanter")
        {
            DelayCommand(0.5, SetCreatureAppearanceType(OBJECT_SELF, 3057));
        }

    }
}
