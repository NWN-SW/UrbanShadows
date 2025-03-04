//::///////////////////////////////////////////////
//:: x0_s2_fiend
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Summons the 'fiendish' servant for the player.
This is a modified version of Planar Binding


At Level 5 the Blackguard gets a Succubus

At Level 9 the Blackguard will get a Vrock

Will remain for one hour per level of blackguard
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: April 2003
//:://////////////////////////////////////////////

#include "sum_set_stats"
#include "sum_apply_stats"

void main()
{
    int nLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD, OBJECT_SELF);
    effect eSummon;
    float fDelay = 3.0;
    int nDuration = nLevel;
    if(nLevel > 15)
    {
        nLevel = 15;
    }

    eSummon = EffectSummonCreature("summ_bg_2",VFX_FNF_SUMMON_GATE, fDelay);

    if(GetHasFeat(FEAT_EPIC_EPIC_FIEND, OBJECT_SELF))
    {
        nLevel = 17;
    }

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    DelayCommand(4.0, ApplySummonStats(nLevel));

}
