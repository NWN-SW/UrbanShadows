#include "tsw_faction_func"
#include "tsw_fac_grp_tkn"

void main()
{
    object oPC = GetModuleItemAcquiredBy();
    object oItem = GetModuleItemAcquired();

    if(GetTag(oItem) != "SupportTransmitter" && GetTag(oItem) != "ReinforcementBeacon" &&
       GetTag(oItem) != "pc_defib_fac"       && GetTag(oItem) != "EmergencyBeacon" && GetTag(oItem) != "AnimaInfusion" &&
       GetTag(oItem) != "RareAlchemiteToken" && GetTag(oItem) != "FactionTokenT3")
    {
        return;
    }

    int nCheck;
    int nRank = GetRank(oPC);
    int nValue;

    //Summon friendly agent item
    if(GetTag(oItem) == "SupportTransmitter" && nRank >= 3)
    {
        nCheck = TakeReputation(oPC, 12);
        if(nCheck == 0)
        {
            nValue = GetGoldPieceValue(oItem);
            GiveGoldToCreature(oPC, nValue);
            DestroyObject(oItem);
        }
        else if(nCheck == 1)
        {
            SetTag(oItem, "SupportTransmitter1");
        }
    }
    else if(GetTag(oItem) == "SupportTransmitter" && nRank < 3)
    {
        nValue = GetGoldPieceValue(oItem);
        GiveGoldToCreature(oPC, nValue);
        DestroyObject(oItem);
        SendMessageToPC(oPC, "You must be rank 3 or higher to purchase this item.");
    }

    //Summon allies item
    if(GetTag(oItem) == "ReinforcementBeacon" && nRank >= 5)
    {
        nCheck = TakeReputation(oPC, 20);
        if(nCheck == 0)
        {
            nValue = GetGoldPieceValue(oItem);
            GiveGoldToCreature(oPC, nValue);
            DestroyObject(oItem);
        }
        else if(nCheck == 1)
        {
            SetTag(oItem, "ReinforcementBeacon1");
        }
    }
    else if(GetTag(oItem) == "ReinforcementBeacon" && nRank < 5)
    {
        nValue = GetGoldPieceValue(oItem);
        GiveGoldToCreature(oPC, nValue);
        DestroyObject(oItem);
        SendMessageToPC(oPC, "You must be rank 5 or higher to purchase this item.");
    }

    //Revive item
    if(GetTag(oItem) == "pc_defib_fac" && nRank >= 3)
    {
        nCheck = TakeReputation(oPC, 10);
        if(nCheck == 0)
        {
            nValue = GetGoldPieceValue(oItem);
            GiveGoldToCreature(oPC, nValue);
            DestroyObject(oItem);
        }
        else if(nCheck == 1)
        {
            SetTag(oItem, "pc_defib_fac1");
        }
    }
    else if(GetTag(oItem) == "pc_defib_fac" && nRank < 3)
    {
        nValue = GetGoldPieceValue(oItem);
        GiveGoldToCreature(oPC, nValue);
        DestroyObject(oItem);
        SendMessageToPC(oPC, "You must be rank 3 or higher to purchase this item.");
    }

    //Emergency beacon
    if(GetTag(oItem) == "EmergencyBeacon" && nRank >= 2)
    {
        nCheck = TakeReputation(oPC, 3);
        if(nCheck == 0)
        {
            nValue = GetGoldPieceValue(oItem);
            GiveGoldToCreature(oPC, nValue);
            DestroyObject(oItem);
        }
        else if(nCheck == 1)
        {
            SetTag(oItem, "EmergencyBeacon1");
        }
    }
    else if(GetTag(oItem) == "EmergencyBeacon" && nRank < 2)
    {
        nValue = GetGoldPieceValue(oItem);
        GiveGoldToCreature(oPC, nValue);
        DestroyObject(oItem);
        SendMessageToPC(oPC, "You must be rank 2 or higher to purchase this item.");
    }

    //Vitality infusion
    if(GetTag(oItem) == "AnimaInfusion" && nRank >= 2)
    {
        nCheck = TakeReputation(oPC, 5);
        if(nCheck == 0 )
        {
            nValue = GetGoldPieceValue(oItem);
            GiveGoldToCreature(oPC, nValue);
            DestroyObject(oItem);
        }
        else if(nCheck == 1)
        {
            SetTag(oItem, "AnimaInfusion1");
        }
    }
    else if(GetTag(oItem) == "AnimaInfusion" && nRank < 2)
    {
        nValue = GetGoldPieceValue(oItem);
        GiveGoldToCreature(oPC, nValue);
        DestroyObject(oItem);
        SendMessageToPC(oPC, "You must be rank 2 or higher to purchase this item.");
    }

    //Group Token Item
    if(GetTag(oItem) == "FactionTokenT3" && nRank >= 5)
    {
        LootTokenFaction("Rare", 1);
    }
    else if(GetTag(oItem) == "FactionTokenT3" && nRank < 5)
    {
        nValue = GetGoldPieceValue(oItem);
        GiveGoldToCreature(oPC, nValue);
        DestroyObject(oItem);
        SendMessageToPC(oPC, "You must be rank 5 or higher to purchase this item.");
    }

    //Alchemite Token Item
    if(GetTag(oItem) == "RareAlchemiteToken" && nRank >= 4)
    {
        DestroyObject(oItem);
        ExecuteScript("tsw_genrarefocus");
    }
    else if(GetTag(oItem) == "RareAlchemiteToken" && nRank < 4)
    {
        nValue = GetGoldPieceValue(oItem);
        GiveGoldToCreature(oPC, nValue);
        DestroyObject(oItem);
        SendMessageToPC(oPC, "You must be rank 4 or higher to purchase this item.");
    }


}
