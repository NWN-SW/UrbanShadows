void main()
{
    ExecuteScript("loot_focus_unacq");
    //ExecuteScript("tsw_item_cleanup");

    //Change Gold Name
    if(GetResRef(GetModuleItemLost()) == "nw_it_gold001")
    {
        SetName(GetModuleItemLost(), "Pax Romana");
    }
}
