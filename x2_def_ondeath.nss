//::///////////////////////////////////////////////
//:: Name x2_def_ondeath by Alexander G.
//:://////////////////////////////////////////////

#include "tsw_gold_reward"
#include "tsw_miniboss_rep"

void main()
{
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

    if(GetIsPC(oPC))
    {
        //Share gold
        GivePartyGold(OBJECT_SELF, oPC);

        //Rep for minibosses
        MinibossReputation(oPC);
    }
    else
    {
        oPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        while(oPC != OBJECT_INVALID)
        {
            if(GetIsPC(oPC))
            {
                //Share gold
                GivePartyGold(OBJECT_SELF, oPC);

                //Rep for minibosses
                MinibossReputation(oPC);
                break;
            }
            oPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        }
    }
    if (GetLocalInt(OBJECT_SELF,"iDeathFuncParam")!=0)
    {
        ExecuteScript("tsw_lib_ondeath", OBJECT_SELF);
    }

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
