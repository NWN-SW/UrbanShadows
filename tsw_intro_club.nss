void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC))
    {
        object oClub = CreateItemOnObject("intro_club", oPC);
        AssignCommand(oPC, ActionEquipItem(oClub, INVENTORY_SLOT_RIGHTHAND));
        DelayCommand(3.0, ExecuteScript("tsw_intro_clbmsg", oPC));
    }
}
