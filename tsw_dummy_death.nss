//::///////////////////////////////////////////////
//:: Name x2_def_ondeath by Alexander G.
//:://////////////////////////////////////////////

#include "tsw_gold_reward"
#include "tsw_miniboss_rep"

void main()
{
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
    ExecuteScript("pc_infmagsum", OBJECT_SELF);

    //Do not execute if no variable.
    int nCheck = GetLocalInt(OBJECT_SELF, "SEAL_DESTRUCTION");
    if(nCheck == 1)
    {
        ExecuteScript("tsw_sham_destdth", OBJECT_SELF);
    }

    //Make death attack deal damage to nearby enemies
    object oPC = GetLastKiller();
    if(GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) > 0)
    {
        SetLocalObject(oPC, "LAST_KILLED", OBJECT_SELF);
        ExecuteScript("pc_deathattack", oPC);
    }
}
