void main()
{
    effect eGlow = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, OBJECT_SELF);
    ActionDoCommand(ActionRandomWalk());

    ExecuteScript("nw_c2_default9");
}
