void main()
{
    ExecuteScript("tsw_facquest_1");

    ExecuteScript("pc_remove_scrl");

    int nCheck = GetLocalInt(OBJECT_SELF, "DOOR_PORTRAIT_SET");
    if(nCheck != 1)
    {
        ExecuteScript("tsw_setdoor_port");
        SetLocalInt(OBJECT_SELF, "DOOR_PORTRAIT_SET", 1);
    }
}
