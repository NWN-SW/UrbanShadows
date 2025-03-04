//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Sets quest stage to stage 13 when quest is completed.


#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FEYEST01");


    //templar only quest variant of missing bee quest conclusion
    if(nCheck == 12)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FEYEST01", 13);
        AddJournalQuestEntry("Q_FEYEST01", 13, GetPCSpeaker(), FALSE);
        CreateItemOnObject("shoptokent3", oPC);
		CreateItemOnObject("shoptokent3", oPC);
		CreateItemOnObject("shoptokent3", oPC);
		CreateItemOnObject("shoptokent3", oPC);
        AddReputation(oPC, 25);

        
    }


}
