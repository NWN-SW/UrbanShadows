void main()
{
    object oTrash = GetModuleItemLost();
    int nCheck = GetLocalInt(oTrash, "TRASH_TIMER");
    if(GetItemPossessor(oTrash) == OBJECT_INVALID && nCheck == 0)
    {
        DelayCommand(300.0, ExecuteScript("tsw_item_cleanup"));
        SetLocalInt(oTrash, "TRASH_TIMER", 1);
    }
    else if(GetItemPossessor(oTrash) == OBJECT_INVALID && nCheck == 1)
    {
        DestroyObject(oTrash);
    }
    else if(GetIsPC(GetItemPossessor(oTrash)))
    {
        SetLocalInt(oTrash, "TRASH_TIMER", 0);
    }
}
