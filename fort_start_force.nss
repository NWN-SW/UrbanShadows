void main()
{
    string sVarName = "DEFENSE_START";
    object oFort = GetObjectByTag("TheEnd_WZ");
    int nEvent = GetLocalInt(oFort, sVarName);
    int nRand = Random(2);

    if(nEvent == 1)
    {
        ExecuteScript("othwld_sirens", OBJECT_SELF);
    }
    else
    {
        SetLocalInt(oFort, sVarName, nRand);
    }
}
