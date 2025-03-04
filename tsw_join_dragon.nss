#include "tsw_faction_func"

void main()
{
    	
	SetFaction(GetPCSpeaker(), "Dragon");
    CreateItemOnObject("ftoken_dragon", GetPCSpeaker());
}
