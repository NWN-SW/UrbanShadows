void main()
{
    int nCheck = GetLocalInt(OBJECT_SELF, "DONE_SPAWN");
    if(nCheck != 1)
    {
        object oDoor = GetNearestObjectByTag("Intro_B_Door");
        object oWP = GetNearestObjectByTag("WP_INTRO_SPAWN");
        location lLoc = GetLocation(oWP);
        effect eDamage = EffectDamage(1000, DAMAGE_TYPE_BLUDGEONING);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oDoor);
        object oMonster = CreateObject(OBJECT_TYPE_CREATURE, "intromonster", lLoc);
        object oPC = GetEnteringObject();
        location lMove = GetLocation(OBJECT_SELF);

        SetLocalInt(OBJECT_SELF, "DONE_SPAWN", 1);
        object oSound = GetNearestObjectByTag("WoodBreaksIntro");
        SoundObjectStop(oSound);

        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
        effect eDarkness = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDarkness, lLoc);
    }
}
