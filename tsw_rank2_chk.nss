#include "tsw_faction_func"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRank = GetRank(oPC);

    if(nRank >= 2)
    {
        return TRUE;
    }

    return FALSE;
}
