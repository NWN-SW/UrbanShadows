#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void DoParkerEnding()
{
    object oPC = GetItemActivator();
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eEvil1 = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eEvil2 = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    effect eEvil3 = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eGood1 = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
    effect eGood2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    effect eGood3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);

    //Give Item
    CreateItemOnObject("shoptokent4", oPC);

    //Add Rep
    AddReputation(oPC, 14);

    //Remove Toy
    object oToy = GetItemPossessedBy(oPC, "ToyStuffedGoat");
    DestroyObject(oToy);

    //Explosions and fire
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oPC);
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEvil1, oPC));
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEvil2, oPC));
    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEvil3, oPC));
    DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood1, oPC));
    DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood2, oPC));
    DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood3, oPC));
}

void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    int nCheck1 = GetLocalInt(oPC, "PMS_P_1_IN");
    int nCheck2 = GetLocalInt(oPC, "PMS_P_2_IN");
    int nCheck3 = GetLocalInt(oPC, "PMS_P_3_IN");
    int nCheck4 = GetLocalInt(oPC, "PMS_P_4_IN");
    int nCheck5 = GetLocalInt(oPC, "PMS_P_5_IN");
    int nStep1 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_1");
    int nStep2 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_2");
    int nStep3 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_3");
    int nStep4 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_4");
    int nStep5 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_5");
    int nStep6 = SQLocalsPlayer_GetInt(oPC, "PARKER_PUZZLE_6");
    int nMaxHP = GetMaxHitPoints(oPC);
    nMaxHP = nMaxHP / 5;
    effect eGood = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eHeal = EffectHeal(99999);
    effect eBad = EffectVisualEffect(91);
    effect eHarm = EffectDamage(nMaxHP);
    string sTag = GetTag(oItem);

    //Ending variables


    if(sTag != "ToyStuffedGoat")
    {
        return;
    }

    //First Area
    if(nCheck1 == 1 && nStep1 == 1 && nStep2 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 2, oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
        SQLocalsPlayer_SetInt(oPC, "PARKER_PUZZLE_2", 1);
    }
    else if(nCheck2 == 1 && nStep2 == 1 && nStep3 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 3, oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
        SQLocalsPlayer_SetInt(oPC, "PARKER_PUZZLE_3", 1);
    }
    else if(nCheck3 == 1 && nStep3 == 1 && nStep4 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 4, oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
        SQLocalsPlayer_SetInt(oPC, "PARKER_PUZZLE_4", 1);
    }
    else if(nCheck4 == 1 && nStep4 == 1 && nStep5 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 5, oPC, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eGood, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
        SQLocalsPlayer_SetInt(oPC, "PARKER_PUZZLE_5", 1);
    }
    else if(nCheck5 == 1 && nStep5 == 1 && nStep6 != 1)
    {
        AddJournalQuestEntry("Parker_Puzzle", 6, oPC, FALSE);
        DoParkerEnding();
        SQLocalsPlayer_SetInt(oPC, "PARKER_PUZZLE_6", 1);
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHarm, oPC);
        SendMessageToPC(oPC, "The girl weakly tells you this isn't the right place.");
    }
}


