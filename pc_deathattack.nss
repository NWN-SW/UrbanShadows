void main()
{
    object oPC = OBJECT_SELF;
    object oDying = GetLocalObject(oPC, "LAST_KILLED");
    int nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC);
    if(nAss > 0)
    {
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(oDying), TRUE, OBJECT_TYPE_CREATURE);
        effect eBlood = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        int nDamage = (nAss + d12(1)) * 2;
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_SLASHING);
        string sDamage = IntToString(nDamage);
        while(oTarget != OBJECT_INVALID)
        {
            if(GetIsEnemy(oTarget, oPC))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlood, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(oDying), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
}
