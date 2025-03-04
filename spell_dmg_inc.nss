#include "tsw_class_consts"
#include "utl_i_sqlplayer"
#include "inc_nui_resource"

const int RESOURCE_MULTIPLIER = 5;

//DO BLOOD MAGE CRIT
int DoBloodMageCrit(int nDamage)
{
    object oPC = OBJECT_SELF;
    if(oPC == OBJECT_INVALID || GetObjectType(oPC) != OBJECT_TYPE_CREATURE)
    {
        oPC = GetAreaOfEffectCreator();
    }

    if(oPC == OBJECT_INVALID)
    {
        return nDamage;
    }

    float fMax = IntToFloat(GetMaxHitPoints(oPC));
    float fCurrent = IntToFloat(GetCurrentHitPoints(oPC));

    float fPercent = fCurrent / fMax;

    //Crit chance
    fPercent = fPercent * 50.0;
    int nPercent = FloatToInt(fPercent);
    nPercent = 50 - nPercent;
    int nCrit = d100(1);
    if(nCrit < nPercent && fPercent > 1.0)
    {
        nDamage = nDamage * 2;
        SendMessageToPC(oPC, "BLOOD CRITICAL!");
    }

    return nDamage;
}

int GetPureDamage(int nAmount)
{
    if(nAmount == 1)
    {
        return DAMAGE_BONUS_1;
    }
    else if(nAmount == 2)
    {
        return DAMAGE_BONUS_2;
    }
    else if(nAmount == 3)
    {
        return DAMAGE_BONUS_3;
    }
    else if(nAmount == 4)
    {
        return DAMAGE_BONUS_4;
    }
    else if(nAmount == 5)
    {
        return DAMAGE_BONUS_5;
    }
    else if(nAmount == 6)
    {
        return DAMAGE_BONUS_6;
    }
    else if(nAmount == 7)
    {
        return DAMAGE_BONUS_7;
    }
    else if(nAmount == 8)
    {
        return DAMAGE_BONUS_8;
    }
    else if(nAmount == 9)
    {
        return DAMAGE_BONUS_9;
    }
    else if(nAmount == 10)
    {
        return DAMAGE_BONUS_10;
    }
    else if(nAmount == 11)
    {
        return DAMAGE_BONUS_11;
    }
    else if(nAmount == 12)
    {
        return DAMAGE_BONUS_12;
    }
    else if(nAmount == 13)
    {
        return DAMAGE_BONUS_13;
    }
    else if(nAmount == 14)
    {
        return DAMAGE_BONUS_14;
    }
    else if(nAmount == 15)
    {
        return DAMAGE_BONUS_15;
    }
    else if(nAmount == 16)
    {
        return DAMAGE_BONUS_16;
    }
    else if(nAmount == 17)
    {
        return DAMAGE_BONUS_17;
    }
    else if(nAmount == 18)
    {
        return DAMAGE_BONUS_18;
    }
    else if(nAmount == 19)
    {
        return DAMAGE_BONUS_19;
    }
    else if(nAmount == 20)
    {
        return DAMAGE_BONUS_20;
    }
    else
    {
        return DAMAGE_BONUS_1;
    }
}


int GetBloodRage(string sTargets)
{
    object oPC = OBJECT_SELF;
    if(oPC == OBJECT_INVALID || GetObjectType(oPC) != OBJECT_TYPE_CREATURE)
    {
        oPC = GetAreaOfEffectCreator();
    }

    int nBrawler = GetMaxHitPoints(oPC);
    int nCurrent = GetCurrentHitPoints(oPC);

    //If an AOE is calling the damage, we need to use the right function to get caster HP
    if(nBrawler == 0)
    {
        nBrawler = GetMaxHitPoints(GetAreaOfEffectCreator());
        nCurrent = GetCurrentHitPoints(GetAreaOfEffectCreator());
    }

    //Do math
    int nBonus = nBrawler - nCurrent;
    nBonus = nBonus / 10;

    if(sTargets == "AOE" || sTargets == "AoE")
    {
        nBonus = nBonus / 2;
    }

    return nBonus;
}


int GetHighestAbilityModifier(object oObject)
{
    int nStr = GetAbilityModifier(ABILITY_STRENGTH, oObject);
    int nCon = GetAbilityModifier(ABILITY_CONSTITUTION, oObject);
    int nDex = GetAbilityModifier(ABILITY_DEXTERITY, oObject);
    int nInt = GetAbilityModifier(ABILITY_INTELLIGENCE, oObject);
    int nWis = GetAbilityModifier(ABILITY_WISDOM, oObject);
    int nCha = GetAbilityModifier(ABILITY_CHARISMA, oObject);

    int nCurrent = nStr;

    if(nCurrent < nCon)
    {
        nCurrent = nCon;
    }

    if(nCurrent < nDex)
    {
        nCurrent = nDex;
    }

    if(nCurrent < nInt)
    {
        nCurrent = nInt;
    }

    if(nCurrent < nWis)
    {
        nCurrent = nWis;
    }

    if(nCurrent < nCha)
    {
        nCurrent = nCha;
    }

    return nCurrent;
}

void DoSavingThrowHurt(object oTarget)
{
    int nCrusaderCheck = GetLocalInt(oTarget, "CRUSADER_SANCTIFY_DEBUFF");
    //SendMessageToPC(GetFirstPC(), "My debuff is: " + IntToString(nCrusaderCheck));
    if(nCrusaderCheck > 0)
    {
        effect eDam = EffectDamage(nCrusaderCheck, DAMAGE_TYPE_DIVINE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oTarget);
        nCrusaderCheck = nCrusaderCheck - 1;
        SetLocalInt(oTarget, "CRUSADER_SANCTIFY_DEBUFF", nCrusaderCheck);
    }
}

int GetAnimaSkill(object oPC)
{
    int nAnimaSkill = GetSkillRank(TSW_SKILL_ANIMA, oPC, FALSE);
    return nAnimaSkill;
}

int GetStaminaSkill(object oPC)
{
    int nStaminaSkill = GetSkillRank(TSW_SKILL_STAMINA, oPC, FALSE);
    return nStaminaSkill;
}

int GetAnimaTotal(object oPC)
{
    int nWis = GetAbilityModifier(ABILITY_WISDOM, oPC);
    int nInt = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
    int nCha = GetAbilityModifier(ABILITY_CHARISMA, oPC);

    int nAnimaTotal = nWis + nInt + nCha;
    nAnimaTotal = nAnimaTotal * RESOURCE_MULTIPLIER;
	nAnimaTotal = nAnimaTotal + 10;
    nAnimaTotal = nAnimaTotal + GetAnimaSkill(oPC); 
    //nAnimaTotal = nAnimaTotal /2; // <-------------------- Stamina / Anima Test Change
    if(nAnimaTotal < 10)
    {
        nAnimaTotal = 10;
    }

    //Bloodmage check
    int nBloodmage = GetLocalInt(oPC, "I_AM_BLOODMAGE");
    if(nBloodmage >= 1)
    {
        nAnimaTotal = 0;
    }

    return nAnimaTotal;
}

int GetStaminaTotal(object oPC)
{
    int nStr = GetAbilityModifier(ABILITY_STRENGTH, oPC);
    int nCon = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    int nDex = GetAbilityModifier(ABILITY_DEXTERITY, oPC);

    int nStamTotal = nStr + nCon + nDex;
    nStamTotal = nStamTotal * RESOURCE_MULTIPLIER;
    nStamTotal = nStamTotal + GetStaminaSkill(oPC); 
	nStamTotal = nStamTotal + 10; 
    //nStamTotal = nStamTotal /2; // <-------------------- Stamina / Anima Test Change
    if(nStamTotal < 10)
    {
        nStamTotal = 10;
    }

    //Bloodmage check
    int nBloodmage = GetLocalInt(oPC, "I_AM_BLOODMAGE");
    if(nBloodmage >= 1)
    {
        nStamTotal = 0;
    }

    return nStamTotal;
}

void UpdateResources(object oPC)
{
    int nStamTotal = GetStaminaTotal(oPC);
    int nAnimaTotal = GetAnimaTotal(oPC);

    SetLocalInt(oPC, "PC_ANIMA_MAIN", nAnimaTotal);
    SetLocalInt(oPC, "PC_STAMINA_MAIN", nStamTotal);

    //Check if new total is lower than current. If yes, lower current to total.
    int nAnimaCurrent = GetLocalInt(oPC, "PC_ANIMA_CURRENT");
    int nStamCurrent = GetLocalInt(oPC, "PC_STAMINA_CURRENT");

    if(nAnimaCurrent > nAnimaTotal)
    {
        SetLocalInt(oPC, "PC_ANIMA_CURRENT", nAnimaTotal);
    }

    if(nStamCurrent > nStamTotal)
    {
        SetLocalInt(oPC, "PC_STAMINA_CURRENT", nStamTotal);
    }

    //SendMessageToPC(GetFirstPC(), "Your total Anima is: " + IntToString(nAnimaTotal));
    //SendMessageToPC(GetFirstPC(), "Your total stamina is: " + IntToString(nStamTotal));
}

void FullAnima(object oPC)
{
    int nTotal = GetAnimaTotal(oPC);

    SetLocalInt(oPC, "PC_ANIMA_MAIN", nTotal);
    SetLocalInt(oPC, "PC_ANIMA_CURRENT", nTotal);
    SetLocalInt(oPC, "PC_ANIMA_FEEDBACK", 1);
}

void FullStamina(object oPC)
{
    int nTotal = GetStaminaTotal(oPC);

    SetLocalInt(oPC, "PC_STAMINA_MAIN", nTotal);
    SetLocalInt(oPC, "PC_STAMINA_CURRENT", nTotal);
    SetLocalInt(oPC, "PC_STAMINA_FEEDBACK", 1);
}

void AnStHbRegen(object oPC) {

    int nTotalAn = GetAnimaTotal(oPC);
    int nCurrentAn = GetLocalInt(oPC, "PC_ANIMA_CURRENT");
    int nRegenAn = 0;
	
	int nTotalSt = GetStaminaTotal(oPC);
    int nCurrentSt = GetLocalInt(oPC, "PC_STAMINA_CURRENT");
    int nRegenSt = 0;
	
	int nRegenCombat = 3;
	int nRegenNonCombat = 9;
	int nCombat = GetIsInCombat(oPC);
	int nCombatCD = SQLocalsPlayer_GetInt(oPC, "COMBATCOOLDOWN");
	
	if (nCombat == 1) 
		SQLocalsPlayer_SetInt(oPC, "COMBATCOOLDOWN", 3);
	else if (nCombatCD > 0)
		SQLocalsPlayer_SetInt(oPC, "COMBATCOOLDOWN", nCombatCD - 1);

	//Anima
    if (nCurrentAn < nTotalAn) {
		//If in combat
		if (nCombat == 1) {
			if (nTotalAn < nCurrentAn + nRegenCombat) {
				nRegenAn = nTotalAn; }
			else {
				{nRegenAn = nCurrentAn + nRegenCombat;} }
		}
	   //If not in combat
	   else { 
			//If not in combat for 18 seconds
			if (nCombatCD == 0) {
				if (nTotalAn < nCurrentAn + nRegenNonCombat) {
					nRegenAn = nTotalAn; }
				else { 
					nRegenAn = nCurrentAn + nRegenNonCombat; } 
			}
			
			else {
				
				if (nTotalAn < nCurrentAn + nRegenCombat) {
					nRegenAn = nTotalAn; }
				else {
					{nRegenAn = nCurrentAn + nRegenCombat;} }
			}		
		}	
        SetLocalInt(oPC, "PC_ANIMA_MAIN", nTotalAn);
        SetLocalInt(oPC, "PC_ANIMA_CURRENT", nRegenAn);
        SetLocalInt(oPC, "PC_ANIMA_FEEDBACK", 1);
    }
	
	//Stamina
	if (nCurrentSt < nTotalSt) {
        //If in combat
		if (nCombat == 1) {
			if (nTotalSt < (nCurrentSt + nRegenCombat) ) {
				nRegenSt = nTotalSt; }
			else {
				{nRegenSt = nCurrentSt + nRegenCombat;} }
		}
		
		//If not in combat
        else { 
			//If not in combat for 18 seconds
			if (nCombatCD == 0) {
				if (nTotalSt < nCurrentSt + nRegenNonCombat) {
					nRegenSt = nTotalSt; }
				else { 
					nRegenSt = nCurrentSt + nRegenNonCombat; } 
			}
			else {
				if (nTotalSt < (nCurrentSt + nRegenCombat) ) {
					nRegenSt = nTotalSt; }
				else {
					{nRegenSt = nCurrentSt + nRegenCombat;} }
					if (nCombatCD == 1) { SendMessageToPC(oPC, "Anima and Stamina regeneration returned to normal.");}
					//if (nCombatCD == 1) { SendMessageToPC(oPC, "Cooldown: " + IntToString(nCombatCD));}
			}	
		}		
        SetLocalInt(oPC, "PC_STAMINA_MAIN", nTotalSt);
        SetLocalInt(oPC, "PC_STAMINA_CURRENT", nRegenSt);
        SetLocalInt(oPC, "PC_STAMINA_FEEDBACK", 1);
    }	
}



//RESOURCE FUNCTION FOR BLOOD MAGES
int UseBlood(object oPC, int nSpellID)
{
    if (nSpellID != 1047)
    {
        int nMax = GetMaxHitPoints(oPC);
        int nCurrent = GetCurrentHitPoints(oPC);
        int nRitual = GetLocalInt(oPC, "I_AM_BLOODMAGE");
        nRitual = nRitual + 1;
        SetLocalInt(oPC, "I_AM_BLOODMAGE", nRitual);
        effect eDamage;

        //Cost is equal to the innate spell level in spells.2da
        string sCost = Get2DAString("spells", "Innate", nSpellID);
        int nCost = (StringToInt(sCost) - 1) + nRitual;

        eDamage = EffectDamage(nCost, DAMAGE_TYPE_POSITIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
        return nCost;
    }
    else
    {
        return 0;
    }
}

//BASIC FUNCTION FOR CONSUMING ANIMA FOR SPELLS
int UseAnima(object oPC, int nSpellID)
{
    //Bloodmage check
    int nBloodmage = GetLocalInt(oPC, "I_AM_BLOODMAGE");
    if(nBloodmage >= 1)
    {
        int nBlood = UseBlood(oPC, nSpellID);
        return 0;
    }

    //Main Anima variable on player
    int nAnima = GetLocalInt(oPC, "PC_ANIMA_CURRENT");
    int nFeedback = GetLocalInt(oPC, "PC_ANIMA_FEEDBACK");

    //Huge feedback damage if spell other than Apoth is used.
    int nCharging = GetLocalInt(oPC, "CHARGING_APOTH");
    if(nCharging >= 1 && nSpellID != 1043)
    {
        effect eBackfire = EffectDamage(100, DAMAGE_TYPE_POSITIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBackfire, oPC);
    }

    //Make sure Feedback is always greater than 0
    if(nFeedback < 1)
    {
        nFeedback = 1;
    }

    //Cost is equal to the innate spell level in spells.2da
    string sCost = Get2DAString("spells", "Innate", nSpellID);
    int nCost = StringToInt(sCost); 
    nCost = nCost * 2; // <------------------------------------------------------- STAMINA / ANIMA COST TEST
	nAnima = nAnima - nCost;

    //If Anima is below zero, damage the caster for twice the spell cost.
    int nDamage = nCost * nFeedback;
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    if(nAnima < 0)
    {
        nAnima = 0;
        nFeedback = nFeedback + 1;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
        FloatingTextStringOnCreature("NOT ENOUGH ANIMA. DRAINING LIFE FORCE.", oPC);
    }

    SetLocalInt(oPC, "PC_ANIMA_CURRENT", nAnima);
    SetLocalInt(oPC, "PC_ANIMA_FEEDBACK", nFeedback);
    UpdateBinds(oPC);
    DelayCommand(2.0, UpdateBinds(oPC));
    return nAnima;
}

//BASIC FUNCTION FOR CONSUMING Stamina FOR Abilities
int UseStamina(object oPC, int nSpellID)
{
    //Bloodmage check
    int nBloodmage = GetLocalInt(oPC, "I_AM_BLOODMAGE");
    if(nBloodmage >= 1)
    {
        int nBlood = UseBlood(oPC, nSpellID);
        return 0;
    }

    //Main Anima variable on player
    int nStam = GetLocalInt(oPC, "PC_STAMINA_CURRENT");
    int nFeedback = GetLocalInt(oPC, "PC_STAMINA_FEEDBACK");

    //Huge feedback damage if spell other than Apoth is used.
    int nCharging = GetLocalInt(oPC, "CHARGING_APOTH");
    if(nCharging >= 1 && nSpellID != 1043)
    {
        effect eBackfire = EffectDamage(100, DAMAGE_TYPE_POSITIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBackfire, oPC);
    }

    //Get any class mechanics
    int nTech = GetLocalInt(oPC, "TECHNICIAN_COUNT_LOCAL");

    //Make sure Feedback is always greater than 0
    if(nFeedback < 1)
    {
        nFeedback = 1;
    }

    //Cost is equal to the innate spell level in spells.2da
    string sCost = Get2DAString("spells", "Innate", nSpellID);
    int nCost = StringToInt(sCost); 
	nCost = nCost *2; // <------------------------------------------------------- STAMINA / ANIMA COST TEST

    //Adjust cost based on Technician passive
    if(nTech >= 2 && GetHasFeat(TECH_EFFICIENCY, oPC))
    {
        nCost = 0;
    }

    //SendMessageToPC(oPC, "COST: " + IntToString(nCost));

    nStam = nStam - nCost;

    //If Sramina is below zero, damage the caster for twice the spell cost.
    int nDamage = nCost * nFeedback;
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
    effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
    if(nStam < 0)
    {
        nStam = 0;
        nFeedback = nFeedback + 1;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
        FloatingTextStringOnCreature("NOT ENOUGH STAMINA. TAKING DAMAGE.", oPC);
    }

    SetLocalInt(oPC, "PC_STAMINA_CURRENT", nStam);
    SetLocalInt(oPC, "PC_STAMINA_FEEDBACK", nFeedback);
    UpdateBinds(oPC);
    DelayCommand(2.0, UpdateBinds(oPC));
    return nStam;
}

//DAMAGE FOR FIRST LEVEL SPELLS
int GetFirstLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    //CHAMPION
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;
    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 50;
        //SendMessageToPC(GetFirstPC(), "My base damage is: " + IntToString(nDamage) + " and I am: " + GetName(oSelf));

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 35;
        }

        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 55;
        }
    }
    else
    {
        nDamage = 15;
        //SendMessageToPC(GetFirstPC(), "My base damage is: " + IntToString(nDamage) + " and I am: " + GetName(oSelf));
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR SECOND LEVEL SPELLS
int GetSecondLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 62;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 45;
        }

        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 70;
        }

    }
    else
    {
        nDamage = 20;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR THIRD LEVEL SPELLS
int GetThirdLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 75;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 55;
        }

        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 83;
        }

    }
    else
    {
        nDamage = 25;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR FOURTH LEVEL SPELLS
int GetFourthLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 87;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 65;
        }

        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 96;
        }

    }
    else
    {
        nDamage = 30;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single" && !GetIsPC(oTarget))
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR FIFTH LEVEL SPELLS
int GetFifthLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 100;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 75;
        }

        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 110;
        }

    }
    else
    {
        nDamage = 35;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR SIXTH LEVEL SPELLS
int GetSixthLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 112;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 85;
        }

        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 122;
        }

    }
    else
    {
        nDamage = 40;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR SEVENTH LEVEL SPELLS
int GetSeventhLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 125;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 95;
        }


        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 137;
        }

    }
    else
    {
        nDamage = 45;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR EIGHTH LEVEL SPELLS
int GetEighthLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 137;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 105;
        }


        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 150;
        }

    }
    else
    {
        nDamage = 50;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

//DAMAGE FOR NINTH LEVEL SPELLS
int GetNinthLevelDamage(object oTarget, int nCasterLvl, string sTargets)
{
    //Get class variables for special mechanics
    int nChampion = GetLocalInt(OBJECT_SELF, "CHAMPION_PHALANX_STANCE");
    if(nChampion == 0)
    {
        nChampion = GetLocalInt(GetAreaOfEffectCreator(), "CHAMPION_PHALANX_STANCE");
    }

    //Setting a variable to adjust Alchemite for AoE spells
    if(sTargets == "AOE" || sTargets == "AoE")
    {
        SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 1);
    }

    int nDamage;

    //Caster check
    object oSelf = OBJECT_SELF;
    if(GetObjectType(oSelf) != OBJECT_TYPE_CREATURE)
    {
        oSelf = GetAreaOfEffectCreator();
    }
    //Determine the damage based on if the target is a PC or NPC.
    if(GetIsPC(oSelf) && !GetIsPC(GetMaster(oTarget)))
    {
        nDamage = 150;

        //Champion Check
        if(nChampion == 1)
        {
            nDamage = 115;
        }


        //THEURGIST
        int nTheurgist = GetLocalInt(OBJECT_SELF, "THEURGIST_INNER_LIGHT");
        if(nTheurgist == 0)
        {
            nTheurgist = GetLocalInt(GetAreaOfEffectCreator(), "THEURGIST_INNER_LIGHT");
        }

        if(nTheurgist == 1)
        {
            nDamage = 165;
        }

    }
    else
    {
        nDamage = 55;
    }

    //Single-target spells do double the damage of AOE spells.
    if(sTargets == "Single")
    {
        nDamage = nDamage * 2;
    }

    //Brawler Bonus
    if(GetHasFeat(BRAW_BLOOD_RAGE) || GetHasFeat(BRAW_BLOOD_RAGE, GetAreaOfEffectCreator()))
    {
        //Get hit point stuff for Brawler
        int nBrawler = GetBloodRage(sTargets);
        nDamage = nDamage + nBrawler;
    }

    //Blood Mage
    if(GetHasFeat(BLOO_SANGUINE_SEVERITY) || GetHasFeat(BLOO_SANGUINE_SEVERITY, GetAreaOfEffectCreator()))
    {
        nDamage = DoBloodMageCrit(nDamage);
    }

    return nDamage;
}

int GetAmp(int nDamage)
{
    int nBonus;

    if(GetHasFeat(FEAT_GREATER_AMPLIFICATION, OBJECT_SELF))
    {
        nBonus = nDamage / 5;
        nDamage = nDamage + nBonus;
        return nDamage;
    }
    else if(GetHasFeat(FEAT_AMPLIFICATION, OBJECT_SELF))
    {
        nBonus = nDamage / 10;
        nDamage = nDamage + nBonus;
        return nDamage;
    }
    else
    {
        return nDamage;
    }
}

int GetFocusDmg(object oPC, int nDamage, string sElement)
{
    //Global Variables
    int nFinalDamage;
    string sCommVar;
    string sUncoVar;
    string sRareVar;
    string sLegeVar;
    int nGetCommVar;
    int nGetUncoVar;
    int nGetRareVar;
    int nGetLegeVar;

    //FIRE
    if(sElement == "Fire")
    {
        sCommVar = "COMM_FOCUS_FIRE";
        sUncoVar = "UNCO_FOCUS_FIRE";
        sRareVar = "RARE_FOCUS_FIRE";
        sLegeVar = "LEGE_FOCUS_FIRE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //COLD
    else if(sElement == "Cold")
    {
        sCommVar = "COMM_FOCUS_COLD";
        sUncoVar = "UNCO_FOCUS_COLD";
        sRareVar = "RARE_FOCUS_COLD";
        sLegeVar = "LEGE_FOCUS_COLD";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //ELEC
    else if(sElement == "Elec")
    {
        sCommVar = "COMM_FOCUS_ELEC";
        sUncoVar = "UNCO_FOCUS_ELEC";
        sRareVar = "RARE_FOCUS_ELEC";
        sLegeVar = "LEGE_FOCUS_ELEC";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //ACID
    else if(sElement == "Acid")
    {
        sCommVar = "COMM_FOCUS_ACID";
        sUncoVar = "UNCO_FOCUS_ACID";
        sRareVar = "RARE_FOCUS_ACID";
        sLegeVar = "LEGE_FOCUS_ACID";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //SONI
    else if(sElement == "Soni")
    {
        sCommVar = "COMM_FOCUS_SONI";
        sUncoVar = "UNCO_FOCUS_SONI";
        sRareVar = "RARE_FOCUS_SONI";
        sLegeVar = "LEGE_FOCUS_SONI";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //MAGI
    else if(sElement == "Magi")
    {
        sCommVar = "COMM_FOCUS_MAGI";
        sUncoVar = "UNCO_FOCUS_MAGI";
        sRareVar = "RARE_FOCUS_MAGI";
        sLegeVar = "LEGE_FOCUS_MAGI";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //HOLY
    else if(sElement == "Holy")
    {
        sCommVar = "COMM_FOCUS_HOLY";
        sUncoVar = "UNCO_FOCUS_HOLY";
        sRareVar = "RARE_FOCUS_HOLY";
        sLegeVar = "LEGE_FOCUS_HOLY";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //NEGA
    else if(sElement == "Nega")
    {
        sCommVar = "COMM_FOCUS_NEGA";
        sUncoVar = "UNCO_FOCUS_NEGA";
        sRareVar = "RARE_FOCUS_NEGA";
        sLegeVar = "LEGE_FOCUS_NEGA";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }

    //Slash
    else if(sElement == "Slash")
    {
        sCommVar = "COMM_FOCUS_SLASH";
        sUncoVar = "UNCO_FOCUS_SLASH";
        sRareVar = "RARE_FOCUS_SLASH";
        sLegeVar = "LEGE_FOCUS_SLASH";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }

    //Pierce
    else if(sElement == "Pierce")
    {
        sCommVar = "COMM_FOCUS_PIERCE";
        sUncoVar = "UNCO_FOCUS_PIERCE";
        sRareVar = "RARE_FOCUS_PIERCE";
        sLegeVar = "LEGE_FOCUS_PIERCE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }

    //Bludge
    else if(sElement == "Bludge")
    {
        sCommVar = "COMM_FOCUS_BLUDGE";
        sUncoVar = "UNCO_FOCUS_BLUDGE";
        sRareVar = "RARE_FOCUS_BLUDGE";
        sLegeVar = "LEGE_FOCUS_BLUDGE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }

    //Check if it's an AOE spell
    int nCheck = GetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE");
    int nBonus = 1;

    if(nGetLegeVar >= 1)
    {
        nBonus = 120;
        if(nCheck == 1)
        {
            nBonus = 16;
            SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 0);
        }
        nFinalDamage = nDamage + nBonus;
        return nFinalDamage;
    }
    else if(nGetRareVar >= 1)
    {
        nBonus = 100;
        if(nCheck == 1)
        {
            nBonus = 12;
            SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 0);
        }
        nFinalDamage = nDamage + nBonus;
        return nFinalDamage;
    }
    else if(nGetUncoVar >= 1)
    {
        nBonus = 80;
        if(nCheck == 1)
        {
            nBonus = 8;
            SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 0);
        }
        nFinalDamage = nDamage + nBonus;
        return nFinalDamage;
    }
    else if(nGetCommVar >= 1)
    {
        nBonus = 60;
        if(nCheck == 1)
        {
            nBonus = 4;
            SetLocalInt(OBJECT_SELF, "CURRENT_SPELL_AOE", 0);
        }
        nFinalDamage = nDamage + nBonus;
        return nFinalDamage;
    }
    else
    {
        return nDamage;
    }
}

int GetFocusReduction(object oPC, string sElement)
{
    //Intelligence modifier further reduces enemy resistances. One to one.

    //This is for the illusionist backfire.
    ExecuteScript("tsw_backfire_run", oPC);

    //Global Variables
    int nReduction = GetAbilityModifier(ABILITY_INTELLIGENCE, oPC);
    string sCommVar;
    string sUncoVar;
    string sRareVar;
    string sLegeVar;
    int nGetCommVar;
    int nGetUncoVar;
    int nGetRareVar;
    int nGetLegeVar;

    //FIRE
    if(sElement == "Fire")
    {
        sCommVar = "COMM_FOCUS_FIRE";
        sUncoVar = "UNCO_FOCUS_FIRE";
        sRareVar = "RARE_FOCUS_FIRE";
        sLegeVar = "LEGE_FOCUS_FIRE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //COLD
    else if(sElement == "Cold")
    {
        sCommVar = "COMM_FOCUS_COLD";
        sUncoVar = "UNCO_FOCUS_COLD";
        sRareVar = "RARE_FOCUS_COLD";
        sLegeVar = "LEGE_FOCUS_COLD";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //ELEC
    else if(sElement == "Elec")
    {
        sCommVar = "COMM_FOCUS_ELEC";
        sUncoVar = "UNCO_FOCUS_ELEC";
        sRareVar = "RARE_FOCUS_ELEC";
        sLegeVar = "LEGE_FOCUS_ELEC";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //ACID
    else if(sElement == "Acid")
    {
        sCommVar = "COMM_FOCUS_ACID";
        sUncoVar = "UNCO_FOCUS_ACID";
        sRareVar = "RARE_FOCUS_ACID";
        sLegeVar = "LEGE_FOCUS_ACID";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //SONI
    else if(sElement == "Soni")
    {
        sCommVar = "COMM_FOCUS_SONI";
        sUncoVar = "UNCO_FOCUS_SONI";
        sRareVar = "RARE_FOCUS_SONI";
        sLegeVar = "LEGE_FOCUS_SONI";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //MAGI
    else if(sElement == "Magi")
    {
        sCommVar = "COMM_FOCUS_MAGI";
        sUncoVar = "UNCO_FOCUS_MAGI";
        sRareVar = "RARE_FOCUS_MAGI";
        sLegeVar = "LEGE_FOCUS_MAGI";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //HOLY
    else if(sElement == "Holy")
    {
        sCommVar = "COMM_FOCUS_HOLY";
        sUncoVar = "UNCO_FOCUS_HOLY";
        sRareVar = "RARE_FOCUS_HOLY";
        sLegeVar = "LEGE_FOCUS_HOLY";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //NEGA
    else if(sElement == "Nega")
    {
        sCommVar = "COMM_FOCUS_NEGA";
        sUncoVar = "UNCO_FOCUS_NEGA";
        sRareVar = "RARE_FOCUS_NEGA";
        sLegeVar = "LEGE_FOCUS_NEGA";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //SLASH
    else if(sElement == "Slash")
    {
        sCommVar = "COMM_FOCUS_SLASH";
        sUncoVar = "UNCO_FOCUS_SLASH";
        sRareVar = "RARE_FOCUS_SLASH";
        sLegeVar = "LEGE_FOCUS_SLASH";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //PIERCE
    else if(sElement == "Pierce")
    {
        sCommVar = "COMM_FOCUS_PIERCE";
        sUncoVar = "UNCO_FOCUS_PIERCE";
        sRareVar = "RARE_FOCUS_PIERCE";
        sLegeVar = "LEGE_FOCUS_PIERCE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //BLUDGEONING
    else if(sElement == "Bludge")
    {
        sCommVar = "COMM_FOCUS_BLUDGE";
        sUncoVar = "UNCO_FOCUS_BLUDGE";
        sRareVar = "RARE_FOCUS_BLUDGE";
        sLegeVar = "LEGE_FOCUS_BLUDGE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }

    /* No longer used

    //2DA file parsing for spell school
    string sSchool = Get2DAString("spells", "School", GetSpellId());
    int nSpecial = GetSpecialization(OBJECT_SELF, CLASS_TYPE_THEURGIST);
    int nSchoolBonus;
    //Compare spell school and character specialization
    if(nSpecial == 1 && sSchool == "A")
    {
        nSchoolBonus = 2;
    }
    else if(nSpecial == 2 && sSchool == "C")
    {
        nSchoolBonus = 2;
    }
    else if(nSpecial == 3 && sSchool == "D")
    {
        nSchoolBonus = 2;
    }
    else if(nSpecial == 4 && sSchool == "E")
    {
        nSchoolBonus = 2;
    }
    else if(nSpecial == 5 && sSchool == "V")
    {
        nSchoolBonus = 2;
    }
    else if(nSpecial == 6 && sSchool == "I")
    {
        nSchoolBonus = 2;
    }
    else if(nSpecial == 7 && sSchool == "N")
    {
        nSchoolBonus = 2;
    }
    else if(nSpecial == 8 && sSchool == "T")
    {
        nSchoolBonus = 2;
    }
    */

    //NPC Reductions based on tier
    int nTier = GetLocalInt(OBJECT_SELF, "CREATURE_DEF_TIER");
    if(nTier == 7)
    {
        return 40;
    }
    else if(nTier == 6)
    {
        return 30;
    }
    else if(nTier == 5)
    {
        return 20;
    }
    else if(nTier == 4)
    {
        return 10;
    }

    //Add up Alchemite and specialization bonuses
    if(nGetLegeVar >= 1)
    {
        nReduction = nReduction + 30;
        return nReduction;
    }
    else if(nGetRareVar >= 1)
    {
        nReduction = nReduction + 25;
        return nReduction;
    }
    else if(nGetUncoVar >= 1)
    {
        nReduction = nReduction + 20;
        return nReduction;
    }
    else if(nGetCommVar >= 1)
    {
        nReduction = nReduction + 10;
        return nReduction;
    }
    else
    {
        nReduction = nReduction + 0;
        return nReduction;
    }
}

int GetReflexDamage(object oTarget, int nReduction, int nDamage)
{
    int nGetSave = GetReflexSavingThrow(oTarget);

    //SendMessageToPC(OBJECT_SELF, "My Save is: " + IntToString(nGetSave));

    //Add Tumble
    int nTumble = GetSkillRank(SKILL_TUMBLE, oTarget) / 10;
    nGetSave = nGetSave + nTumble;

    //If target has specific bebuff, they take 10 damage
    DoSavingThrowHurt(oTarget);

    //Hard cap of 75% for PCs
    if(nGetSave > 75 && GetIsPC(oTarget))
    {
        nGetSave = 75;
    }

    //Reduce save by Alchemite resistance reduction
    nGetSave = nGetSave - nReduction;

    //SendMessageToPC(OBJECT_SELF, "My Save after Alchemite is: " + IntToString(nGetSave));

    int nHasEvasion = GetHasFeat(FEAT_EVASION, oTarget);
    int nImpEvasion = GetHasFeat(FEAT_IMPROVED_EVASION, oTarget);
    int nFinalDamage = nDamage;
    string sSave = IntToString(nGetSave);
    string sName = GetName(oTarget);

    //Reduce damage by saving throw plus feats.
    //Evasion increases reduction by 5%
    if(nHasEvasion != 0)
    {
        nGetSave = nGetSave + 5;
    }

    //Imp Evasion increases reduction by another 5%
    if(nImpEvasion != 0)
    {
        nGetSave = nGetSave + 5;
    }

    float fReduction = IntToFloat(nGetSave);
    float fDamage = IntToFloat(nDamage);

    //Turn reduction into percent decimal
    fReduction = fReduction / 100;

    //Get reduction percent of total damage
    float fMinus = fDamage * fReduction;
    int nMinus = FloatToInt(fMinus);

    //Reduce damage
    fDamage = fDamage - fMinus;

    nFinalDamage = FloatToInt(fDamage);

    //SendMessageToPC(OBJECT_SELF, "My Save after everything: " + IntToString(nGetSave));

    //Message players
    string sReduction = IntToString(nMinus);
    string sMessage = sName + ": Incoming damage reduced by " + sReduction;
    SendMessageToPC(OBJECT_SELF, sMessage);

    return nFinalDamage;
}

float GetReflexDuration(object oTarget, int nReduction, float fDuration)
{
    int nGetSave = GetReflexSavingThrow(oTarget);

    //Add Tumble
    int nTumble = GetSkillRank(SKILL_TUMBLE, oTarget) / 10;
    nGetSave = nGetSave + nTumble;

    //If target has specific bebuff, they take 10 damage
    DoSavingThrowHurt(oTarget);

    //Reduce save by Alchemite resistance reduction
    nGetSave = nGetSave - nReduction;

    string sName = GetName(oTarget);
    float fReduction = IntToFloat(nGetSave);

    //Turn reduction into percent decimal
    fReduction = fReduction / 100;

    //Get reduction percent of total damage
    float fMinus = fDuration * fReduction;
    int nMinus = FloatToInt(fMinus);

    if(nMinus < 1)
    {
        nMinus = 1;
    }

    //Reduce duration
    float fFinalDuration = fDuration - fMinus;

    //Message players
    string sReduction = IntToString(nMinus);
    string sMessage = sName + ": Incoming duration reduced by " + sReduction;
    SendMessageToPC(OBJECT_SELF, sMessage);

    return fFinalDuration;
}

int GetFortDamage(object oTarget, int nReduction, int nDamage)
{
    int nGetSave = GetFortitudeSavingThrow(oTarget);

    //Add Discipline. 1 per 10.
    int nDiscipline = GetSkillRank(SKILL_DISCIPLINE, oTarget);
    nDiscipline = nDiscipline / 10;
    nGetSave = nGetSave + nDiscipline;

    //If target has specific bebuff, they take 10 damage
    DoSavingThrowHurt(oTarget);

    //Hard cap of 75% for PCs
    if(nGetSave > 75 && GetIsPC(oTarget))
    {
        nGetSave = 75;
    }

    //Reduce save by Alchemite resistance reduction
    nGetSave = nGetSave - nReduction;

    int nFinalDamage = nDamage;
    string sName = GetName(oTarget);

    float fReduction = IntToFloat(nGetSave);
    float fDamage = IntToFloat(nDamage);

    //Turn reduction into percent decimal
    fReduction = fReduction / 100;

    //Get reduction percent of total damage
    float fMinus = fDamage * fReduction;
    int nMinus = FloatToInt(fMinus);

    //Reduce damage
    fDamage = fDamage - fMinus;

    nFinalDamage = FloatToInt(fDamage);

    //Message players
    string sReduction = IntToString(nMinus);
    string sMessage = sName + ": Incoming damage reduced by " + sReduction;
    SendMessageToPC(OBJECT_SELF, sMessage);

    return nFinalDamage;
}

float GetFortDuration(object oTarget, int nReduction, float fDuration)
{
    int nGetSave = GetFortitudeSavingThrow(oTarget);

    //Add Discipline. 1 per 10.
    int nDiscipline = GetSkillRank(SKILL_DISCIPLINE, oTarget);
    nDiscipline = nDiscipline / 10;
    nGetSave = nGetSave + nDiscipline;

    //If target has specific bebuff, they take 10 damage
    DoSavingThrowHurt(oTarget);

    //Reduce save by Alchemite resistance reduction
    nGetSave = nGetSave - nReduction;

    string sName = GetName(oTarget);
    float fReduction = IntToFloat(nGetSave);

    //Turn reduction into percent decimal
    fReduction = fReduction / 100;

    //Get reduction percent of total damage
    float fMinus = fDuration * fReduction;
    int nMinus = FloatToInt(fMinus);

    if(nMinus < 1)
    {
        nMinus = 1;
    }

    //Reduce duration
    float fFinalDuration = fDuration - fMinus;

    //Message players
    string sReduction = IntToString(nMinus);
    string sMessage = sName + ": Incoming duration reduced by " + sReduction;
    SendMessageToPC(OBJECT_SELF, sMessage);

    return fFinalDuration;
}

int GetWillDamage(object oTarget, int nReduction, int nDamage)
{
    int nGetSave = GetWillSavingThrow(oTarget);

    //If target has specific bebuff, they take 10 damage
    DoSavingThrowHurt(oTarget);

    //Hard cap of 75% for PCs
    if(nGetSave > 75 && GetIsPC(oTarget))
    {
        nGetSave = 75;
    }

    //Reduce save by Alchemite resistance reduction
    nGetSave = nGetSave - nReduction;

    int nFinalDamage = nDamage;
    string sName = GetName(oTarget);

    float fReduction = IntToFloat(nGetSave);
    float fDamage = IntToFloat(nDamage);

    //Turn reduction into percent decimal
    fReduction = fReduction / 100;

    //Get reduction percent of total damage
    float fMinus = fDamage * fReduction;
    int nMinus = FloatToInt(fMinus);

    //Reduce damage
    fDamage = fDamage - fMinus;

    nFinalDamage = FloatToInt(fDamage);

    //Message players
    string sReduction = IntToString(nMinus);
    string sMessage = sName + ": Incoming damage reduced by " + sReduction;
    SendMessageToPC(OBJECT_SELF, sMessage);

    return nFinalDamage;
}

float GetWillDuration(object oTarget, int nReduction, float fDuration)
{
    int nGetSave = GetWillSavingThrow(oTarget);

    //If target has specific bebuff, they take 10 damage
    DoSavingThrowHurt(oTarget);

    //Reduce save by Alchemite resistance reduction
    nGetSave = nGetSave - nReduction;

    string sName = GetName(oTarget);
    float fReduction = IntToFloat(nGetSave);

    //Turn reduction into percent decimal
    fReduction = fReduction / 100;

    //Get reduction percent of total damage
    float fMinus = fDuration * fReduction;
    int nMinus = FloatToInt(fMinus);

    if(nMinus < 1)
    {
        nMinus = 1;
    }

    //Reduce duration
    float fFinalDuration = fDuration - fMinus;

    //Message players
    string sReduction = IntToString(nMinus);
    string sMessage = sName + ": Incoming duration reduced by " + sReduction;
    SendMessageToPC(OBJECT_SELF, sMessage);

    return fFinalDuration;
}

int GetAmplification(int nDamage)
{
    int nBonus;

    if(GetHasFeat(FEAT_GREATER_AMPLIFICATION))
    {
        nBonus = nDamage / 5;
        nDamage = nDamage + nBonus;
        return nDamage;
    }

    if(GetHasFeat(FEAT_AMPLIFICATION))
    {
        nBonus = nDamage / 10;
        nDamage = nDamage + nBonus;
        return nDamage;
    }

    return nDamage;
}

float GetExtendSpell(float fDuration, int nReport = 1, object oPC = OBJECT_SELF)
{
    float fBonus;
    float fOriginal = fDuration;
    float fReport;
    string sReport;

    //Increase all durations by WIS modifier as percent. 4%/1
    int nWisdom = GetAbilityModifier(ABILITY_WISDOM, oPC);
    float fWis = IntToFloat(nWisdom) * 4.0;
    fWis = fWis / 100;

    //Skill Concentration
    int nConc = GetSkillRank(SKILL_CONCENTRATION);
    nConc = nConc / 5;
    float fConc = IntToFloat(nConc) / 100;

    fWis = fWis + fConc;

    fBonus = fDuration * fWis;
    fDuration = fDuration + fBonus;

    if(GetHasFeat(FEAT_EXTEND))
    {
        fBonus = fDuration / 4.0;
        fDuration = fDuration + fBonus;
        sReport = FloatToString(fDuration, 0, 2);
        if(nReport == 1)
        {
            SendMessageToPC(oPC, "Spell Duration: " + sReport + " seconds");
        }

        //Lower duration is the person casting is an NPC
        if(!GetIsPC(oPC))
        {
            fDuration = fDuration - (fDuration / 4.0);
        }
        return fDuration;
    }

    //Message player and report bonus
    sReport = FloatToString(fDuration, 0, 2);
    if(nReport == 1)
    {
        SendMessageToPC(oPC, "Spell Duration: " + sReport + " seconds");
    }

    //Lower duration is the person casting is an NPC
    if(!GetIsPC(oPC))
    {
        fDuration = fDuration - (fDuration / 4.0);
    }

    return fDuration;
}

float GetSpellArea(float fSize, int nReport = 1)
{
    float fBonus;
    float fFinal;
    float fOriginal = fSize;
    float fReport;
    //Increase all AOE size by WIS modifier as percent. 10 = 50%
    int nCharisma = GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF);
    nCharisma = nCharisma * 5;
    float fCha = IntToFloat(nCharisma) / 100;

    fBonus = fSize * fCha;
    fSize = fSize + fBonus;
    fReport = fSize / fOriginal;
    string sReport = FloatToString(fReport, 1, 2);
    sReport = GetStringRight(sReport, 2);

    //Message player and report bonus
    if(nReport == 1)
    {
        SendMessageToPC(OBJECT_SELF, "Spell Area: +" + sReport + "%");
    }

    return fSize;
}

//MARTIAL DAMAGE
int GetMartialDamage(object oTarget, int nReduction, int nDamage)
{
    int nTier = GetLocalInt(oTarget, "CREATURE_DEF_TIER");
    nTier = nTier * 10;

    //Reduce amount by Alchemite resistance reduction
    nTier = nTier - nReduction;

    int nFinalDamage = nDamage;
    string sName = GetName(oTarget);

    float fReduction = IntToFloat(nTier);
    float fDamage = IntToFloat(nDamage);

    //Turn reduction into percent decimal
    fReduction = fReduction / 100;

    //Get reduction percent of total damage
    float fMinus = fDamage * fReduction;
    int nMinus = FloatToInt(fMinus);

    //Reduce damage
    fDamage = fDamage - fMinus;

    nFinalDamage = FloatToInt(fDamage);

    //Message players
    string sReduction = IntToString(nMinus);
    string sMessage = sName + ": Incoming damage reduced by " + sReduction;
    SendMessageToPC(OBJECT_SELF, sMessage);

    return nFinalDamage;
}

//SUMMON ALCHEMITE
int GetSummFocus(object oPC)
{
    //Global Variables
    string sCommVar;
    string sUncoVar;
    string sRareVar;
    string sLegeVar;
    int nGetCommVar;
    int nGetUncoVar;
    int nGetRareVar;
    int nGetLegeVar;

    sCommVar = "COMM_FOCUS_SUMM";
    sUncoVar = "UNCO_FOCUS_SUMM";
    sRareVar = "RARE_FOCUS_SUMM";
    sLegeVar = "LEGE_FOCUS_SUMM";
    nGetCommVar = GetLocalInt(oPC, sCommVar);
    nGetUncoVar = GetLocalInt(oPC, sUncoVar);
    nGetRareVar = GetLocalInt(oPC, sRareVar);
    nGetLegeVar = GetLocalInt(oPC, sLegeVar);

    if(nGetLegeVar >= 1)
    {
        //SendMessageToPC(GetFirstPC(), "My focus is tier 4.");
        return 4;
    }
    else if(nGetRareVar >= 1)
    {
        //SendMessageToPC(GetFirstPC(), "My focus is tier 3.");
        return 3;
    }
    else if(nGetUncoVar >= 1)
    {
        //SendMessageToPC(GetFirstPC(), "My focus is tier 2.");
        return 2;
    }
    else if(nGetCommVar >= 1)
    {
        //SendMessageToPC(GetFirstPC(), "My focus is tier 1.");
        return 1;
    }
    else
    {
        return 0;
        //SendMessageToPC(GetFirstPC(), "GetSummFocus failed.");
    }
}

//Custom Summon Models
void SetSummonModel(object oCaster, object oSummon, int nSpellID)
{
    int nNecro = SQLocalsPlayer_GetInt(oCaster, "NECRO_DEATH_MODEL");
    int nSummoner = SQLocalsPlayer_GetInt(oCaster, "SUMM_PACT_MODEL");

    //Necromancer
    if(nSpellID == 944)
    {
        if(nNecro == 1)
        {
            SetCreatureAppearanceType(oSummon, 24);
        }
        else if(nNecro == 2)
        {
            SetCreatureAppearanceType(oSummon, 3417);
        }
    }

    //Summoner
    if(nSpellID == 985)
    {
        if(nSummoner == 1)
        {
            SetCreatureAppearanceType(oSummon, 4077);
        }
        else if(nSummoner == 2)
        {
            SetCreatureAppearanceType(oSummon, 4078);
        }
        else if(nSummoner == 3)
        {
            SetCreatureAppearanceType(oSummon, 4048);
        }
    }
}


int GetHighestAlchemiteTier(string sElement,object oPC)
{
	string sCommVar;
    string sUncoVar;
    string sRareVar;
    string sLegeVar;
    int nGetCommVar;
    int nGetUncoVar;
    int nGetRareVar;
    int nGetLegeVar;

    //FIRE
    if(sElement == "Fire")
    {
        sCommVar = "COMM_FOCUS_FIRE";
        sUncoVar = "UNCO_FOCUS_FIRE";
        sRareVar = "RARE_FOCUS_FIRE";
        sLegeVar = "LEGE_FOCUS_FIRE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //COLD
    else if(sElement == "Cold")
    {
        sCommVar = "COMM_FOCUS_COLD";
        sUncoVar = "UNCO_FOCUS_COLD";
        sRareVar = "RARE_FOCUS_COLD";
        sLegeVar = "LEGE_FOCUS_COLD";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //ELEC
    else if(sElement == "Elec")
    {
        sCommVar = "COMM_FOCUS_ELEC";
        sUncoVar = "UNCO_FOCUS_ELEC";
        sRareVar = "RARE_FOCUS_ELEC";
        sLegeVar = "LEGE_FOCUS_ELEC";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //ACID
    else if(sElement == "Acid")
    {
        sCommVar = "COMM_FOCUS_ACID";
        sUncoVar = "UNCO_FOCUS_ACID";
        sRareVar = "RARE_FOCUS_ACID";
        sLegeVar = "LEGE_FOCUS_ACID";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //SONI
    else if(sElement == "Soni")
    {
        sCommVar = "COMM_FOCUS_SONI";
        sUncoVar = "UNCO_FOCUS_SONI";
        sRareVar = "RARE_FOCUS_SONI";
        sLegeVar = "LEGE_FOCUS_SONI";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //MAGI
    else if(sElement == "Magi")
    {
        sCommVar = "COMM_FOCUS_MAGI";
        sUncoVar = "UNCO_FOCUS_MAGI";
        sRareVar = "RARE_FOCUS_MAGI";
        sLegeVar = "LEGE_FOCUS_MAGI";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //HOLY
    else if(sElement == "Holy")
    {
        sCommVar = "COMM_FOCUS_HOLY";
        sUncoVar = "UNCO_FOCUS_HOLY";
        sRareVar = "RARE_FOCUS_HOLY";
        sLegeVar = "LEGE_FOCUS_HOLY";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //NEGA
    else if(sElement == "Nega")
    {
        sCommVar = "COMM_FOCUS_NEGA";
        sUncoVar = "UNCO_FOCUS_NEGA";
        sRareVar = "RARE_FOCUS_NEGA";
        sLegeVar = "LEGE_FOCUS_NEGA";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //SLASH
    else if(sElement == "Slash")
    {
        sCommVar = "COMM_FOCUS_SLASH";
        sUncoVar = "UNCO_FOCUS_SLASH";
        sRareVar = "RARE_FOCUS_SLASH";
        sLegeVar = "LEGE_FOCUS_SLASH";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //PIERCE
    else if(sElement == "Pierce")
    {
        sCommVar = "COMM_FOCUS_PIERCE";
        sUncoVar = "UNCO_FOCUS_PIERCE";
        sRareVar = "RARE_FOCUS_PIERCE";
        sLegeVar = "LEGE_FOCUS_PIERCE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
    //BLUDGEONING
    else if(sElement == "Bludge")
    {
        sCommVar = "COMM_FOCUS_BLUDGE";
        sUncoVar = "UNCO_FOCUS_BLUDGE";
        sRareVar = "RARE_FOCUS_BLUDGE";
        sLegeVar = "LEGE_FOCUS_BLUDGE";
        nGetCommVar = GetLocalInt(oPC, sCommVar);
        nGetUncoVar = GetLocalInt(oPC, sUncoVar);
        nGetRareVar = GetLocalInt(oPC, sRareVar);
        nGetLegeVar = GetLocalInt(oPC, sLegeVar);
    }
	     
     if (nGetLegeVar == 1)
	 {
		 return 4;
	 }
	 else if (nGetRareVar == 1)
	 {
		 return 3;
	 }
	 else if (nGetUncoVar == 1)
	 {
		 return 2;
	 }
	 else 
	 {
		 return nGetCommVar;
	 }
	 
}