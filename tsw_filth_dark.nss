void main()
{
    effect eDarkness = EffectVisualEffect(VFX_DUR_DARKNESS);
    int nCheck = GetLocalInt(OBJECT_SELF, "FILTH_DARKNESS_AURA");
    eDarkness = SupernaturalEffect(eDarkness);

    if(nCheck != 1)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDarkness, OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "FILTH_DARKNESS_AURA", 1);
    }
}
