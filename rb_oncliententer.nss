void main()
{
    object oEntering = GetEnteringObject();

    if (!GetIsObjectValid(GetItemPossessedBy(oEntering, "RB_DiceBag")))
    {
        CreateItemOnObject("rb_dicebag", oEntering);
        CreateItemOnObject("d_boots", oEntering);
        CreateItemOnObject("orbofrecall", oEntering);
        GiveGoldToCreature(oEntering, 5000);
    }
}
