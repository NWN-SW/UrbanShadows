#include "utl_i_sqlplayer"
#include "tsw_faction_func"

int StartingConditional()
{
    string sFaction = GetFaction(GetPCSpeaker());
    if(sFaction != "Dragon" && sFaction != "Templar" && sFaction != "Illuminati")
    {
        return TRUE;
    }

    return FALSE;
}
