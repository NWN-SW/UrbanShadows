#include "tsw_faction_func"

void main()
{
		
    SetFaction(GetPCSpeaker(), "Templar");
    CreateItemOnObject("ftoken_templar", GetPCSpeaker());
}
