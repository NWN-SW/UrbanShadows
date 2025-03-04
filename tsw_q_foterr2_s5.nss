//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//::
//:: Stage 6: Player debriefed by Ana after having killed Khan. Quest Complete.
//:: NPC Quest Giver: Ana Catagena
//:://////////////////////////////////////////////

#include "nw_i0_tool"
#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sFaction = GetFaction(oPC);
    int nCheck = SQLocalsPlayer_GetInt(GetPCSpeaker(), "Q_FOTERRA2");


    //templar only quest variant of missing bee quest conclusion, completed before templar member
    if(nCheck == 5)
    {
        SQLocalsPlayer_SetInt(GetPCSpeaker(), "Q_FOTERRA2", 6);
        AddJournalQuestEntry("Q_FOTerra2", 6, GetPCSpeaker(), FALSE);
        CreateItemOnObject("shoptokent4", oPC);
        AddReputation(oPC, 25);
    }

}
