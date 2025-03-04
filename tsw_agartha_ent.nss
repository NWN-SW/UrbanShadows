#include "utl_i_sqlplayer"
#include "inc_nui_resource"
#include "spell_dmg_inc"

void main()
{
    //Set players to max level when entering the server.
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) && GetXP(oPC) < 300000)
    {
        int iXP = 300000;
        if (oPC != OBJECT_INVALID && GetLocalInt(oPC,"iMarkedForDeath") !=1)
        {
            SetXP(oPC, iXP);
        }
    }

    ExecuteScript("pc_remove_scrl");
    ExecuteScript("tsw_noobq_1");

    //Flag PC if they are a bloodmage
    ExecuteScript("tsw_set_bloodmag", oPC);

    //Starting Gear
    ExecuteScript("pc_give_recall");

    //Reset technician counter
    DeleteLocalInt(oPC, "TECHNICIAN_COUNT_LOCAL");

    //Intro quest complete check
    int nQuest = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nQuest < 7)
    {
        AddJournalQuestEntry("Prologue_Quest", 7, oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "Prologue_Quest", 7);
    }


    //Resource Bars
    int nBarsDrawn = GetLocalInt(oPC, "RESOURCE_BARS_DRAWN");
    if(nBarsDrawn == 0)
    {
        DrawResourceBars(oPC);
        SetLocalInt(oPC, "RESOURCE_BARS_DRAWN", 1);
    }

    DelayCommand(6.0, UpdateBinds(oPC));

    //Remove intro weapon
    object oWeap = GetItemPossessedBy(oPC, "INTRO_CLUB");
    DestroyObject(oWeap);

    if (GetLocalInt(oPC,"iMarkedForDeath") == 1)
    {

        AssignCommand(oPC, JumpToLocation(GetLocation(GetWaypointByTag("dreamspawn"))));

    }

    //Anima and Stamina Restoration on enter
    FullAnima(oPC);
    FullStamina(oPC);

}
