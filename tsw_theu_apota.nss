#include "x2_inc_toollib"

void main()
{
    //Manage charges
    int nCharges = GetLocalInt(OBJECT_SELF, "THEURGIST_APOTH_CHARGES");

    //VFX
    effect ePillar = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    effect eWord = EffectVisualEffect(859, FALSE, 0.75);
    effect eSound = EffectVisualEffect(860);
    effect eImplosion = EffectVisualEffect(1057);
    effect eSparkles = EffectVisualEffect(134);
    effect eHoly1 = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
    effect eHoly2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    effect eHoly3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);

    nCharges = nCharges + 1;
    if(nCharges > 5)
    {
        nCharges = 5;
    }

    SetLocalInt(OBJECT_SELF, "THEURGIST_APOTH_CHARGES", nCharges);

    if(nCharges < 5)
    {
        TLVFXPillar(VFX_IMP_GOOD_HELP, GetLocation(OBJECT_SELF), nCharges);
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSparkles, OBJECT_SELF);


    if(nCharges == 3)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eHoly1, GetLocation(OBJECT_SELF));
    }
    else if(nCharges == 4)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eHoly2, GetLocation(OBJECT_SELF));
    }
    else if(nCharges == 5)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eHoly3, GetLocation(OBJECT_SELF));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWord, GetLocation(OBJECT_SELF));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eSound, OBJECT_SELF);
    }
}
