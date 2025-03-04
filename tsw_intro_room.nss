void main()
{
    object oPC = GetEnteringObject();
    object oRadio = GetNearestObjectByTag("IntroBedRadio", oPC);
    object oDoor = GetNearestObjectByTag("IntroBedDoor", oPC);

    ExecuteScript("tsw_intro_radio", oRadio);
    DelayCommand(5.0, AssignCommand(oDoor, ActionUnlockObject(OBJECT_SELF)));
}
