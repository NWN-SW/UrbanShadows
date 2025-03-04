//::///////////////////////////////////////////////
//Eplosive Growth by Alexander G.
//:://////////////////////////////////////////////

#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    effect eSummon = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
	int iSummDmg=0;
    object oCaster = OBJECT_SELF;
    int nFocus = GetSummFocus(oCaster);
    string sRes1 = "druid_cs";
    string sRes2 = "druid_ws";
    string sRes3 = "druid_ss";
    string sRes4 = "druid_bs";
    float fSummDur = GetExtendSpell(24.0);;
    location lTarget = GetSpellTargetLocation();
    string sTier;
	object oArea = GetArea(OBJECT_SELF);

    //Summon focustiers
    if(nFocus == 4)
    {
        sTier = "T4";
		iSummDmg=20;
    }
    else if(nFocus == 3)
    {
        sTier = "T3";
		iSummDmg=15;
    }
    else if(nFocus == 2)
    {
        sTier = "T2";
		iSummDmg=10;
    }
    else if(nFocus == 1)
    {
        sTier = "T1";
		iSummDmg=5;
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, GetSpellTargetLocation());

    //Cat
    object oSumm1 = CreateObject(OBJECT_TYPE_CREATURE, sRes1, lTarget, FALSE, "DRUID_MECH_SUM_" + sTier);

    DestroyObject(oSumm1, fSummDur*1.50);
    DelayCommand(1.5, SetLocalInt(oSumm1, "DRUID_MECH_SUMMON", 1));
    DelayCommand(1.5, SetLocalObject(oSumm1, "MY_SUMMON_MASTER", oCaster));

    //Wolf
    object oSumm2 = CreateObject(OBJECT_TYPE_CREATURE, sRes2, lTarget, FALSE, "DRUID_MECH_SUM_" + sTier);

    DestroyObject(oSumm2, fSummDur*1.75);
    DelayCommand(1.5, SetLocalInt(oSumm2, "DRUID_MECH_SUMMON", 1));
    DelayCommand(1.5, SetLocalObject(oSumm2, "MY_SUMMON_MASTER", oCaster));

    //Stag
    object oSumm3 = CreateObject(OBJECT_TYPE_CREATURE, sRes3, lTarget, FALSE, "DRUID_MECH_SUM_" + sTier);

    DestroyObject(oSumm3, fSummDur*1.25);
    DelayCommand(1.5, SetLocalInt(oSumm3, "DRUID_MECH_SUMMON", 1));
    DelayCommand(1.5, SetLocalObject(oSumm3, "MY_SUMMON_MASTER", oCaster));

    //Bear
    object oSumm4 = CreateObject(OBJECT_TYPE_CREATURE, sRes4, lTarget, FALSE, "DRUID_MECH_SUM_" + sTier);

    DestroyObject(oSumm4, fSummDur*2);
    DelayCommand(1.5, SetLocalInt(oSumm4, "DRUID_MECH_SUMMON", 1));
    DelayCommand(1.5, SetLocalObject(oSumm4, "MY_SUMMON_MASTER", oCaster));

    //Class mechanics
	int iCount=0;

	effect ESummDmgDown = EffectDamageDecrease(iSummDmg,DAMAGE_TYPE_SLASHING);

	if (iSummDmg>0)
	{
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,ESummDmgDown,oSumm1);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,ESummDmgDown,oSumm2);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,ESummDmgDown,oSumm3);
		ApplyEffectToObject(DURATION_TYPE_PERMANENT,ESummDmgDown,oSumm4);
	}
    string sSpellType = "Invocation";
    DoClassMechanic(sSpellType, "AOE", 0, OBJECT_SELF);
}
