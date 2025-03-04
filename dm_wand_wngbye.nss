void main()
{
    object oPC = GetItemActivatedTarget();
    object oItem = GetItemActivated();
    string sTag = GetTag(oItem);

    if(sTag == "DMWandRemoveWings")
    {
        SetCreatureWingType(0, oPC);
    }
}
