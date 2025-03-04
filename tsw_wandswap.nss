#include "nw_i0_tool"

void main()
{

    object oPC  = GetPCSpeaker();
    if(HasItem(oPC,"Kitchen_WitchIt")) {
        ActionTakeItem(GetItemPossessedBy(oPC,"Kitchen_WitchIt"),oPC);
        CreateItemOnObject("kitchen_witchit",oPC);
    }

}
