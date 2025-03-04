#include "tsw_reforge_item"

void main()
{
    object oPC = GetPCSpeaker();
    object oGauntlets = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);

    int nGold = GetGold(oPC);
    if(nGold < 250000)
    {
        SendMessageToPC(oPC, "You do not have enough currency to reforge this item. Return when you have 250,000.");
        return;
    }

    if(GetBaseItemType(oGauntlets) == BASE_ITEM_BRACER)
    {
        ReforgeItem(oGauntlets);
    }
    else
    {
        ReforgeGauntlets(oGauntlets);
    }
    TakeGoldFromCreature(250000, oPC, TRUE);
}
