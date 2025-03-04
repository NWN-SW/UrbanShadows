//::///////////////////////////////////////////////
//:: Create Greater Undead
//:: NW_S0_CrGrUnd.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons an undead type pegged to the character's
    level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "sum_set_stats"
#include "sum_apply_stats"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nRand = d3(1);
    nDuration = 24;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;  //Duration is +100%
    }

    if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_NECROMANCY, OBJECT_SELF))
    {
        switch(nRand)
        {
            case 1:
                eSummon = EffectSummonCreature("summ_anim_rog2",VFX_FNF_SUMMON_UNDEAD);
                break;
            case 2:
                eSummon = EffectSummonCreature("summ_anim_tank2",VFX_FNF_SUMMON_UNDEAD);
                break;
            case 3:
                eSummon = EffectSummonCreature("summ_anim_war2",VFX_FNF_SUMMON_UNDEAD);
                break;
        }
    }
    else
    {
        switch(nRand)
        {
            case 1:
                eSummon = EffectSummonCreature("summ_anim_rog1",VFX_FNF_SUMMON_UNDEAD);
                break;
            case 2:
                eSummon = EffectSummonCreature("summ_anim_tank1",VFX_FNF_SUMMON_UNDEAD);
                break;
            case 3:
                eSummon = EffectSummonCreature("summ_anim_war1",VFX_FNF_SUMMON_UNDEAD);
                break;
        }
    }
    //Apply the summon visual and summon the two undead.
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    DelayCommand(1.0, ApplySummonStats(8));
}

