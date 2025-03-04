#include "utl_i_sqlplayer"
#include "m3_cosmetic_vfx"


void main()
{
    object oPC = GetItemActivator();
    object oVFXItem = GetItemActivated();
    string sVFXItemType = GetTag(oVFXItem);

    ActivateCosmeticVFX(oPC, oVFXItem, sVFXItemType, 0);
}

