#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    int nRank = GetRank(oPC);
    string sFaction = GetFaction(oPC);
    object oStore;

    if(sFaction == "Dragon" && nRank >= 1)
    {
        oStore = GetNearestObjectByTag("Dragon_Store");
    }
    else if(sFaction == "Templar" && nRank >= 1)
    {
        oStore = GetNearestObjectByTag("Templar_Store");
    }
    else if(sFaction == "Illuminati" && nRank >= 1)
    {
        oStore = GetNearestObjectByTag("Illuminati_Store");
    }

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        OpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
