#include "utl_i_sqlplayer"
#include "tsw_faction_func"

int StartingConditional()
{
    string sFaction = GetFaction(GetPCSpeaker());

    if ( sFaction == "Dragon" || sFaction == "Illuminati" || sFaction == "Templar" ) {
        return TRUE;
    }

    return FALSE;

}
