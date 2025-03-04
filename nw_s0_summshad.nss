//::///////////////////////////////////////////////
//:: Summon Shadow
//:: NW_S0_SummShad.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spell powerful ally from the shadow plane to
    battle for the wizard
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
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
    int nDuration = nCasterLevel;
    effect eSummon;

    //NEW VARIABLES
    int nSpell = GetSpellId();
    int nPower;

    //Determine what spell was cast.
    if(nSpell == SPELL_SHADOW_CONJURATION_SUMMON_SHADOW)
    {
        nPower = 4;
    }
    else if(nSpell == SPELL_GREATER_SHADOW_CONJURATION_SUMMON_SHADOW)
    {
        nPower = 5;
    }
    else if(nSpell == SPELL_SHADES_SUMMON_SHADOW)
    {
        nPower = 6;
    }

    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }


    //Set the summoned undead to the appropriate template based on the caster level
    eSummon = EffectSummonCreature("summ_shades_1",VFX_FNF_SUMMON_UNDEAD);

    if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ILLUSION))
    {
        eSummon = EffectSummonCreature("summ_shades_2",VFX_FNF_SUMMON_UNDEAD);
    }

    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    DelayCommand(1.0, ApplySummonStats(nPower));
}

