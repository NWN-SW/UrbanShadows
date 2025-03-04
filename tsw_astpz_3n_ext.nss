void main()
{
    //Track players in area with sword parts.
    object oNPC = GetExitingObject();

    //Don't check items if it's not a PC
    if(GetIsPC(oNPC))
    {
        return;
    }
    else
    {
        string sRitual = "ASTORIA_RITUAL_AREA";
        SetLocalInt(oNPC, sRitual, 0);
    }
}
