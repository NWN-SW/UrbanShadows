#include "gen_inc_color"
#include "loot_gen_items"
#include "loot_wep_type"
#include "inc_loot_rolls"
#include "inc_loot_stats"
#include "loot_gen_model"
#include "loot_focus_gen"

void LootTokenReward(string sRarity, int nValue, int nShard, string sBoss, int nUptier)
{
    //The token and person looting it.
    object oToken = GetModuleItemAcquired();
    object oLooter = GetModuleItemAcquiredBy();
    //The first member in the party list, can be the looter.
    object oPC = GetFirstFactionMember(oLooter, TRUE);

    //In order to prevent party members in other zones getting free loot, we'll do an area comparison.
    object oArea = GetArea(oLooter);
    object oAreaParty = GetArea(oPC);

    //Item manipulation is easier when done inside a container. We'll use a specific chest in a dev-only area.
    object oChest = GetObjectByTag("scriptchest_loot");

    //The amount of items to spawn
    int nRewardCount = nValue;
    int nItemLoop;

    //New loop to cycle through party members.
    while(oPC != OBJECT_INVALID)
    {
        if(oArea == oAreaParty)
        {
            //Create random item in temporary chest to hold items while manipulation is happening.
            LootGenerateItems(nRewardCount, oPC);

            //Call Caster Focus function. Has a chance to generate a random casting focus item.
            LootCastingFocus(sRarity, oPC);

            //Create variables for items created in the temporary chest.
            object oItem = GetFirstItemInInventory(oChest);
            object oNewItem = oItem;
            object oFinalItem;
            string sItemName;
            string sName;

            //Base item type.
            string sItemType;
            int nItemType;

            //Base item resref
            string sResRef = GetResRef(oItem);

            //Apply random set bonus to item then give to player.
            nItemLoop = 0;

            while(oItem != OBJECT_INVALID && nItemLoop < nRewardCount)
            {
                //We don't want to apply the normal loot rules/tags to weapons. So we'll check what item we have.
                sItemType = GetLocalString(oItem, "BASE_ITEM_TYPE");
                nItemType = GetBaseItemType(oItem);
                //Rolls for name prefix and suffix
                int nPrefix = Random(50);
                int nSuffix = Random(50);
                //Check if the item is a cloak, helmet, belt, ring, amulet, boots, armour, or bracers. Large, small, tower shields too.
                if(sItemType == "Armour")
                {
                    //Apply name.
                    sItemName = GetName(oItem);
                    sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity, nUptier, sItemType);
                    SetName(oItem, sName);
                    //Apply stats on item based on rarity.
                    GenArmourStats(sRarity, oItem, nUptier);
                    //Ensure item isn't identified and is droppable.
                    SetIdentified(oItem, TRUE);
                    SetDroppableFlag(oItem, TRUE);
                    //Assign rarity string
                    if (nUptier == 0)
                    {
                        SetLocalString(oItem, "RARITY", sRarity);
                    }
                    else if (nUptier == 1)
                    {
                        SetLocalString(oItem, "RARITY", sRarity + "+");
                    }
                    oFinalItem = CopyItem(oItem, oPC, TRUE);
                    //Add quality
                    SetQuality(oFinalItem, sRarity, nUptier);
                    DestroyObject(oItem);
                    //Roll for a new set for next loop.
                    oItem = GetNextItemInInventory(oChest);
                    nItemLoop = nItemLoop + 1;
                }
                else if(sItemType == "Gear")
                {
                    //Apply name.
                    sItemName = GetName(oItem);
                    sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity, nUptier, sItemType);
                    SetName(oItem, sName);
                    //Apply stats on item based on rarity.
                    GenArmourStats(sRarity, oItem, nUptier);
                    //Ensure item isn't identified and is droppable.
                    SetIdentified(oItem, TRUE);
                    SetDroppableFlag(oItem, TRUE);
                    //Randomize appearance of item.
                    oItem = LootGenerateModel(oNewItem);
                    //Put item in player's inventory.
                    if (nUptier == 0)
                    {
                        SetLocalString(oItem, "RARITY", sRarity);
                    }
                    else if (nUptier == 1)
                    {
                        SetLocalString(oItem, "RARITY", sRarity + "+");
                    }
                    oFinalItem = CopyItem(oItem, oPC, TRUE);
                    //Add quality
                    SetQuality(oFinalItem, sRarity, nUptier);
                    DestroyObject(oItem);
                    DestroyObject(oNewItem);
                    //Roll for a new set for next loop.
                    oItem = GetNextItemInInventory(oChest);
                    nItemLoop = nItemLoop + 1;
                }
                else if(sItemType == "1H_Weapon")
                {
                    //If it's a weapon, we do something different.
                    sItemName = GetName(oItem);
                    sItemName = LootWeaponType(oItem);
                    sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity, nUptier, sItemType);
                    SetName(oItem, sName);
                    //Ensure item isn't identified
                    SetIdentified(oItem, TRUE);
                    //Change the model of Gauntlets. Function does type check for us.
                    //Apply stats to item based on rarity
                    GenWeaponStats(sRarity, oNewItem, nUptier);
                    //Put item in player's inventory.
                    SetDroppableFlag(oNewItem, TRUE);

                    //AssignCommand(oChest, ActionGiveItem(oNewItem, oPC));
                    if (nUptier == 0)
                    {
                        SetLocalString(oItem, "RARITY", sRarity);
                    }
                    else if (nUptier == 1)
                    {
                        SetLocalString(oItem, "RARITY", sRarity + "+");
                    }
                    oFinalItem = CopyItem(oNewItem, oPC, TRUE);
                    DestroyObject(oNewItem);

                    //Add quality
                    SetQuality(oFinalItem, sRarity, nUptier);

                    //Roll for a new set for next loop.
                    oItem = GetNextItemInInventory(oChest);
                    nItemLoop = nItemLoop + 1;
                }
                else if(sItemType == "2H_Weapon")
                {
                    //If it's a weapon, we do something different.
                    sItemName = GetName(oItem);
                    if(nItemType != 11 && nItemType != 7 && nItemType != 6)
                    {
                        sItemName = LootWeaponType(oItem);
                    }
                    sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity, nUptier, sItemType);
                    SetName(oItem, sName);
                    //Ensure item isn't identified
                    SetIdentified(oItem, TRUE);
                    //Change the model of Gauntlets. Function does type check for us.
                    //Apply stats to item based on rarity
                    GenWeaponStats(sRarity, oNewItem, nUptier);

                    //If gloves, we call special stat block.
                    if(nItemType == 36)
                    {
                        //Glove-specific stats
                        GenGloveStats(sRarity, oNewItem, nUptier);
                        //Randomize appearance of item.
                        oItem = LootGenerateModel(oNewItem);
                        //Set Variables
                        if (nUptier == 0)
                        {
                            SetLocalString(oItem, "RARITY", sRarity);
                        }
                        else if (nUptier == 1)
                        {
                            SetLocalString(oItem, "RARITY", sRarity + "+");
                        }
                        oFinalItem = CopyItem(oItem, oPC, TRUE);
                        //Add quality
                        SetQuality(oFinalItem, sRarity, nUptier);
                        DestroyObject(oItem);
                        DestroyObject(oNewItem);
                    }
                    //If regular 2H weapon, add one block of Armour stats
                    else
                    {
                        GenArmourStats(sRarity, oNewItem, nUptier);
                        //Set Droppable
                        SetDroppableFlag(oNewItem, TRUE);
                        if (nUptier == 0)
                        {
                            SetLocalString(oItem, "RARITY", sRarity);
                        }
                        else if (nUptier == 1)
                        {
                            SetLocalString(oItem, "RARITY", sRarity + "+");
                        }
                        oFinalItem = CopyItem(oNewItem, oPC, TRUE);
                        //Add quality
                        SetQuality(oFinalItem, sRarity, nUptier);
                        DestroyObject(oNewItem);
                    }
                    //Roll for a new set for next loop.
                    oItem = GetNextItemInInventory(oChest);
                    nItemLoop = nItemLoop + 1;
                }
                else if(sItemType == "Ranged_Weapon")
                {
                    //If it's a weapon, we do something different.
                    sItemName = GetName(oItem);
                    sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity, nUptier, sItemType);
                    SetName(oItem, sName);
                    //Ensure item isn't identified
                    SetIdentified(oItem, TRUE);
                    //Change the model of Gauntlets. Function does type check for us.
                    //Apply stats to item based on rarity
                    GenArmourStats(sRarity, oNewItem, nUptier);
                    GenWeaponStats(sRarity, oNewItem, nUptier);
                    //Put item in player's inventory.
                    SetDroppableFlag(oNewItem, TRUE);
                    //AssignCommand(oChest, ActionGiveItem(oNewItem, oPC));
                    if (nUptier == 0)
                    {
                        SetLocalString(oItem, "RARITY", sRarity);
                    }
                    else if (nUptier == 1)
                    {
                        SetLocalString(oItem, "RARITY", sRarity + "+");
                    }
                    oFinalItem = CopyItem(oNewItem, oPC, TRUE);
                    //Add quality
                    SetQuality(oFinalItem, sRarity, nUptier);
                    DestroyObject(oNewItem);
                    //Roll for a new set for next loop.
                    oItem = GetNextItemInInventory(oChest);
                    nItemLoop = nItemLoop + 1;
                }
                else
                {
                    SendMessageToPC(oPC, "Critical error for item:" + IntToString(GetBaseItemType(oItem)));
                    SendMessageToPC(oPC, "Escaping loop.");
                    return;
                }
            }
        }
        oPC = GetNextFactionMember(oLooter, TRUE);
        oAreaParty = GetArea(oPC);
    }
    //Destoy leftovers
    DestroyObject(oToken);
}

