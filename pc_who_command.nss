#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCChatSpeaker();
    string sMessage = GetStringLowerCase(GetPCChatMessage());
    string sPCFaction = "";
    int nOptOut;
	
   object oPC1 = GetFirstPC();
   while (GetIsObjectValid(oPC1))
   {
	  string sArea = GetName(GetArea(oPC1));
	  //Check the player's hidden toggle
	  nOptOut = SQLocalsPlayer_GetInt(oPC1, "WHO_COMMAND_TOGGLE");
	  sPCFaction = "";

	  //If the person is hidden, display hidden area
	  if(nOptOut == 1)
	  {
		if (!GetIsDM(oPC) && !GetIsDMPossessed(oPC))
		{
		sArea = "Hidden";
		}

	 }
	if (GetIsDM(oPC) || GetIsDMPossessed(oPC) || oPC == oPC1)
		{
			string sGetPCFaction = GetFaction(oPC1);
			if (sGetPCFaction == "")
				sGetPCFaction ="No Faction";
		   sPCFaction = " (" + sGetPCFaction + ") ";
		}
	  if (!GetIsDM(oPC1) && !GetIsDMPossessed(oPC1))
		{
			string sName = GetName(oPC1);
			string pcMessage = sName + sPCFaction +" - " + sArea;
			SendMessageToPC(oPC, pcMessage);
		}
	  oPC1 = GetNextPC();
   }
	SetPCChatVolume(TALKVOLUME_TELL); // Make it a tell.
}
