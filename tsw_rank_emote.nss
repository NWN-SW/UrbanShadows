#include "tsw_faction_func"

const int VFX_IMP_MAGIC_PROTECTION_G = 1016;
const int VFX_IMP_REDUCE_ABILITY_SCORE_GRN = 1049;
const int VFX_DUR_SPELLTURNING_G = 995;
const int VFX_FNF_BLINDDEAF_GREEN = 887;
const int VFX_FNF_BLINDDEAF_SOUNDFX = 891;
const int VFX_DUR_SPELLTURNING_SOUNDFX = 1001;

void RankEmote(object oPC)
{
    string sFaction = GetFaction(oPC);
    int nRank = GetRank(oPC);

    //Templar VFX
    effect eTempPulse = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    effect eTemp1 = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eTemp2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
    effect eTemp3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    effect eTemp4 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eTemp5 = EffectVisualEffect(VFX_FNF_WORD);

    //Illuminati VFX
    effect eIlluPulse = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    effect eIllu1 = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);
    effect eIllu2 = EffectVisualEffect(VFX_FNF_DISPEL);
    effect eIllu3 = EffectVisualEffect(VFX_FNF_DISPEL_GREATER);
    effect eIllu4 = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
    effect eIllu5 = EffectVisualEffect(VFX_FNF_TIME_STOP);

    //Dragon VFX
    effect eDragPulse = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eDrag1 = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDrag2 = EffectVisualEffect(VFX_IMP_ELEMENTAL_PROTECTION);
    effect eDrag3 = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE_GRN);
    effect eDrag4 = EffectVisualEffect(VFX_DUR_SPELLTURNING_G);
    effect eDrag5 = EffectVisualEffect(VFX_FNF_BLINDDEAF_GREEN);
    effect eDrag4FX = EffectVisualEffect(VFX_DUR_SPELLTURNING_SOUNDFX);
    effect eDrag5FX = EffectVisualEffect(VFX_FNF_BLINDDEAF_SOUNDFX);

    //Templar ranks
    if(sFaction == "Templar")
    {
        if(nRank == 0)
        {
            SendMessageToPC(oPC, "You must be rank one or above to use the /rank emote.");
        }
        else if(nRank == 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eTempPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp1, oPC));
        }
        else if(nRank == 2)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eTempPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp2, oPC));
        }
        else if(nRank == 3)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eTempPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp3, oPC));
        }
        else if(nRank == 4)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eTempPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp3, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp4, oPC));
        }
        else if(nRank == 5)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eTempPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp3, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp4, oPC));
            DelayCommand(1.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTemp5, oPC));
        }
    }

    //Dragon ranks
    if(sFaction == "Dragon")
    {
        if(nRank == 0)
        {
            SendMessageToPC(oPC, "You must be rank one or above to use the /rank emote.");
        }
        else if(nRank == 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDragPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag1, oPC));
        }
        else if(nRank == 2)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDragPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag2, oPC));
        }
        else if(nRank == 3)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDragPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag3, oPC));
        }
        else if(nRank == 4)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDragPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag3, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag4, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag4FX, oPC));
        }
        else if(nRank == 5)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDragPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag3, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag4, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag4FX, oPC));
            DelayCommand(1.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag5, oPC));
            DelayCommand(1.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDrag5FX, oPC));
        }
    }

    //Illuminati ranks
    if(sFaction == "Illuminati")
    {
        if(nRank == 0)
        {
            SendMessageToPC(oPC, "You must be rank one or above to use the /rank emote.");
        }
        else if(nRank == 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eIlluPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu1, oPC));
        }
        else if(nRank == 2)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eIlluPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu2, oPC));
        }
        else if(nRank == 3)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eIlluPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu3, oPC));
        }
        else if(nRank == 4)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eIlluPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu3, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu4, oPC));
        }
        else if(nRank == 5)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eIlluPulse, oPC);
            DelayCommand(0.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu1, oPC));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu2, oPC));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu3, oPC));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu4, oPC));
            DelayCommand(1.25, ApplyEffectToObject(DURATION_TYPE_INSTANT, eIllu5, oPC));
        }
    }
}
