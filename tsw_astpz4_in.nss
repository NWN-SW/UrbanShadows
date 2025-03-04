void main()
{
    object oPC = GetEnteringObject();
    if(!GetIsPC(oPC))
    {
        return;
    }

    SetLocalInt(oPC, "AST_PUZZLE4_IN", 1);
}
