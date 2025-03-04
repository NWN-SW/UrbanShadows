//::///////////////////////////////////////////////
//:: Quest: Fey Estate, Main Quest
//:: SQL Name: Q_FEYEST01
//:: Journal Name: Q_FeyEst01
//:: Questgiver NPC: Phonecall Trigger (Bria's) or Cassie in Edinburgh
//:: Location: Edinburgh
//:://////////////////////////////////////////////

//:: Sets quest stage to stage 12 if kills the Handmaiden.

#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastKiller();
    object oParty;
    int nCheck;

    //Make sure oPC is a player
    if(!GetIsPC(oPC))
    {
        oPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        while(oPC != OBJECT_INVALID)
        {
            if(GetIsPC(oPC))
            {
                break;
            }
            oPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        }
    }

    oParty = GetFirstFactionMember(oPC);
    while(oParty != OBJECT_INVALID)
    {
        nCheck = SQLocalsPlayer_GetInt(oParty, "Q_FEYEST01");
        if(nCheck <= 7 && GetArea(oPC) == GetArea(oParty))
        {
            AddJournalQuestEntry("Q_FeyEst01", 12, oParty, FALSE);
            SQLocalsPlayer_SetInt(oParty, "Q_FEYEST01", 12);
        }
        oParty = GetNextFactionMember(oPC);
    }

    //Execute default scripts
    ExecuteScript("x2_def_ondeath");
}
