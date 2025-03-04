void main()
{
    object oArea = GetArea(OBJECT_SELF);
    SetLocalObject(oArea, "T1_DUMMY", OBJECT_SELF);
    DelayCommand(1.0, ExecuteScript("tsw_respawn_plcb", oArea));
}
