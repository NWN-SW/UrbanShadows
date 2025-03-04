#include "nw_i0_tool"

void main()
{
    object oPC = GetLastUsedBy();	
	object oItem = GetItemPossessedBy(oPC, "quest_cold_iron");
	CreateItemOnObject("quest_cold_iron", oPC);
	
	//FloatingTextStringOnCreature("You find a curious pendant among the trinkets.",oPC,FALSE);
	
}

