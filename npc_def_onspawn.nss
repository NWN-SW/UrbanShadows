void main()
{
    ExecuteScript("tsw_scale_npcs", OBJECT_SELF);
    ExecuteScript("NW_C2_DEFAULT9", OBJECT_SELF);
    ExecuteScript("tsw_npc_models", OBJECT_SELF);
    ExecuteScript("npc_ai_default", OBJECT_SELF);

    //Delete PC Prop
    object oItem = GetFirstItemInInventory();
    object oSlot = GetItemInSlot(17, OBJECT_SELF);
    string sRef = GetResRef(oItem);
    string sTag = GetTag(oItem);
    string sName = GetName(oItem);
    while (GetIsObjectValid(oItem))
    {
        if(sRef == "x3_it_pchide")
        {
            DestroyObject(oItem);
        }

        if(sTag == "x3_it_pchide")
        {
            DestroyObject(oItem);
        }
        if(sName == "PC Properties" && oItem == oSlot)
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory();
    }
}
