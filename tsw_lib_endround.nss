//::///////////////////////////////////////////////
//:: Name tsw_lib_endround
//:://////////////////////////////////////////////
/*
    OnCombatRoundEnd functions library
*/
//:://////////////////////////////////////////////
//:: Created By: RaccManiacc
//:: Created On: July 2024
//:://////////////////////////////////////////////
void SpawnBossWave(int iSpawnsNumber)
{
    // Optional : Wave spawn on P2
    object oBossArea = GetArea(OBJECT_SELF);
    string sBossWave = GetLocalString(oBossArea,"sBossWaveCreature");
    int i;

    for (i=0; i<=iSpawnsNumber; i++)
    {
        CreateObject(OBJECT_TYPE_CREATURE,sBossWave,GetLocation(OBJECT_SELF));
    }
}

void ElementalAoEP2()
{
    effect eVFXThunder = EffectVisualEffect(VFX_FNF_NATURES_BALANCE,FALSE,2.0f);
    effect eVFXFire = EffectVisualEffect(VFX_FNF_FIRESTORM,FALSE,1.5f);
    effect eVFXFrost = EffectVisualEffect(VFX_FNF_ICESTORM,FALSE,2.5f);
    location lBossLoc = GetLocation(OBJECT_SELF);
    object oPCNext = GetFirstObjectInShape(SHAPE_SPHERE,30.0f ,lBossLoc,TRUE);

    while (GetIsObjectValid(oPCNext))
    {
       if (GetIsEnemy(oPCNext))
       {
            int iCustomPCDamage = FloatToInt(GetCurrentHitPoints(oPCNext)*0.90f);
            DelayCommand(3.0f, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iCustomPCDamage),oPCNext));
       }
        oPCNext = GetNextObjectInShape(SHAPE_SPHERE,30.0f ,lBossLoc,TRUE);
    }
        DelayCommand(0.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFXFire,lBossLoc));
        DelayCommand(1.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFXFrost,lBossLoc));
        DelayCommand(2.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVFXThunder,lBossLoc));
        DelayCommand(3.0f, SpawnBossWave(4));





}

void PrepareElementalAoEP2()
{
    int iIsP2=GetLocalInt(OBJECT_SELF,"iGetIsPhaseTwo");

   if (iIsP2==0)
    {
        int i=0;
        ClearAllActions();
        effect eInvulnerable = EffectImmunity(IMMUNITY_TYPE_NONE);
		ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0f,24.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvulnerable,OBJECT_SELF,20.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectPetrify(),OBJECT_SELF,21.0f);
		ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,1.0f,24.0f);
        SpeakString("You weaklings better start running now!");

        for (i=0;i<=3;i++)
        {
            DelayCommand(i*6.0f,ApplyEffectToObject(0,EffectVisualEffect(VFX_IMP_EVIL_HELP,FALSE,i*1.0f),OBJECT_SELF));
            DelayCommand(i*6.0f,ApplyEffectToObject(0,EffectHeal(i*100),OBJECT_SELF));

        }
        DelayCommand((i-1)*6.0f,ElementalAoEP2());
        SetLocalInt(OBJECT_SELF, "iGetIsPhaseTwo",1);
    }
}





void main()
{
      int iGetPhaseTwoThreshold = GetLocalInt(OBJECT_SELF,"iPhaseTwoThreshold");

      if(iGetPhaseTwoThreshold==0)
      { // Will vary between 25+0 and 25 + (51-1) -> 25 to 75% of max hp.
        int iRndThreshold = Random(51)+25;
        SetLocalInt(OBJECT_SELF,"iPhaseTwoThreshold",iRndThreshold);
      }
      else
      {

        float fPhaseTwoed = StringToFloat("0."+IntToString(iGetPhaseTwoThreshold)+"f");
      if (FloatToInt(GetMaxHitPoints()*fPhaseTwoed) >= GetCurrentHitPoints())
      {


      int iCombatRoundEndFunc = GetLocalInt(OBJECT_SELF,"iCombatRoundEndFunc");

        switch (iCombatRoundEndFunc){

            default:
            break;

            case 1:
            PrepareElementalAoEP2();

            break;

            case 2:

            break;

        }
       }
    ExecuteScript("nw_c2_default3", OBJECT_SELF);
    }
}

