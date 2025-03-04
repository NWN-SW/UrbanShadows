//::///////////////////////////////////////////////
//:: Quest: Filth Oasis: Terra Tech Quest 2
//:: SQL Name: Q_FOTERRA2
//:: Journal Name: Q_FOTerra2
//::
//:: Stage 5: On-death script for Dr. Khan
//:: NPC Quest Giver: Ana Catagena / Luther
//:://////////////////////////////////////////////

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
        nCheck = SQLocalsPlayer_GetInt(oParty, "Q_FOTERRA2");
        if(nCheck == 4 && GetArea(oPC) == GetArea(oParty))
        {
            AddJournalQuestEntry("Q_FOTerra2", 5, oParty, FALSE);
            SQLocalsPlayer_SetInt(oParty, "Q_FOTERRA2", 5);
        }
        oParty = GetNextFactionMember(oPC);
    }

    //Execute default scripts
    ExecuteScript("x2_def_ondeath");
}
