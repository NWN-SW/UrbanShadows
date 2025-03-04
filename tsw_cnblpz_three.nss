//Cannibal Investigation Part Three
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
        if(nCheck == 2 && GetArea(oPC) == GetArea(oParty))
        {
            AddJournalQuestEntry("Cannibal_Puzzle", 3, oParty, FALSE);
            CreateItemOnObject("cannibal_thing2", oParty);
            SQLocalsPlayer_SetInt(oParty, "CANNIBAL_PUZZLE", 3);
        }
        oParty = GetNextFactionMember(oPC);
    }

    //Execute default scripts
    ExecuteScript("x2_def_ondeath");
}
