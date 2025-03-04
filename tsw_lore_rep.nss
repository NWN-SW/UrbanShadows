#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetItemActivator();
    string sName = GetName(oPC);
    object oLore = GetItemActivatedTarget();
    string sLoreName = GetName(oLore);
    int nLoreCheck = GetLocalInt(oLore, "LORE_ENTRY_THING");

    if(GetResRef(GetItemActivated()) != "fac_lore_itm")
    {
        return;
    }


    //Continue if the item is a lore entry
    if(nLoreCheck == 1)
    {
        int nPlayerCheck = SQLocalsPlayer_GetInt(oPC, sLoreName);
        if(nPlayerCheck != 1)
        {
            SQLocalsPlayer_SetInt(oPC, sLoreName, 1);
            FloatingTextStringOnCreature("Data entry recorded. Gained 4 faction reputation.", oPC, FALSE);
            AddReputation(oPC, 4);
        }
        else
        {
            SendMessageToPC(oPC, "You have already recorded this data for a faction.");
        }
    }


}
