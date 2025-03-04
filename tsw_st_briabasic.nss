#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oStore = GetNearestObjectByTag("Bria_Shop_Basic");

    //Faction Stuff
    object oPC = GetPCSpeaker();
    OpenStore(oStore, GetPCSpeaker());

}
