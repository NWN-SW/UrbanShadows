#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();

    //Do party count
    int nCounter;
    object oParty = GetFirstFactionMember(oPC);
    while(oParty != OBJECT_INVALID)
    {
        nCounter = nCounter + 1;
        oParty = GetNextFactionMember(oPC);
    }

    if(nCounter > 5)
    {
        SendMessageToPC(oPC, "Your party cannot have more than five people in it for this mission.");
        return;
    }

    object oMainArea = GetObjectByTag("OE_Defense_Tunnel_1");
    string sPCName = GetPCPlayerName(oPC);
    int nLength = GetStringLength(sPCName);
    string sClipped = sPCName;
    if(nLength > 15)
    {
        sClipped = GetStringLeft(sPCName, 15);
    }

    //Copy the area for player
    object oNewArea = CopyArea(oMainArea, "OE_" + sClipped + "_DEF_TUN", "");
    string sNewTag = GetTag(oNewArea);

    //Get teleport waypoint
    object oWP = GetObjectByTag("TUNNEL_SPAWNER_2");
    location lSaved = GetLocation(oWP);
    location lJump = Location(oNewArea, GetPositionFromLocation(lSaved), 0.0);

    //Teleport players
    oParty = GetFirstFactionMember(oPC);
    while(oParty != OBJECT_INVALID)
    {
        DelayCommand(1.75, AssignCommand(oParty, ClearAllActions()));
        DelayCommand(2.0, AssignCommand(oParty, ActionJumpToLocation(lJump)));
        oParty = GetNextFactionMember(oPC);
    }
}
