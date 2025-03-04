#include "pals_main"
#include "inc_loot_rolls"
#include "npc_rndm_boss"

void main()
{
    object oMob = OBJECT_SELF;
    int nLootCount = 1;

    //Get the drop chance for this enemy
    int nChance = GetLocalInt(oMob, "LOOT_DROP_CHANCE");

    //Determine rarity of item
    string sRarity;
    int nTier = GetLocalInt(oMob, "CREATURE_DEF_TIER");
    if(nTier >= 1 && nTier <= 2)
    {
        sRarity = GetT1Rarity();
    }
    else if(nTier >= 3 && nTier <= 4)
    {
        sRarity = GetT2Rarity();
    }
    else if(nTier >= 5 && nTier <= 6)
    {
        sRarity = GetT3Rarity();
    }
    else if(nTier >= 7)
    {
        sRarity = GetT4Rarity();
    }

    string sMobVFXScale = GetLocalString(OBJECT_SELF,"sMobVFXScale");
    if (sMobVFXScale != "")
    {
        string sVFXID;
        string sScaleFactor;
        int iCommaIndex = FindSubString(sMobVFXScale,",",0);
        if (iCommaIndex == -1)
        {

            iCommaIndex=GetStringLength(sMobVFXScale);
             sVFXID = GetStringLeft(sMobVFXScale,iCommaIndex);
             sScaleFactor = "1.0f";
        }
        else
        {
             sVFXID = GetStringLeft(sMobVFXScale,iCommaIndex);
             sScaleFactor = GetSubString(sMobVFXScale,iCommaIndex+1, GetStringLength(sMobVFXScale)-(GetStringLength(sVFXID)+1));
        }

        effect eMobVFXPermanent = EffectVisualEffect(StringToInt(sVFXID));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMobVFXPermanent, OBJECT_SELF);
        SetObjectVisualTransform(OBJECT_SELF,OBJECT_VISUAL_TRANSFORM_SCALE,StringToFloat(sScaleFactor));

    }

    //Regular enemies have a 15% chance to drop loot.
    int nLootRoll = d100(1);

    //Rarity determines loot token
    string sToken;

    //Centralized loot token get
    sToken = GetParcelByRarity(sRarity);

    //Create token on creature if nDo is hit by random.
    if(nLootRoll <= nChance)
    {
        int nItemLoop = 0;
        while(nItemLoop < nLootCount)
        {
            CreateItemOnObject(sToken, oMob, 1);
            nItemLoop = nItemLoop + 1;
        }
    }

    if(GetResRef(OBJECT_SELF) != "agarthasentinel")
    {
        ChanceForBoss(sRarity);
    }

    //Random Name
    ExecuteScript("npc_randomwalk", OBJECT_SELF); // Scale NPCs is in here
    ExecuteScript("NW_C2_DEFAULT9", OBJECT_SELF);
    ExecuteScript("tsw_npc_models", OBJECT_SELF);

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
