void main()
{
    object oTarget = GetFirstPC();

    effect eMis0 = EffectVisualEffect(503);
    effect eMis1 = EffectVisualEffect(826);
    effect eMis2 = EffectVisualEffect(827);
    effect eMis3 = EffectVisualEffect(828);
    effect eMis4 = EffectVisualEffect(829);
    effect eMis5 = EffectVisualEffect(830);
    effect eMis6 = EffectVisualEffect(831);
    effect eMis7 = EffectVisualEffect(832);
    effect eMis8 = EffectVisualEffect(833);
    effect eMis9 = EffectVisualEffect(834);
    effect eMis10 = EffectVisualEffect(835);
    effect eMis11 = EffectVisualEffect(836);
    effect eMis12 = EffectVisualEffect(837);

    float fDelay = 3.0;
    float fIncrement = 3.0;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis0, oTarget);
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis1, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis2, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis3, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis4, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis5, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis6, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis7, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis8, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis9, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis10, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis11, oTarget));
    fDelay = fDelay + fIncrement;
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMis12, oTarget));
}


