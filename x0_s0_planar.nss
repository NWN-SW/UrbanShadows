//::///////////////////////////////////////////////
//:: Planar Ally
//:: X0_S0_Planar.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons an outsider dependant on alignment, or
    holds an outsider if the creature fails a save.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
//:: Modified from Planar binding
//:: Hold ability removed for cleric version of spell

#include "NW_I0_SPELLS"
#include "sum_set_stats"
#include "sum_apply_stats"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eSummon;
    effect eGate;

    //New Variables
    string sDemon = "summ_bind_dem1";
    string sAngel = "summ_bind_angel1";
    string sGolem= "summ_bind_golem1";
    if (GetHasFeat(FEAT_EPIC_SPELL_FOCUS_CONJURATION))
    {
        sDemon = "summ_bind_dem2";
        sAngel = "summ_bind_angel2";
        sGolem= "summ_bind_golem2";
    }

    int nRacial = GetRacialType(oTarget);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nDuration == 0)
    {
        nDuration == 1;
    }
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }

        //If the ground was clicked on summon an outsider based on alignment
        float fDelay = 3.0;
        switch (nAlign)
        {
            case ALIGNMENT_EVIL:
                eSummon = EffectSummonCreature(sDemon, VFX_FNF_SUMMON_GATE, 3.0);
                DelayCommand(4.0, ApplySummonStats(5));
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
            break;
            case ALIGNMENT_GOOD:
                    eSummon = EffectSummonCreature(sAngel, 219 ,fDelay);
                    DelayCommand(4.0, ApplySummonStats(5));
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
            break;
            case ALIGNMENT_NEUTRAL:
                eSummon = EffectSummonCreature(sGolem, VFX_FNF_SUMMON_MONSTER_3, 1.0);
                //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
                fDelay = 1.0;
                DelayCommand(3.0, ApplySummonStats(5));
            break;
        }
        //Apply the VFX impact and summon effect
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}

