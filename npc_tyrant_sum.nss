
void SummonTyrantPals ( string sNewPalName)
{
    object oTyrantPal = GetLocalObject(OBJECT_SELF,sNewPalName);

    if ( ! GetIsObjectValid(oTyrantPal))
    {
                effect eVFXSumm = EffectVisualEffect(VFX_FNF_IMPLOSION);

                SetLocalObject(OBJECT_SELF,sNewPalName,CreateObject(1, "tyranttruefla001",GetLocation(OBJECT_SELF),FALSE,sNewPalName));

                object oNewlySummonedPal = GetLocalObject(OBJECT_SELF, sNewPalName);
                effect eBurning = EffectVisualEffect(VFX_DUR_INFERNO,FALSE, 2.0f);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFXSumm, GetLocation(oNewlySummonedPal));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBurning, oNewlySummonedPal);
                SetLocalObject(oNewlySummonedPal,"oSummoner",OBJECT_SELF);
    }


}

void main()
{
    string sVar = "ROUNDS_COUNT";
    int nCount = 0;
    int iHealAmount;
    int iCurrentHp=GetCurrentHitPoints(OBJECT_SELF);
    int iMaxHp = GetMaxHitPoints(OBJECT_SELF);
    int nVar = GetLocalInt(OBJECT_SELF, sVar);
    location lMob = GetLocation(OBJECT_SELF);
    int  iSummonCount = GetLocalInt(OBJECT_SELF,"iSummonCount");
    int iPhaseTwo = GetLocalInt(OBJECT_SELF,"iPhaseTwo");


    // If we've reached below 33%hp, trigger Phase two!
    if ( iPhaseTwo == 0 && iCurrentHp <= iMaxHp/3 )
    {
        effect eAtkDecImm = EffectImmunity(IMMUNITY_TYPE_DAMAGE_DECREASE);
        effect eNoStun = EffectImmunity(IMMUNITY_TYPE_STUN);
        effect eHaste = EffectHaste();
        effect eRaging = EffectVisualEffect(VFX_FNF_LOS_EVIL_30,FALSE, 1.5f);
        effect eGhostly = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE,FALSE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eAtkDecImm,OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eHaste,OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eNoStun,OBJECT_SELF);
        ApplyEffectToObject(0, eRaging, OBJECT_SELF);
        ApplyEffectToObject(2, eGhostly, OBJECT_SELF);
        SetCurrentHitPoints(OBJECT_SELF, (3*iMaxHp/4));
        SetLocalInt(OBJECT_SELF,"iPhaseTwo",1);
        SetLocalInt(OBJECT_SELF,"iBossRegen", iMaxHp/10);
    }

    iPhaseTwo = GetLocalInt(OBJECT_SELF,"iPhaseTwo");

    if ( iPhaseTwo == 1 )
    {

          SummonTyrantPals("Spark1");
          SummonTyrantPals("Spark2");
        // Every 3 rounds, or 18 second, get healed by 10% of max HP.
        if(nVar == 3)
            {
                effect eVFX = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD,FALSE,2.0f);
                iHealAmount = iCurrentHp + GetLocalInt(OBJECT_SELF,"iBossRegen");
                ApplyEffectToObject(2,eVFX,OBJECT_SELF);
                SetCurrentHitPoints(OBJECT_SELF, iHealAmount);
                SetLocalInt(OBJECT_SELF, sVar, 0);

            }
         // If we're not in the round of Healing, get the counter up.
             else if(nVar != 3)
        {
            nVar = nVar + 1;
            SetLocalInt(OBJECT_SELF, sVar, nVar);
        }

       //SendMessageToPC(GetFirstPC(), "Max hp : "+IntToString(iMaxHp) + "Healed by : " + IntToString(iHealAmount) + " to " +IntToString(iCurrentHp));
      }


      ExecuteScript("x2_def_endcombat", OBJECT_SELF);
}
