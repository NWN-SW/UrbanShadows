void main()
{
    int nEffect = GetLocalInt(OBJECT_SELF, "MY_TEMPORARY_EFFECT");
    effect eVis = EffectVisualEffect(nEffect);
    object oTarget = GetLocalObject(OBJECT_SELF, "MY_TEMPORARY_TARGET");

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    DeleteLocalInt(OBJECT_SELF, "MY_TEMPORARY_EFFECT");
    DeleteLocalObject(OBJECT_SELF, "MY_TEMPORARY_TARGET");
}
