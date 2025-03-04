#include "utl_i_sqlplayer"
#include "tsw_respawn_func"
#include "tsw_faction_func"
#include "spell_dmg_inc"


void main()
{
	object oPC = GetFirstPC();
	int DebugMode = 0;
	
	//Anima and Stamina Regeneration


	//Save all PCS
	int nTimer = GetLocalInt(OBJECT_SELF, "SAVE_TIMER");
	if(nTimer < 201)
	{
		nTimer = nTimer + 1;
		SetLocalInt(OBJECT_SELF, "SAVE_TIMER", nTimer);
	}
	else if(nTimer == 201)
	{
		ExportAllCharacters();
		SetLocalInt(OBJECT_SELF, "SAVE_TIMER", 1);
	}

	//Check respawn timer
	while(oPC != OBJECT_INVALID)
	{
				
		//Restore Anima and Stamina
		AnStHbRegen(oPC);
		//StaminaHbRegen(oPC);
        UpdateBinds(oPC);
        UpdateResources(oPC);
		//Only do this block if the PC is dead
		if(GetIsDead(oPC))
		{
			int nHardcoreDeath = SQLocalsPlayer_GetInt(oPC, "CURRENTLY_DEAD");
			int nHardcore = SQLocalsPlayer_GetInt(oPC, "AM_HARDCORE");
			object oArea = GetArea(oPC);
			string sTag = GetTag(oArea);
			if(nHardcore == 1 && sTag != "OE_Defense_Tunnel_1" && sTag != "OS_training_place")
			{
				nHardcoreDeath = nHardcoreDeath + 1;
				if(nHardcoreDeath >= 20)
				{
					DoPCRespawn(oPC);
				}
				else
				{
					SQLocalsPlayer_SetInt(oPC, "CURRENTLY_DEAD", nHardcoreDeath);
				}
			}
		}
		//End dead block

		//Reset factions just in case
		SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPC);
		SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oPC);
		SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oPC);

		//Indoor flag
		if(GetIsAreaInterior(GetArea(oPC)))
		{
			SetLocalInt(oPC, "I_AM_INSIDE_SAFE", 1);
		}
		else
		{
			DeleteLocalInt(oPC, "I_AM_INSIDE_SAFE");
		}
		
		if (nTimer%100==0)
		{
			if (GetLocalInt(oPC,"iJustLogged")==0)
			{
				SendMessageToPC(oPC,"Your recent activities have raised the global opinion about your person.");
				AddReputation(oPC,3);
			}
			
			
			int nCheck1 = SQLocalsPlayer_GetInt(oPC, "CURRENTLY_DEAD");
			int nCheck2 = GetIsDead(oPC);
			if(nCheck1 >= 1 && nCheck2 == FALSE)
			{
				SQLocalsPlayer_SetInt(oPC, "CURRENTLY_DEAD", 0);
			}

		}
		//Get next PC
		oPC = GetNextPC();
	}	
}
