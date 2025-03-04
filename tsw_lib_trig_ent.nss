void SetEnteringObjectAsLocal()
{

    object oObjectInside = GetEnteringObject();

    if (GetIsObjectValid(oObjectInside) && GetIsPC(oObjectInside))
    {
        int iGetNthObject = GetLocalInt(OBJECT_SELF,"iNthToEnter");

        SetLocalInt(OBJECT_SELF,"iNthToEnter", (iGetNthObject+1));
        SetLocalObject(OBJECT_SELF,IntToString(iGetNthObject+1),oObjectInside);
        SetLocalString(oObjectInside,"sTriggerTag",GetTag(OBJECT_SELF));
    }

}

void CheckFailConsequences(int iSaveFailConseq, int iBoolCrit, object oPCInTrigger){
	effect eCheckFailEffect;
	effect eCheckCritFailEffect;
	float fFailEffectDur;
	float fCritFailEffectDur;
	int iFailEffectDmg;
	int iFailEffectDmg2;
	int iAnimation;
	string sEffectType;
	
	
	switch (iSaveFailConseq)
	{
		case 0:
			sEffectType="TEMP";
			eCheckFailEffect = EffectKnockdown();
			if (iBoolCrit==1)
			{
				eCheckCritFailEffect = EffectAbilityDecrease(ABILITY_CONSTITUTION,4);
			}
			fFailEffectDur=5.0f;
			fCritFailEffectDur=180.0f;
		break;
		
		case 1:
		sEffectType="DAMAGE";
		iFailEffectDmg=d6(5);
		iFailEffectDmg2=d6(2);
			if (iBoolCrit==1)
			{
				iFailEffectDmg=2*iFailEffectDmg;
				iFailEffectDmg2=2*iFailEffectDmg2;
			}
				eCheckFailEffect = EffectDamage(iFailEffectDmg,DAMAGE_TYPE_BLUDGEONING);
				eCheckCritFailEffect = EffectDamage(iFailEffectDmg2,DAMAGE_TYPE_COLD);
				eCheckCritFailEffect = EffectLinkEffects(eCheckCritFailEffect,EffectVisualEffect(231,FALSE,0.33));
				
		break;
		
		case 2:
		sEffectType="TEMP";
			eCheckFailEffect = EffectKnockdown();
			if (iBoolCrit==1)
			{
				eCheckCritFailEffect = EffectMovementSpeedDecrease(5);
			}
			fFailEffectDur=5.0f;
			fCritFailEffectDur=300.0f;
		break;
		
		case 3:
			eCheckFailEffect = EffectDazed();
			eCheckFailEffect = EffectLinkEffects(eCheckFailEffect, EffectVisualEffect(209));
			eCheckFailEffect = EffectLinkEffects(eCheckFailEffect, EffectCutsceneImmobilize());
			if (Random(2)==0)
			{
				iAnimation = ANIMATION_LOOPING_CUSTOM42;
			}
			else 
			{
				iAnimation = ANIMATION_LOOPING_CUSTOM43;
			}
			fFailEffectDur=9.0f;
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCheckFailEffect,oPCInTrigger,fFailEffectDur);
			
			AssignCommand(oPCInTrigger, ClearAllActions());
			int iRepeat =0;
			for (iRepeat=0;iRepeat<=9;iRepeat++)
			{
				DelayCommand(iRepeat*1.0f,AssignCommand(oPCInTrigger, ActionPlayAnimation(iAnimation, 1.0, 999.0f)));
			}
		break;

	}
	if (sEffectType == "TEMP")
	{
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCheckFailEffect,oPCInTrigger,fFailEffectDur);
		if (iBoolCrit==1)
		{
			ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCheckCritFailEffect,oPCInTrigger,fCritFailEffectDur);
		}	
	}
	else if (sEffectType == "DAMAGE")
	{
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eCheckFailEffect,oPCInTrigger);
		ApplyEffectToObject(DURATION_TYPE_INSTANT,eCheckCritFailEffect,oPCInTrigger);
		
	}
}


void TriggerSaveCheck()
{
	object oPCInTrigger = GetEnteringObject();
	int iSaveType = GetLocalInt(OBJECT_SELF,"iCheckType");
	int iCheckFailConseq = GetLocalInt(OBJECT_SELF,"iTriggerContext");
	int iCheckToBeat = GetLocalInt(OBJECT_SELF,"iCheckDC");
	int iPCSave;
	string sTriggerSuccess;
	string sTriggerFail;
	string sTriggerCritFail;
	if (!GetIsPC(oPCInTrigger))
	{
		return;
	}
	
	switch (iSaveType)
	{
		case 0:
		iPCSave = GetFortitudeSavingThrow(oPCInTrigger);
		break;
		case 1:
		iPCSave = GetReflexSavingThrow(oPCInTrigger);
		break;
		case 2:
		iPCSave = GetWillSavingThrow(oPCInTrigger);
		break;
	}
	
	int iSaveCheck = iCheckToBeat - iPCSave;
	
	if (iSaveCheck<=0)
	{
		 sTriggerSuccess = GetLocalString(OBJECT_SELF,"sMsgSuccess");
		 FloatingTextStringOnCreature(sTriggerSuccess,oPCInTrigger,FALSE);
	}
	else if (iSaveCheck<=10)
	{
		 sTriggerFail = GetLocalString(OBJECT_SELF,"sMsgFail");
		FloatingTextStringOnCreature(sTriggerFail,oPCInTrigger,FALSE);
		CheckFailConsequences(iCheckFailConseq,0,oPCInTrigger);
	}
	else if (iSaveCheck>10)
	{
		sTriggerCritFail = GetLocalString(OBJECT_SELF,"sMsgCritFail");
		FloatingTextStringOnCreature(sTriggerCritFail,oPCInTrigger,FALSE);
		CheckFailConsequences(iCheckFailConseq,1,oPCInTrigger);
	}
	
}


void main ()
{
    int iTriggerEnterFunc = GetLocalInt(OBJECT_SELF,"iTriggerEnterFunc");

        switch (iTriggerEnterFunc){

            default:
            break;

            case 1:
            SetEnteringObjectAsLocal();
            break;
			
			case 2:
			TriggerSaveCheck();
			break;

        }
}
