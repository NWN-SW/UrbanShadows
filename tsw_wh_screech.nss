//Werehawk Screec

#include "NW_I0_SPELLS"
#include "x2_inc_shifter"
#include "X0_I0_SPELLS"
void main()
{
        if( GZCanNotUseGazeAttackCheck(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Enforce artifical use limit on that ability
    //--------------------------------------------------------------------------
    if (ShifterDecrementGWildShapeSpellUsesLeft() <1 )
    {
        FloatingTextStrRefOnCreature(83576, OBJECT_SELF);
        return;
    }

    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDuration = GetLevelByClass(35);
    int nDC = (GetLevelByClass(35) * 2) + 30;
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eSlow = EffectSlow();

    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            if(oTarget != OBJECT_SELF)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_DOOM));
                //Spell Resistance and Saving throw
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow , oTarget, RoundsToSeconds(nDuration));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation());
    }
}
