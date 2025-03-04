void main()
{
    object oPC = GetExitingObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    DeleteLocalInt(oPC, "E_P_3_IN");
}
