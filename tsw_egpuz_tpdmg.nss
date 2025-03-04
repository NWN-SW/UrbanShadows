void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetWaypointByTag("tp_recall");
    location lWP = GetLocation(oWP);
    effect ePortal = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDmg = EffectDamage(100, DAMAGE_TYPE_FIRE);

            //Teleport
            DelayCommand(1.0, AssignCommand(oPC, ActionJumpToObject(oWP)));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePortal, oPC);
            //Deal damage
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oPC);
}
