void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    SetLocalInt(oPC, "PMS_P_4_IN", 1);
}
