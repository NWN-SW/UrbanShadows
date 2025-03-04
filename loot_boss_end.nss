void main()
{
    object oMob = OBJECT_SELF;
    object oChest = GetObjectByTag("scriptchest_tokens");
    int nLootCount = 1;
    object oPC = GetFirstPC();

    //Create random item in temporary chest.
    int nItemLoop = 0;
    while(nItemLoop < nLootCount)
    {
        CreateItemOnObject("loottokentboss", oMob, 1);
        nItemLoop = nItemLoop + 1;
    }

    //Get Chest Token
    object oItem = GetFirstItemInInventory(oChest);
    nItemLoop = 0;

    while(oItem != OBJECT_INVALID && nItemLoop < nLootCount)
    {
        //Put item in dying creature's inventory.
        AssignCommand(oChest, ActionGiveItem(oItem, oMob));
        SetDroppableFlag(oItem, TRUE);
        nItemLoop = nItemLoop + 1;
    }
}
