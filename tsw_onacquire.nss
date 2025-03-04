void main()
{
    //Global Variables
    object oItem = GetModuleItemAcquired();
    object oPC = GetModuleItemAcquiredBy();
    string sTag = GetTag(oItem);

    //Get rid of bugged PC Properties
    string sPropName = GetName(oItem, FALSE);
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    if(sPropName == "PC Properties" || GetResRef(oItem) == "x3_it_pchide")
    {
        if(oSkin != oItem)
        {
            //DestroyObject(oItem);
        }
    }

    //Remove old Trash Wands
    if(sTag == "TRASH_WAND")
    {
        DestroyObject(oItem);
    }

    //Loot acquired
    ExecuteScript("loot_token_acqu");
    //DM Rep Token
    ExecuteScript("tsw_dm_rep_tkns");

    //Faction items
    ExecuteScript("tsw_fac_itm_acq");
}
