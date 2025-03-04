void main()
{
    object oPC = GetExitingObject();
    string sVarIntName = "PC_COUNT";
    int nPCCount = GetLocalInt(OBJECT_SELF, sVarIntName);
    int nCount = 0;

    if(GetIsPC(oPC) && !GetIsDM(oPC))
    {
        nCount = nPCCount - 1;
        if (nCount < 1)
        {
            nCount = 1;
            SetLocalInt(OBJECT_SELF, sVarIntName, nCount);
        }
    }
}
