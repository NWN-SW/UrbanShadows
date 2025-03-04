#include "tsw_class_func"

void main()
{
    int nStacks = GetLocalInt(OBJECT_SELF, "SLAYER_CLASS_STACKS");
    effect eBadVis = EffectVisualEffect(VFX_IMP_HEAD_COLD);

    if(nStacks >= 3)
    {
        SendMessageToPC(OBJECT_SELF, "You already have 3 stacks of Focus.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBadVis, OBJECT_SELF);
        return;
    }

    //Sound Effects
    PlaySoundByStrRef(16778139, FALSE);

    effect eVisMain = EffectVisualEffect(1088);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_FIRE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

    nStacks = nStacks + 1;

    if(nStacks == 1)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    }
    else if(nStacks == 2)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
    }
    else if(nStacks == 3)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
        DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
        DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
    }

    SetLocalInt(OBJECT_SELF, "SLAYER_CLASS_STACKS", nStacks);

    int nStam = UseStamina(OBJECT_SELF, GetSpellId());
    DoMartialMechanic("Tactic", "Single", 0, OBJECT_SELF, OBJECT_SELF, 1, 0);
}
