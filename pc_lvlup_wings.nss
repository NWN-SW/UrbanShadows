#include "inc_timer"
#include "tsw_kill_pcprop"
#include "spell_dmg_inc"
#include "mr_hips_inc"
#include "tsw_comm_clearbb"
#include "inc_nui_resource"

void main()
{
    object oPC = GetPCLevellingUp();
    int nWing = GetCreatureWingType(oPC);

    if(nWing > 0)
    {
        SetCreatureWingType(0, oPC);
    }

    //No Dev crit script
    ExecuteScript("pc_nodevcrit");

    //Restore Anima and Stamina
    FullAnima(oPC);
    FullStamina(oPC);
    //Update resource bars
    UpdateBinds(oPC);
    //HIPS initiate
    HIPS_On_ClientEnter();
}
