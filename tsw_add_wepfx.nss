void AddWeaponVFX(object oPC, string sElement)
{
    object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    itemproperty iProp = GetFirstItemProperty(oWep);
    itemproperty iVFX;
    int nType = GetItemPropertyType(iProp);
    int nCheck = 0;
    while(GetIsItemPropertyValid(iProp))
    {
        if(nType == ITEM_PROPERTY_VISUALEFFECT)
        {
            RemoveItemProperty(oWep, iProp);
        }
        iProp = GetNextItemProperty(oWep);
        nType = GetItemPropertyType(iProp);
    }

    //Determine type of VFX
    if(sElement == "Fire")
    {
        iVFX = ItemPropertyVisualEffect(ITEM_VISUAL_FIRE);
    }
    else if(sElement == "Cold")
    {
        iVFX = ItemPropertyVisualEffect(ITEM_VISUAL_COLD);
    }
    else if(sElement == "Electrical")
    {
        iVFX = ItemPropertyVisualEffect(ITEM_VISUAL_ELECTRICAL);
    }
    else if(sElement == "Evil")
    {
        iVFX = ItemPropertyVisualEffect(ITEM_VISUAL_EVIL);
    }
    else if(sElement == "Holy")
    {
        iVFX = ItemPropertyVisualEffect(ITEM_VISUAL_HOLY);
    }
    else if(sElement == "Sonic")
    {
        iVFX = ItemPropertyVisualEffect(ITEM_VISUAL_SONIC);
    }
    else if(sElement == "Acid")
    {
        iVFX = ItemPropertyVisualEffect(ITEM_VISUAL_ACID);
    }

    AddItemProperty(DURATION_TYPE_PERMANENT, iVFX, oWep);
}
