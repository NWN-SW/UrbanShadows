void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    SetLocalInt(oPC, "E_P_3_IN", 1);
}
