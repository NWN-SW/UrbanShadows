#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    float fDelay;
    float fSize = GetSpellArea(6.0);
    effect eBeam = EffectBeam(VFX_BEAM_ODD, OBJECT_SELF, BODY_NODE_CHEST);
    effect eVis = EffectVisualEffect(VFX_DUR_PDK_FEAR);
    effect eFear = EffectFrightened();
    string sTargets;
    string sElement = "Magi";
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    object oMainTarget;
    int nTargetCheck = 0;
    float fDuration = GetExtendSpell(6.0);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeHostile(oTarget))
        {
            int nReduction = GetFocusReduction(oCaster, sElement);
            fDuration = GetWillDuration(oTarget, nReduction, fDuration);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 1.5);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oTarget, fDuration);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);
            break;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }
}
