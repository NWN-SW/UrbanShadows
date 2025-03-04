void main()
{
    int nClass1 = GetClassByPosition(1, OBJECT_SELF);
    int nClass2 = GetClassByPosition(2, OBJECT_SELF);
    int nClass3 = GetClassByPosition(3, OBJECT_SELF);
    if(nClass1 == 66 || nClass2 == 66 || nClass3 == 66)
    {
        SetLocalInt(OBJECT_SELF, "I_AM_BLOODMAGE", 1);
    }
    else
    {
        DeleteLocalInt(OBJECT_SELF, "I_AM_BLOODMAGE");
    }
}
