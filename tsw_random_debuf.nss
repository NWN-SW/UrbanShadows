void ApplyRandomEffect(object oTarget, string sRarity, float fDuration = 6.0)
{
    int nRandom = Random(10);
    effect eEffect;
    effect eVis;
    switch(nRandom)
    {
        case 0:
            eEffect = EffectMovementSpeedDecrease(50);
            eVis = EffectVisualEffect(VFX_IMP_SLOW);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 6.0);
            return;
        case 1:
            eEffect = EffectACDecrease(5);
            eVis = EffectVisualEffect(VFX_IMP_DOOM);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 8.0);
            return;
        case 2:
            eEffect = EffectAttackDecrease(10);
            eVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 8.0);
            return;
        case 3:
            eEffect = EffectParalyze();
            eVis = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 6.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 6.0);
            return;
        case 4:
            eEffect = EffectFrightened();
            eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 6.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 6.0);
            return;
        case 5:
            eEffect = EffectDispelMagicBest(25);
            eVis = EffectVisualEffect(VFX_IMP_DISPEL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
            return;
        case 6:
            eEffect = EffectDeaf();
            eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 8.0);
            return;
        case 7:
            eEffect = EffectBlindness();
            eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 8.0);
            return;
        case 8:
            eEffect = EffectSleep();
            eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 6.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 6.0);
            return;
        case 9:
            eEffect = EffectCurse(2,2,2,2,2,2);
            eVis = EffectVisualEffect(VFX_IMP_DESTRUCTION);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 8.0);
            return;
    }
}
