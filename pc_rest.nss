#include "inc_timer"
#include "tsw_kill_pcprop"
#include "spell_dmg_inc"
#include "mr_hips_inc"
#include "tsw_comm_clearbb"
#include "inc_nui_resource"

void main()
{
    //Global variables
    object oPC = GetLastPCRested();
    //Safe zone variables
    object oArea = GetArea(oPC);
    int iRestType = GetLastRestEventType();
    string sSafezone = GetTag(oArea);
    string sPrefix = "SZ_";
    string sPrefix1 = "OS_";
    string sCompare = GetStringLeft(sSafezone, 3);
    effect eHP = EffectTemporaryHitpoints(50);
    effect eRegen = EffectRegenerate(2, 6.0);
    eHP = MagicalEffect(eHP);
    eRegen = MagicalEffect(eRegen);

    //Rest Timer Variables
    string sTimerName = "REST_TIMER";
    string sGraceTimer = "GRACE_TIMER";

    DestroyPCProperties(oPC);

    //We'll apply temporary HP and Regen to players who rest in a designated area.
    if(sPrefix == sCompare)
    {
        switch (iRestType)
        {
           case REST_EVENTTYPE_REST_STARTED:
               break;
           case REST_EVENTTYPE_REST_FINISHED:
               ActionWait(1.0);
               ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oPC, 180.0);
               ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oPC, 180.0);
               SendMessageToPC(oPC, "You feel warm and refreshed after resting in a safe place.");
               break;
           case REST_EVENTTYPE_REST_CANCELLED:
               break;
           default:
               SendMessageToPC(oPC, "You should never see this");
        }
    }

    //Set and check timer for ten minutes after resting.
    switch (iRestType)
    {
        case REST_EVENTTYPE_REST_STARTED:
            if(GetTimerEnded(sTimerName, oPC) && GetTimerEnded(sGraceTimer, oPC) || sPrefix == sCompare || sPrefix1 == sCompare)
            {
                SetTimer(sGraceTimer, 90, oPC);
                SetTimer(sTimerName, 690, oPC);
                ClearBattleBrother(oPC);
                DecrementRemainingFeatUses(oPC, 1250);
                //Reset technician
                DeleteLocalInt(oPC, "TECHNICIAN_COUNT_LOCAL");

                //Reset Champion
                DeleteLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
                break;
            }
            else if(!GetTimerEnded(sGraceTimer,oPC) && !GetTimerEnded(sTimerName, oPC))
            {
                break;
            }
            else if(GetTimerEnded(sGraceTimer,oPC) && !GetTimerEnded(sTimerName, oPC))
            {
                int nRestCheck = GetTimerStatus("REST_TIMER", oPC);
                SendMessageToPC(oPC, "You may rest again in " + IntToString(nRestCheck) + " seconds.");
                AssignCommand(oPC, ClearAllActions(TRUE));
                break;
            }
            break;
        case REST_EVENTTYPE_REST_FINISHED:
            SendMessageToPC(oPC, "The energies of Gaia replenish you. You may rest again in 10 minutes after your 90-second grace period expires.");
            //Daily grenade counter reset.
            SetLocalInt(oPC, "GRENADES_USED", 0);
            //Daily medikit uses reset.
            SetLocalInt(oPC, "MEDKIT_USES", 0);
            //Restore Anima and Stamina
            //FullAnima(oPC);
            //FullStamina(oPC);
            //Update resource bars
            UpdateBinds(oPC);
            UpdateResources(oPC);
            //HIPS initiate
            HIPS_On_ClientEnter();

            //Clear BB
            ClearBattleBrother(oPC);

            //Reset Technician counter
            DeleteLocalInt(oPC, "TECHNICIAN_COUNT_LOCAL");

            //Clear Umbral Tether
            DeleteLocalInt(oPC, "SHADOW_MARK_SET");

            //Reset Champ
            DeleteLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");

            //Mystic bolt
            DelayCommand(0.2, DecrementRemainingFeatUses(oPC, 1250));
            DelayCommand(0.3, DecrementRemainingFeatUses(oPC, 1250));
            DelayCommand(0.4, DecrementRemainingFeatUses(oPC, 1250));
            DelayCommand(0.5, DecrementRemainingFeatUses(oPC, 1250));
            DelayCommand(0.6, DecrementRemainingFeatUses(oPC, 1250));
            //Reset Bloodmage Ritual
            if(GetHasFeat(BLOO_BLOOD_RITUAL, oPC))
            {
                SetLocalInt(oPC, "I_AM_BLOODMAGE", 1);
            }

            //Clear Umbral Tether
            DeleteLocalInt(OBJECT_SELF, "SHADOW_MARK_SET");

            break;
        case REST_EVENTTYPE_REST_CANCELLED:
            break;
        default:
            SendMessageToPC(oPC, "You should never see this. Rest Timer Error.");
    }

    //Manage Journal Entries
    ExecuteScript("pc_add_journal", oPC);
}
