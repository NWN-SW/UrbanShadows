//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//:: Check if player has yet to receive the quest,
//:: NPC: Ana Catagena
//:: Location: Egypt
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");

    //Checking if player is at correct quest stage...
    if(nCheck != 1 && nCheck != 2)
    {
		//DebugMessage
		//SendMessageToPC(GetFirstPC(), "Debug Message2");
        return FALSE;
    }

    //Checking if we are dealing with one of the four quest info sources (plcs)...
    string sPlcTag = GetTag(OBJECT_SELF);
	int nPlcCheck1 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE1");
    int nPlcCheck2 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE2");
    int nPlcCheck3 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE3");
    int nPlcCheck4 = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_TTECHLORE4");

    if (sPlcTag == "tsw_q_ttlab1" && nPlcCheck1 == 1) {
		return FALSE;}
	
	if (sPlcTag == "tsw_q_ttlab2" && nPlcCheck2 == 1){
		return FALSE;}
	
	if (sPlcTag == "tsw_q_ttlab3" && nPlcCheck3 == 1){
		return FALSE;}
	
	if (sPlcTag == "tsw_q_ttlab4" && nPlcCheck4 == 1){
		return FALSE;}
	
    return TRUE;
}

