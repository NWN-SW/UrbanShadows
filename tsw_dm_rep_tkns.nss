#include "tsw_faction_func"

void main()
{
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();

    if(GetTag(oItem) != "DM_Rep_TokenT1" && GetTag(oItem) != "DM_Rep_TokenT2" && GetTag(oItem) != "DM_Rep_TokenT3" && GetTag(oItem) != "DM_Rep_TokenT4")
    {
        return;
    }

    int nAmount = 0;
    if(GetTag(oItem) == "DM_Rep_TokenT1")
    {
        nAmount = 5;
    }
    else if(GetTag(oItem) == "DM_Rep_TokenT2")
    {
        nAmount = 10;
    }
    else if(GetTag(oItem) == "DM_Rep_TokenT3")
    {
        nAmount = 15;
    }
    else if(GetTag(oItem) == "DM_Rep_TokenT4")
    {
        nAmount = 20;
    }

    DestroyObject(oItem);
    AddReputation(oPC, nAmount);
    string sAmount = IntToString(nAmount);
    FloatingTextStringOnCreature("You gain " + sAmount + " reputation.", oPC, FALSE);
}
