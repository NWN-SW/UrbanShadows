void main()
{
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetFirstPC();
    string sVarName = "iLocal";
    int iCheck = 0;

    //Check for players and DM avatars.
    while(oPC != OBJECT_INVALID)
    {
        if(GetArea(oPC) == oArea)
        {
            iCheck = 1;
            break;
        }
        oPC = GetNextPC();
    }

    if(iCheck == 0)
    {
        SetLocalInt(OBJECT_SELF, "SOUND_PLAYED", 0);
    }
}
