#include "nw_i0_tool"
#include "tsw_faction_func"


void main()
{

    object oPC  = GetPCSpeaker();
	string sFactionToken = "ftoken_"+GetStringLowerCase(GetFaction(oPC,1));
	int iItemDestroyed;
	
		//GetFaction will not return anything if no Faction is set, so if the name remains "ftoken" it means the player doesn't have a faction
	if (sFactionToken == "ftoken_")
	{
		return;
	}
	
	object oInvObject = GetFirstItemInInventory(oPC);
	object oFactionID = GetItemPossessedBy(oPC, sFactionToken);
	string sObjRef = GetResRef(oInvObject);
	string sFactionIDRef = GetResRef(oFactionID);
	
	while (GetIsObjectValid(oInvObject))
	{

		if (sObjRef == sFactionIDRef)
		{
			DestroyObject(oInvObject);
			iItemDestroyed=1;
		}
		
		oInvObject = GetNextItemInInventory(oPC);
		sObjRef = GetResRef(oInvObject);
	}
	
	if (iItemDestroyed>=1)
	{
	  CreateItemOnObject(sFactionToken,oPC);
	}
}
