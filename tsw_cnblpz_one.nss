//Cannibal Investigation Start
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
        nCheck = SQLocalsPlayer_GetInt(oParty, "CANNIBAL_PUZZLE");
        if(nCheck < 1 && GetArea(oPC) == GetArea(oParty))
        {
            AddJournalQuestEntry("Cannibal_Puzzle", 1, oParty, FALSE);
            CreateItemOnObject("cannibal_thing", oParty);
            SQLocalsPlayer_SetInt(oParty, "CANNIBAL_PUZZLE", 1);
        }
        oParty = GetNextFactionMember(oPC);
    }

    //Execute default scripts
    ExecuteScript("x2_def_ondeath");
}
