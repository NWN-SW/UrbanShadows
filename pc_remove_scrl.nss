#include "mr_hips_inc"

void main()
{
    object oPC = GetEnteringObject();
    object oScroll = GetFirstItemInInventory(oPC);
    string sTag = GetTag(oScroll);

    while(oScroll != OBJECT_INVALID)
    {
        if(GetBaseItemType(oScroll) == 54 || GetBaseItemType(oScroll) == 105 || GetBaseItemType(oScroll) == 75)
        {
            if(sTag != "ScrollOfRecall")
            {
                DestroyObject(oScroll);
            }
        }
        oScroll = GetNextItemInInventory(oPC);
        sTag = GetTag(oScroll);
    }

    HIPS_On_ClientEnter();
}
