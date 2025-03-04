void main()
{
    //Random Name
    ExecuteScript("npc_randomwalk", OBJECT_SELF);
    ExecuteScript("NW_C2_DEFAULT9", OBJECT_SELF);
    //ExecuteScript("tsw_scale_npcs", OBJECT_SELF);
    //ExecuteScript("tsw_npc_models", OBJECT_SELF);

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

    //Set size
    sTag = GetTag(OBJECT_SELF);
    if(sTag == "T1Dummy")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.4);
    }
    else if(sTag == "T2Dummy")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.5);
    }
    else if(sTag == "T3Dummy")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.6);
    }
    else if(sTag == "T4Dummy")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.7);
    }
    else if(sTag == "T5Dummy")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.8);
    }
    else if(sTag == "T6Dummy")
    {
        SetObjectVisualTransform(OBJECT_SELF, OBJECT_VISUAL_TRANSFORM_SCALE, 0.9);
    }
}
