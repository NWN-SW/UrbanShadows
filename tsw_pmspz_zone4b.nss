void main()
{
    object oPC = GetExitingObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    DeleteLocalInt(oPC, "PMS_P_4_IN");
}
