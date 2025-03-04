//::///////////////////////////////////////////////
//:: Quest: Missing Bees
//:: SQL Name: Q_MBEES
//:: Journal Name: Q_MBees
//:: On-death script for Fallen Templar, Agent of Gaia.
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
        nCheck = SQLocalsPlayer_GetInt(oParty, "Q_MBEES");
        if((nCheck == 1 || nCheck == 2)&& GetArea(oPC) == GetArea(oParty))
        {
            //AddJournalQuestEntry("Q_MBees", 3, oParty, FALSE);
            //SQLocalsPlayer_SetInt(oParty, "Q_MBEES", 3);

            CreateItemOnObject("mbeephone", oParty);
            SQLocalsPlayer_SetInt(oParty, "Q_MBEES", 4);
            AddJournalQuestEntry("Q_MBees", 4, oParty, FALSE);
        }
        oParty = GetNextFactionMember(oPC);
    }

    //Execute default scripts
    ExecuteScript("x2_def_ondeath");
}
