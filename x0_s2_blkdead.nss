//::///////////////////////////////////////////////
//:: x0_s2_blkdead
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Level 3 - 6:  Summons Ghast
    Level 7 - 10: Doom Knight
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

#include "sum_set_stats"
#include "sum_apply_stats"

void main()
{
   int nLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD, OBJECT_SELF);
    effect eSummon;
    int nDuration = nLevel;

    if(nLevel > 15)
    {
        nLevel = 15;
    }

    eSummon = EffectSummonCreature("summ_bg_1",VFX_FNF_SUMMON_UNDEAD);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    DelayCommand(1.0, ApplySummonStats(nLevel));
}
