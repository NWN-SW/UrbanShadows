void main()
{
    effect eDam = EffectDamage(50, DAMAGE_TYPE_NEGATIVE);
    effect eSpook = EffectVisualEffect(VFX_IMP_DEATH);
    object oPC = GetPCSpeaker();

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpook, oPC);
}
