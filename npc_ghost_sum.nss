void SummonStanleysPals(string sPalsResRef, location lPalsLocation)
{

    CreateObject(1, sPalsResRef, lPalsLocation);

}

void DelaySpeakString(string sThreats)
{
    AssignCommand(OBJECT_SELF, SpeakString(sThreats, TALKVOLUME_TALK));
}

void main()
{
    string sVar = "SUMMON_COUNT";
    int nVar = GetLocalInt(OBJECT_SELF, sVar);
    int nCount;
    int iCurrentHp = GetCurrentHitPoints(OBJECT_SELF);
    //effect eSummon = EffectSummonCreature("vilecrawler",VFX_FNF_GAS_EXPLOSION_EVIL);
    effect eVFX = EffectVisualEffect(258);
    location lMob = GetLocation(OBJECT_SELF);

    if(nVar == 3)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMob);
        for (nCount = 0; nCount <2;nCount++)
         {
           SummonStanleysPals("ghost_t4mob002", lMob);
         }
        SetLocalInt(OBJECT_SELF, sVar, 0);
    }
    else if(nVar != 3)
    {
        nVar = nVar + 1;
        SetLocalInt(OBJECT_SELF, sVar, nVar);
    }

    ExecuteScript("x2_def_endcombat", OBJECT_SELF);

    if ( iCurrentHp <=   (GetMaxHitPoints(OBJECT_SELF)/3) && GetLocalInt(OBJECT_SELF, "iRagedUp") == 0)
    {   effect eAntiStun = EffectImmunity(IMMUNITY_TYPE_STUN);
        effect eHasted = EffectHaste();
        effect eMoreAb =  EffectAttackIncrease(5);
        effect ePowerVFX = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY,FALSE, 3.0f);
        location lStanP2 = GetLocation(GetObjectByTag("ZEP_BLOOD_ST"));
        AssignCommand(OBJECT_SELF,JumpToObject(GetObjectByTag("ZEP_BLOOD_ST")));
        AssignCommand(OBJECT_SELF, ActionWait(5.0f));
        eVFX = EffectVisualEffect(VFX_FNF_HORRID_WILTING);
        ApplyEffectToObject(2,eAntiStun,OBJECT_SELF);
        ApplyEffectToObject(2,eHasted,OBJECT_SELF);
        ApplyEffectToObject(2,eMoreAb,OBJECT_SELF);

        DelayCommand(1.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lStanP2));


        DelayCommand(2.0f,ApplyEffectAtLocation(2,ePowerVFX,lStanP2));
        DelayCommand(2.0f, DelaySpeakString("I. . . I will tear you apart, feast on your remains!"));
        SetLocalInt(OBJECT_SELF, "iRagedUp",1);
        object oTarget = GetLastDamager();

        for (nCount = 0; nCount <4; nCount++)
         {
           DelayCommand(2.0f, SummonStanleysPals("ghost_t4mob001", lStanP2));

         }

        DelayCommand(6.0f,ActionCastSpellAtObject(SPELL_DEATH_ARMOR,OBJECT_SELF,0,TRUE));


    }

}






