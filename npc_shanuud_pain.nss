const int VFX_IMP_MIRV_FIREBALL = 822;

void main()
{
    object oAttacker = GetLastDamager();

    effect eMissile = EffectVisualEffect(VFX_IMP_MIRV_FIREBALL);
    effect eImpact = EffectVisualEffect(VFX_FNF_FIREBALL);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    effect eDam;
    int nDamage = d20(5);
    int nDC;
    effect eDam1 = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
    effect eDam2 = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
    effect eDam3 = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
    effect eDam4 = EffectDamage(nDamage, DAMAGE_TYPE_ACID);

    object oTarget = oAttacker;
    if (GetIsReactionTypeHostile(oTarget))
    {
        // * recalculate appropriate distances
        fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
        fDelay = fDist/(3.0 * log(fDist) + 2.0);

        fTime = fDelay;
        fDelay2 += 0.1;
        fTime += fDelay2;

        //Apply impact VFX and damage
        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam1, oTarget));
        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget));
        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam3, oTarget));
        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam4, oTarget));
    }

    ExecuteScript("x2_def_ondamage");
}
