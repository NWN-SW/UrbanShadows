#include "spell_dmg_inc"

void main()
{
    //Update resource totals
    UpdateResources(GetPCItemLastEquippedBy());
    UpdateBinds(GetPCItemLastUnequippedBy());

    //If equipping fist weapon, then unequip other hands or vice versa.
    object oPC = GetPCItemLastEquippedBy();
    object oItem = GetPCItemLastEquipped();
    int nDone;
    int nType = GetBaseItemType(oItem);
    if(nType == BASE_ITEM_GLOVES && (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC) != OBJECT_INVALID || GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC) != OBJECT_INVALID))
    {
        DelayCommand(0.2, ExecuteScript("tsw_unequip_main", oPC));
        SendMessageToPC(oPC, "You cannot use normal weapons with fist weapons.");
        nDone = 1;
    }

    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    int nGloveCheck = GetBaseItemType(oGloves);
    if(nGloveCheck == BASE_ITEM_GLOVES && (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC) != OBJECT_INVALID || GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC) != OBJECT_INVALID))
    {
        if(nDone != 1)
        {
            DelayCommand(0.2, ExecuteScript("tsw_unequip_glvs", oPC));
            SendMessageToPC(oPC, "You cannot use normal weapons with fist weapons.");
        }
    }
}
