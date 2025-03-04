#include "nwnx_creature"
#include "nwnx_object"


void SetSummonScriptsBasic (object oSummon)
{

    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR,"nw_ch_ace");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_DAMAGED,"nw_ch_ac6");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_DEATH,"nw_ch_ac7");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_DIALOGUE,"nw_ch_ac4");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_DISTURBED,"nw_ch_ac8");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND,"nw_ch_ac3");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,"nw_ch_ac1");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,"nw_ch_ac5");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_NOTICE,"nw_ch_ac2");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_RESTED,"nw_ch_acani9");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_SPAWN_IN,"nw_ch_summon_9");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT,"nw_ch_acb");
    SetEventScript(oSummon,EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT,"nw_ch_acd");
	
	ExecuteScript("nw_ch_summon_9",oSummon);

}


void BlankFeatList (object oSummon)
{

    int iObjFeatCount = NWNX_Creature_GetFeatCount(oSummon);
    int iFeatIndex;
    int iCount;
    for (iCount=0;iCount < iObjFeatCount;iCount++)
    {
        iFeatIndex=NWNX_Creature_GetFeatByIndex(oSummon,iCount);
		if (iFeatIndex!=-1)
        {
         NWNX_Creature_RemoveFeat(oSummon,iFeatIndex);
		}
    }

    //Generic Mage armor (Anima barrier). Somehow not removed by the loop above, as well as a few other feats
	if (GetHasFeat(1162,oSummon))
		NWNX_Creature_RemoveFeat(oSummon,1162);

}

void StreamLineSummonStats (object oSummon, string sSummonName, int iRacialType=20, int iBaseClass=24, int iBaseAC=0, int iBaseAB=0)
{
    SetName(oSummon,sSummonName);
    NWNX_Creature_SetRacialType(oSummon,iRacialType);
    NWNX_Creature_LevelDown(oSummon,26);
    NWNX_Creature_SetClassByPosition(oSummon,0,iBaseClass);
    NWNX_Creature_LevelUp(oSummon,iBaseClass,24);
    int iCountAbilities=0;

    for (iCountAbilities=0;iCountAbilities<6;iCountAbilities++)
    {
        NWNX_Creature_SetRawAbilityScore(oSummon,iCountAbilities,3);
        NWNX_Creature_SetRawAbilityScore(oSummon,iCountAbilities,10);
    }

    NWNX_Creature_SetBaseAC(oSummon,iBaseAC);
    NWNX_Creature_SetBaseAttackBonus(oSummon,iBaseAB);
}