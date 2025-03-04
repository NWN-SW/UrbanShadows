#include "NW_i0_GENERIC"

void main()
{
    string sTag = GetLocalString(OBJECT_SELF, "FILTH_MINION_TAG");
    object oMinion = GetNearestObjectByTag(sTag);
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

    if(oMinion == OBJECT_INVALID)
    {
        SetPlotFlag(OBJECT_SELF, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    }

    ExecuteScript("j_ai_oncombatrou", OBJECT_SELF);
}
