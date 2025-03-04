#include "tsw_faction_func"

void main()
{
		
    SetFaction(GetPCSpeaker(), "Illuminati");
    CreateItemOnObject("ftoken_illum", GetPCSpeaker());
}
