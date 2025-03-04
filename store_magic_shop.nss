#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oStore = GetNearestObjectByTag("ArandhelsShop");
    object oFactionStore = GetNearestObjectByTag("ArandhelsShopF");

    //Faction Stuff
    object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    int nRank = GetRank(oPC);

    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        if(nRank >= 1 && sFaction != "")
        {
            OpenStore(oFactionStore, GetPCSpeaker());
        }
        else
        {
            OpenStore(oStore, GetPCSpeaker());
        }

    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
