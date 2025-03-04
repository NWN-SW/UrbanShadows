#include "pals_main"
#include "inc_loot_rolls"

void ChanceForBoss(string sRarity)
{
    int nRandom = 20;
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
        int nBonusHP = nMaxHP / 2;
        effect eDamage = EffectDamageIncrease(10);
        effect eAttack = EffectAttackIncrease(10);
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
        ExecuteScript("tsw_boss_tester2", OBJECT_SELF);
    }
}
