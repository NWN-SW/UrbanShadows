#include "tsw_reforge_item"

void main()
{
    object oPC = GetPCSpeaker();
    object oBoots = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);

    int nGold = GetGold(oPC);
    if(nGold < 250000)
    {
        SendMessageToPC(oPC, "You do not have enough currency to reforge this item. Return when you have 250,000.");
        return;
    }

    ReforgeItem(oBoots);
    TakeGoldFromCreature(250000, oPC, TRUE);
}
