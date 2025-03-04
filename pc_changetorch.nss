void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    int nModel = GetItemAppearance(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0);
    if(nModel >= 133)
    {
        nModel = 0;
    }
    else if(nModel == 2)
    {
        nModel = 6;
    }
    else if(nModel == 87)
    {
        nModel = 111;
    }
    else
    {
        nModel = nModel + 1;
    }
    object oNew = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nModel, TRUE);
    string sModel = IntToString(nModel);
    SendMessageToPC(oPC, "Model: " + sModel);
    DestroyObject(oItem);
    AssignCommand(oPC, ActionEquipItem(oNew, INVENTORY_SLOT_LEFTHAND));
}
