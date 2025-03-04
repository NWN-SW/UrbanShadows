//Cannibal Investigation Part Seven
#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastUsedBy();
    object oWP = GetWaypointByTag("cannibal_zone");
    int nCheck = SQLocalsPlayer_GetInt(oPC, "CANNIBAL_PUZZLE");
    effect ePortal = EffectVisualEffect(VFX_IMP_HARM);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    object oArea = GetArea(oPC);
    //Check what step they're on
    object oParty = GetFirstFactionMember(oPC);
    if(nCheck == 6 || nCheck == 7)
    {
        while(oParty != OBJECT_INVALID)
        {
            nCheck = SQLocalsPlayer_GetInt(oParty, "CANNIBAL_PUZZLE");
            if(oArea == GetArea(oParty))
            {
                FloatingTextStringOnCreature("WE SEE THE OFFERINGS. WE ARE PLEASED WITH THESE TASTES. NOW, WE MUST CONSUME ALL.", oParty);
                if(nCheck == 6 || nCheck == 7)
                {
                    SQLocalsPlayer_SetInt(oParty, "CANNIBAL_PUZZLE", 7);
                    AddJournalQuestEntry("Cannibal_Puzzle", 7, oParty, FALSE);
                }
                //VFX
                ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortal, oParty);
                //Teleport
                DelayCommand(0.5, AssignCommand(oParty, ActionJumpToObject(oWP)));
            }
            oParty = GetNextFactionMember(oPC);
        }
    }
    else
    {
        FloatingTextStringOnCreature("BRING US NEW TASTES. WE DEMAND IT.", oPC);
    }
}
