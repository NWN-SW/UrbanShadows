#include "tsw_faction_func"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRank = GetRank(oPC);

    if(nRank >= 5)
    {
        return TRUE;
    }

    return FALSE;
}
