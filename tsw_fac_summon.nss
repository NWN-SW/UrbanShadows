#include "tsw_faction_func"

void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    string sTag = GetTag(oItem);
    string sFaction = GetFaction(oPC);
    object oArea = GetArea(oPC);
    string sAreaTag = GetTag(oArea);

    if(sTag != "SupportTransmitter1")
    {
        return;
    }

    if(sFaction == "Templar" && sAreaTag != "TheEnd_WZ" && sAreaTag != "PLAYER_PRISON")
    {
        object oAgent = CreateObject(OBJECT_TYPE_CREATURE, "tmp_fld_agent", GetLocation(oPC), TRUE);
        DelayCommand(120.0, DestroyObject(oAgent));
    }
    else if(sFaction == "Dragon" && sAreaTag != "TheEnd_WZ" && sAreaTag != "PLAYER_PRISON")
    {
        object oAgent = CreateObject(OBJECT_TYPE_CREATURE, "drg_fld_agent", GetLocation(oPC), TRUE);
        DelayCommand(120.0, DestroyObject(oAgent));
    }
    else if(sFaction == "Illuminati" && sAreaTag != "TheEnd_WZ" && sAreaTag != "PLAYER_PRISON")
    {
        object oAgent = CreateObject(OBJECT_TYPE_CREATURE, "ilu_fld_agent", GetLocation(oPC), TRUE);
        DelayCommand(120.0, DestroyObject(oAgent));
    }
    else
    {
        SendMessageToPC(oPC, "You are alone in this place. No help can reach you.");
    }
}
