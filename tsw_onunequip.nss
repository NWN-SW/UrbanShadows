#include "spell_dmg_inc"

void main()
{
    //Update resource totals
    UpdateResources(GetPCItemLastUnequippedBy());
    UpdateBinds(GetPCItemLastUnequippedBy());
}
