#include "tsw_genspcfc_foc"

void main()
{
    object oPC = GetModuleItemAcquiredBy();

    GenSpecificFocus("Rare", oPC);
}
