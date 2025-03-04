#include "gen_inc_color"
#include "loot_gen_items"
#include "loot_wep_type"
#include "inc_loot_rolls"
#include "inc_loot_stats"
#include "loot_gen_model"
#include "loot_focus_gen"

void ReforgeItem(object oBase)
{
    object oPC = GetPCSpeaker();
    string sResRef = GetResRef(oBase);

    //Hardcoded rarity
    string sRarity = "Legendary";

    //Item manipulation is easier when done inside a container. We'll use a specific chest in a dev-only area.
    object oChest = GetObjectByTag("scriptchest_loot");

    //Create a new empty item
    CreateItemOnObject(sResRef, oChest);

    //Create variables for items created in the temporary chest.
    object oItem = GetFirstItemInInventory(oChest);
    object oNewItem = oItem;
    string sItemName;
    string sName;
    //Base item type.
    int nItemType;


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
        sItemName = GetName(oNewItem);
        sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
        SetName(oItem, sName);
        //Apply stats on item based on rarity.
        GenArmourStats(sRarity, oItem, 0);
        //Ensure item isn't identified and is droppable.
        SetIdentified(oItem, TRUE);;
        SetDroppableFlag(oItem, TRUE);
        //Put item in player's inventory.
        //AssignCommand(oChest, ActionGiveItem(oItem, oPC));
        SetLocalString(oItem, "RARITY", sRarity);
        SetQuality(oItem, sRarity);
        CopyItem(oItem, oPC, TRUE);
        DestroyObject(oItem);
        DestroyObject(oBase);
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
        GenArmourStats(sRarity, oItem, 0);
        //Ensure item isn't identified and is droppable.
        SetIdentified(oItem, TRUE);;
        SetDroppableFlag(oItem, TRUE);
        //Put item in player's inventory.
        //AssignCommand(oChest, ActionGiveItem(oItem, oPC));
        SetLocalString(oItem, "RARITY", sRarity);
        SetQuality(oItem, sRarity);
        CopyItem(oItem, oPC, TRUE);
        DestroyObject(oItem);
        DestroyObject(oBase);
    }
    else if(nItemType == 78 || nItemType == 21
    || nItemType == 52 || nItemType == 19)
    {
        //Apply name.
        sItemName = GetName(oItem);
        sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
        SetName(oItem, sName);
        //Apply stats on item based on rarity.
        GenArmourStats(sRarity, oItem, 0);
        //Ensure item isn't identified and is droppable.
        SetIdentified(oItem, TRUE);;
        SetDroppableFlag(oItem, TRUE);
        //Randomize appearance of item.
        oItem = LootGenerateModel(oNewItem);
        //Put item in player's inventory.
        //AssignCommand(oChest, ActionGiveItem(oItem, oPC));
        SetLocalString(oItem, "RARITY", sRarity);
        SetQuality(oItem, sRarity);
        CopyItem(oItem, oPC, TRUE);
        DestroyObject(oItem);
        DestroyObject(oNewItem);
        DestroyObject(oBase);
    }
    else
    {
        //If it's a weapon, we do something different.
        sItemName = GetName(oItem);
        if(nItemType != 11 && nItemType != 7 && nItemType != 6)
        {
            sItemName = LootWeaponType(oItem);
        }
        sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
        SetName(oItem, sName);
        //Ensure item isn't identified
        SetIdentified(oItem, TRUE);
        //Change the model of Gauntlets. Function does type check for us.
        //Apply stats to item based on rarity
        GenWeaponStats(sRarity, oNewItem, 0);

        if(nItemType == 36)
        {
            //Glove-specific stats
            GenGloveStats(sRarity, oNewItem, 0);
            //Randomize appearance of item.
            oItem = LootGenerateModel(oNewItem);
            //Set Variables
            SetLocalString(oItem, "RARITY", sRarity);
            object oFinalItem = CopyItem(oItem, oPC, TRUE);
            //Add quality
            SetQuality(oFinalItem, sRarity);
            DestroyObject(oItem);
            DestroyObject(oNewItem);
        }
        else
        {
            //AssignCommand(oChest, ActionGiveItem(oNewItem, oPC));
            SetLocalString(oItem, "RARITY", sRarity);
            CopyItem(oNewItem, oPC, TRUE);
            DestroyObject(oNewItem);
        }
        DestroyObject(oBase);
    }
    effect eBoom = EffectVisualEffect(VFX_FNF_DISPEL);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, GetLocation(oPC));

}

void ReforgeGauntlets2(string sRarity, object oNewItem, object oItem, object oBase, object oPC)
{
    //Glove-specific stats
    GenGloveStats(sRarity, oNewItem, 0);
    //Randomize appearance of item.
    oItem = LootGenerateModel(oNewItem);
    //Set Variables
    SetLocalString(oItem, "RARITY", sRarity);
    SetQuality(oItem, sRarity);
    object oFinalItem = CopyItem(oItem, oPC, TRUE);
    //Add quality
    DestroyObject(oItem);
    DestroyObject(oNewItem);

    DestroyObject(oBase);
}

void ReforgeGauntlets(object oBase)
{
    object oPC = GetPCSpeaker();
    string sResRef = GetResRef(oBase);

    //Hardcoded rarity
    string sRarity = "Legendary";

    //Item manipulation is easier when done inside a container. We'll use a specific chest in a dev-only area.
    object oChest = GetObjectByTag("scriptchest_loot");

    //Create a new empty item
    CreateItemOnObject(sResRef, oChest);

    //Create variables for items created in the temporary chest.
    object oItem = GetFirstItemInInventory(oChest);
    object oNewItem = oItem;
    string sItemName;
    string sName;
    //Base item type.
    int nItemType;

    //Rolls for name prefix and suffix
    int nPrefix = Random(50);
    int nSuffix = Random(50);

    //If it's a weapon, we do something different.
    sItemName = GetName(oItem);

    sName = GetItemName(sItemName, nPrefix, nSuffix, sRarity);
    SetName(oItem, sName);
    //Ensure item isn't identified
    SetIdentified(oItem, TRUE);
    //Change the model of Gauntlets. Function does type check for us.
    //Apply stats to item based on rarity
    GenWeaponStats(sRarity, oNewItem, 0);

    DelayCommand(1.0, ReforgeGauntlets2(sRarity, oNewItem, oItem, oBase, oPC));

    effect eBoom = EffectVisualEffect(VFX_FNF_DISPEL);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, GetLocation(oPC));

}

