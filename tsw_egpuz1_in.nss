void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    SetLocalInt(oPC, "E_P_1_IN", 1);
}
