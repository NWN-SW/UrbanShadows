#include "utl_i_sqlplayer"
#include "tsw_faction_func"

int StartingConditional()
{
    string sFaction = GetFaction(GetPCSpeaker());
    if(sFaction == "Illuminati")
    {
        return TRUE;
    }

    return FALSE;
}
