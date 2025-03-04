#include "gen_inc_color"
#include "loot_wep_type"
#include "inc_loot_rolls"
#include "inc_loot_stats"
#include "loot_gen_model"
#include "tsw_gen_trinket"
#include "tsw_gen_weapon"
#include "tsw_gen_armour"
#include "tsw_faction_func"

void LootTokenFaction(string sRarity, int nValue)
{
    //The token and person looting it.
    object oToken = GetModuleItemAcquired();
    object oLooter = GetModuleItemAcquiredBy();

    //Item manipulation is easier when done inside a container. We'll use a specific chest in a dev-only area.
    object oChest = GetObjectByTag("scriptchest_loot");

    //The amount of items to spawn
    int nRewardCount = nValue;
    int nItemLoop;

    //New loop to cycle through party members.
    if(oLooter != OBJECT_INVALID)
    {
        //Create random item in temporary chest to hold items while manipulation is happening.
        string sFaction = GetFaction(oLooter);
        if(sFaction == "Dragon")
        {
            LootGenerateTrinket(1, oLooter);
        }
        else if(sFaction == "Templar")
        {
            LootGenerateArmour(1, oLooter);
        }
        else if(sFaction == "Illuminati")
        {
            LootGenerateWeapon(1, oLooter);
        }


        //Call Caster Focus function. Has a chance to generate a random casting focus item.
        //LootCastingFocus(sRarity, oLooter);

        //Create variables for items created in the temporary chest.
        object oItem = GetFirstItemInInventory(oChest);
        object oNewItem = oItem;
        string sItemName;
        string sName;

        //Base item type.
        int nItemType;

        //Base item resref
        string sResRef = GetResRef(oItem);

        //Apply random set bonus to item then give to player.
        nItemLoop = 0;

        while(oItem != OBJECT_INVALID && nItemLoop < nRewardCount)
        {
            //We don't want to apply the normal loot rules/tags to weapons. So we'll check what item we have.
            nItemType = GetBaseItemType(oItem);
            //Rolls for name prefix and suffix
            int nPrefix = Random(50);
            int nSuffix = Random(50);
            //Check if the item is a cloak, helmet, belt, ring, amulet, boots, armour, or bracers. Large, small, tower shields too.
            if(nItemType == 80 || nItemType == 17 || nItemType == 45
            || nItemType == 26 || nItemType == 16
            || nItemType == 78 || nItemType == 56
            || nItemType == 14 || nItemType == 57)
            {
                //Apply name.
                sItemName = GetName(oItem);
                sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
                SetName(oItem, sName);
                //Apply stats on item based on rarity.
                GenArmourStats(sRarity, oItem);
                //Ensure item isn't identified and is droppable.
                SetIdentified(oItem, TRUE);;
                SetDroppableFlag(oItem, TRUE);
                //Put item in player's inventory.
                SetLocalString(oItem, "RARITY", sRarity);
                CopyItem(oItem, oLooter, TRUE);
                DestroyObject(oItem);
                //Roll for a new set for next loop.
                oItem = GetNextItemInInventory(oChest);
                nItemLoop = nItemLoop + 1;
            }
            else if(sResRef == "d_mclub" || sResRef == "d_mdagger"
            || sResRef == "d_msword" || sResRef == "d_massdagger"
            || sResRef == "d_mtorch" || sResRef == "d_mmace")
            {
                //Apply name.
                sItemName = GetName(oItem);
                sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
                SetName(oItem, sName);
                //Apply stats on item based on rarity.
                GenArmourStats(sRarity, oItem);
                //Ensure item isn't identified and is droppable.
                SetIdentified(oItem, TRUE);;
                SetDroppableFlag(oItem, TRUE);
                //Put item in player's inventory.
                SetLocalString(oItem, "RARITY", sRarity);
                CopyItem(oItem, oLooter, TRUE);
                DestroyObject(oItem);
                //Roll for a new set for next loop.
                oItem = GetNextItemInInventory(oChest);
                nItemLoop = nItemLoop + 1;
            }
            else if(nItemType == 78 || nItemType == 21
            || nItemType == 52 || nItemType == 19)
            {
                //Apply name.
                sItemName = GetName(oItem);
                sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
                SetName(oItem, sName);
                //Apply stats on item based on rarity.
                GenArmourStats(sRarity, oItem);
                //Ensure item isn't identified and is droppable.
                SetIdentified(oItem, TRUE);;
                SetDroppableFlag(oItem, TRUE);
                //Randomize appearance of item.
                oItem = LootGenerateModel(oNewItem);
                //Put item in player's inventory.
                SetLocalString(oItem, "RARITY", sRarity);
                CopyItem(oItem, oLooter, TRUE);
                DestroyObject(oItem);
                DestroyObject(oNewItem);
                //Roll for a new set for next loop.
                oItem = GetNextItemInInventory(oChest);
                nItemLoop = nItemLoop + 1;
            }
            else
            {
                //If it's a weapon, we do something different.
                sItemName = GetName(oItem);
                if(nItemType != 8 && nItemType != 6)
                {
                    sItemName = LootWeaponType(oItem);
                }
                sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
                SetName(oItem, sName);
                //Ensure item isn't identified
                SetIdentified(oItem, TRUE);
                //Change the model of Gauntlets. Function does type check for us.
                //Apply stats to item based on rarity
                GenWeaponStats(sRarity, oNewItem);
                //Put item in player's inventory.
                SetDroppableFlag(oNewItem, TRUE);
                if(nItemType == 36)
                {
                    //Randomize appearance of item.
                    oItem = LootGenerateModel(oNewItem);
                    //Put item in player's inventory.
                    SetLocalString(oItem, "RARITY", sRarity);
                    CopyItem(oItem, oLooter, TRUE);
                    DestroyObject(oItem);
                    DestroyObject(oNewItem);
                }
                else
                {
                    SetLocalString(oItem, "RARITY", sRarity);
                    CopyItem(oItem, oLooter, TRUE);
                    DestroyObject(oNewItem);
                }
                //Roll for a new set for next loop.
                oItem = GetNextItemInInventory(oChest);
                nItemLoop = nItemLoop + 1;
            }
        }
    }
    //Destoy leftovers
    DestroyObject(oToken);
}

