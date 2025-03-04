void SpawnJukeboxGnome(location locJkbxPos, string sCreatureRef)
{
  effect fxSmokeJkbx = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1, FALSE, 0.8f);
  effect fxGnomeKd = EffectKnockdown();
  object fNewGnome = CreateObject(OBJECT_TYPE_CREATURE, sCreatureRef, locJkbxPos);

  ApplyEffectAtLocation(2,fxSmokeJkbx,locJkbxPos,1.5f);
  ApplyEffectToObject(1,fxGnomeKd,fNewGnome,3.0f);

}

void main()
{

    location locJkbxPos = GetLocation(OBJECT_SELF);
    CreateObject(OBJECT_TYPE_PLACEABLE, "tsw_jkbx_broken", locJkbxPos);
    SetLocalInt(OBJECT_SELF,"iRoundsLeft",-1);
    MusicBackgroundStop(GetArea(OBJECT_SELF));

    effect fxBurnJkbx = EffectVisualEffect(VFX_FNF_FIREBALL, FALSE, 1.0f);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,fxBurnJkbx,locJkbxPos,1.2f);

    //AssignCommand(GetArea(OBJECT_SELF),DelayCommand(3.0, SpawnJukeboxGnome(locJkbxPos,"gilbert")));

}
