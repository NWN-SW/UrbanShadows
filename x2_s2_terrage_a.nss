//::///////////////////////////////////////////////
//Custom Terrifying Range script by Alexander G.
//:: Created On: 2003-07-10
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_i0_spells"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;

    object oBarb =GetAreaOfEffectCreator();
    int nHD = GetHitDice(GetAreaOfEffectCreator());

    int nDC = GetLevelByClass(0, oBarb) + GetSkillRank(SKILL_INTIMIDATE, oBarb);
    int nDuration = GetLevelByClass(0, oBarb);
    if(GetIsEnemy(oTarget, oBarb))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(oBarb, GetSpellId()));
        //Make a saving throw check

        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
        {
            //Apply the VFX impact and effects
            effect eFear = EffectACDecrease(2);
            eLink = EffectLinkEffects(eFear, eDur);
            eLink = EffectLinkEffects(eLink, eDur2);
            eLink = ExtraordinaryEffect(eLink);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }

}
