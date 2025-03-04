#include "inc_loot_rolls"

void GenSpecificFocus(string sRarity, object oPC)
{
    //Global Variables
    string sFocusName;
    string sElement;

    //Determine element of focus
    int nRoll = Random(12);
    switch(nRoll)
    {
        case 0:
            sElement = "Fire";
            break;
        case 1:
            sElement = "Cold";
            break;
        case 2:
            sElement = "Elec";
            break;
        case 3:
            sElement = "Acid";
            break;
        case 4:
            sElement = "Soni";
            break;
        case 5:
            sElement = "Magi";
            break;
        case 6:
            sElement = "Holy";
            break;
        case 7:
            sElement = "Nega";
            break;
        case 8:
            sElement = "Pierce";
            break;
        case 9:
            sElement = "Slash";
            break;
        case 10:
            sElement = "Bludge";
            break;
        case 11:
            sElement = "Summ";
            break;
        return;
    }

    //Generate the casting focus based on rarity and element.
    if(sElement == "Fire")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_fire_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_fire_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_fire_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_fire_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Cold")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_cold_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_cold_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_cold_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_cold_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Elec")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_elec_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_elec_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_elec_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_elec_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Acid")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_acid_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_acid_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_acid_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_acid_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Soni")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_soni_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_soni_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_soni_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_soni_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Magi")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_magi_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_magi_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_magi_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_magi_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Holy")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_holy_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_holy_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_holy_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_holy_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Nega")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_nega_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_nega_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_nega_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_nega_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Slash")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("foc_slash_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("foc_slash_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("foc_slash_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("foc_slash_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Pierce")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("foc_pierce_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("foc_pierce_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("foc_pierce_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("foc_pierce_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Bludge")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("foc_bludge_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("foc_bludge_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("foc_bludge_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("foc_bludge_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
    else if(sElement == "Summ")
    {
        if(sRarity == "Common")
        {
            object oFocus = CreateItemOnObject("focus_summ_comm", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Uncommon")
        {
            object oFocus = CreateItemOnObject("focus_summ_unco", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Rare")
        {
            object oFocus = CreateItemOnObject("focus_summ_rare", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
        else if(sRarity == "Legendary")
        {
            object oFocus = CreateItemOnObject("focus_summ_lege", oPC, 1);
            string sName = GetName(oFocus);
            string sNewName = GetFocusNameColour(sName, sRarity);
            SetName(oFocus, sNewName);
        }
    }
}
