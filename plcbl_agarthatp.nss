#include "utl_i_sqlplayer"
#include "tsw_faction_func"
//Teleports the clicking player and all party members to Agartha.
void main()
{

    //Declare major variables
    object oWP = GetWaypointByTag("tp_recall");
    object oCaster = GetLastUsedBy();
    location lWP = GetLocation(oWP);
    location lPC = GetLocation(oCaster);
    effect ePortal = EffectVisualEffect(VFX_IMP_POLYMORPH);
    string sArea = GetTag(GetArea(oCaster));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lPC, TRUE, OBJECT_TYPE_CREATURE);
    object oLeader = GetFactionLeader(oCaster);
    object oCompareLeader;
    int nCheck = SQLocalsPlayer_GetInt(oTarget, "CANNIBAL_PUZZLE");

    //Make sure they aren't in combat
    if(GetIsInCombat(oCaster))
    {
        SendMessageToPC(oCaster, "You cannot use this in combat.");
        return;
    }
    //Cycle through the targets within the shape until an invalid object is captured.
    while(oTarget != OBJECT_INVALID)
    {
        if(GetIsPC(oTarget))
        {
            oCompareLeader = GetFactionLeader(oTarget);
            nCheck = SQLocalsPlayer_GetInt(oTarget, "CANNIBAL_PUZZLE");
            if(oCompareLeader == oLeader)
            {
                //VFX
                ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortal, oTarget);
                //Teleport
                DelayCommand(1.0, AssignCommand(oTarget, ActionJumpToObject(oWP)));
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePortal, lWP);
                //DoPuzzleStuff
                if(nCheck == 7)
                {
                    SQLocalsPlayer_SetInt(oTarget, "CANNIBAL_PUZZLE", 8);
                    AddJournalQuestEntry("Cannibal_Puzzle", 8, oTarget, FALSE);
                    CreateItemOnObject("shoptokent4", oTarget);
                    CreateItemOnObject("shoptokent4", oTarget);
                    DestroyObject(GetItemPossessedBy(oTarget, "cannibal_thing"));
                    DestroyObject(GetItemPossessedBy(oTarget, "cannibal_thing2"));
                    DestroyObject(GetItemPossessedBy(oTarget, "cannibal_thing3"));
                    DestroyObject(GetItemPossessedBy(oTarget, "cannibal_thing4"));
                    DestroyObject(GetItemPossessedBy(oTarget, "cannibal_thing5"));
                    DestroyObject(GetItemPossessedBy(oTarget, "cannibal_thing6"));
                    AddReputation(oTarget, 20);
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lPC, TRUE, OBJECT_TYPE_CREATURE);
    }
}
