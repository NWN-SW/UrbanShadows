#include "utl_i_sqlplayer"

//Broadcast to all players
void BroadcastMessage(object oPC, string sMessage)
{
        object oReceiver = GetFirstPC();
        while(oReceiver != OBJECT_INVALID)
        {
            if(oReceiver != oPC)
            {
                SendMessageToPC(oReceiver, sMessage);
            }
            oReceiver = GetNextPC();
        }
}

//Return the reputation of the current faction.
int GetFactionRep(object oPC)
{
    string sRaw = GetDeity(oPC);
    //string sRep = GetSubString(sRaw, 6, 10);
    int nRep = StringToInt(sRaw);
    return nRep;
}

//Return player's faction
string GetFaction(object oPC, int iShortName=0)
{
    string sFaction = SQLocalsPlayer_GetString(oPC, "PLAYER_FACTION");
	
	if (iShortName !=0 && sFaction == "Illuminati")
	{
		sFaction = "illum";
	}

    return sFaction;
}

//Set player's faction. Wipe all reputation with existing.
void SetFaction(object oPC, string sFaction)
{
   if(sFaction != "Templar" && sFaction != "Dragon" && sFaction != "Illuminati")
   {
        //SendMessageToAllDMs("Incorrect faction set attempt. Returning.");
        SendMessageToPC(oPC, "Incorrect faction set attempt. Please send send this with details to the discord.");
        return;
    }
	
	if (GetFaction(oPC) !="")
	{
		 SendMessageToPC(oPC, "You are already in a faction. If it's not the case, send this with details to the discord.");
		 return;
	}
    
	SQLocalsPlayer_SetString(oPC, "PLAYER_FACTION", sFaction);
	SQLocalsPlayer_SetInt(oPC, "PLAYER_FACTION_RANK", 0);
	
	
    FloatingTextStringOnCreature("You have joined the " + sFaction + " faction. Your rank has been set to 0.", oPC, FALSE);
   // SetDeity(oPC, "0");
}


//Add rep to player.
int AddReputation(object oPC, int nAmount)
{
    string sRaw = GetDeity(oPC);
    int nRep = StringToInt(sRaw);
    int iMaxRepThreshold;
    string sMaxRepMsg;

    //Give double if hardcore
    int nHardcore = SQLocalsPlayer_GetInt(oPC, "AM_HARDCORE");
    if(nHardcore == 1)
    {
        nAmount = nAmount * 2;
    }

     if(GetFaction(oPC) == "Templar" || GetFaction(oPC) == "Dragon" || GetFaction(oPC) == "Illuminati")
            {
                iMaxRepThreshold=500;
                sMaxRepMsg="You cannot earn faction reputation while at the 500 Reputation points limit.";
            }
            else
            {
                iMaxRepThreshold=100;
                sMaxRepMsg="Factionless characters cannot earn any more reputation while at the 100 Reputation points limit.";
            }

    //Ensure player doesn't get more than the cap.
    if(nRep + nAmount < iMaxRepThreshold)
    {
        nRep = nRep + nAmount;
    }
    else
    {
        nRep = iMaxRepThreshold;
        FloatingTextStringOnCreature(sMaxRepMsg, oPC, FALSE);
    }

    string sRep = IntToString(nRep);

    string sFinal = sRep;
    SendMessageToPC(oPC, "Your current faction reputation is: " + sRep);

    //Play sound effect
    //PlaySoundFX(oPC, "found_thing_2", 0.0);
    ExecuteScript("tsw_inc_soundfx", oPC);

    SetDeity(oPC, sFinal);
    return 1;
}

//Take rep from player.
int TakeReputation(object oPC, int nAmount)
{
    string sRaw = GetDeity(oPC);

    int nRep = StringToInt(sRaw);
    //Ensure player has enough
    if(nRep >= nAmount)
    {
        nRep = nRep - nAmount;
    }
    else
    {
        FloatingTextStringOnCreature("You do not have enough reputation.", oPC, FALSE);
        return 0;
    }

    string sRep = IntToString(nRep);

    string sFinal = sRep;
    SendMessageToPC(oPC, "Your current faction reputation is: " + sRep);

    SetDeity(oPC, sFinal);
    return 1;
}


//Rank up wiht current faction.
void RankUp(object oPC)
{
    //Check their current rank and faction
    string sFaction = SQLocalsPlayer_GetString(oPC, "PLAYER_FACTION");
    int nRank = SQLocalsPlayer_GetInt(oPC, "PLAYER_FACTION_RANK");
    string sReputation;
    //Rank up VFX
    effect eVis;
    if(sFaction == "Templar")
    {
        eVis = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    }
    else if(sFaction == "Dragon")
    {
        eVis = EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON);
    }
    else if(sFaction == "Illuminati")
    {
        eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    }
    //Turn rep into integer
    string sRaw = GetDeity(oPC);
    int nRep = StringToInt(sRaw);

    //Rank Reputation Requirements
    int nRank1 = 100;
    int nRank2 = 150;
    int nRank3 = 225;
    int nRank4 = 325;
    int nRank5 = 450;

    //Unranked to Rank 1
    if(nRank == 0)
    {
        //Rank into String
        string sAmount = IntToString(nRank1);

        if(nRep >= nRank1)
        {
            //Send message to player
            FloatingTextStringOnCreature("You have reached Rank 1 with the " + sFaction + " faction.", oPC, FALSE);
            //Play visual effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            //Change faction rank
            SQLocalsPlayer_SetInt(oPC, "PLAYER_FACTION_RANK", 1);
            //Current reputation minus rank-up cost
            nRep = nRep - nRank1;
            //Turn current rep from int to string
            sReputation = IntToString(nRep);
            //Set new reputation
            SetDeity(oPC, sReputation);
            //Send rep message to player
            SendMessageToPC(oPC, "Your current reputation is: " + sReputation);

            //Broadcast message to all players
            string sName = GetName(oPC);
            string sMessage = sName + " has reached Rank 1 with the " + sFaction + " faction!";
            BroadcastMessage(oPC, sMessage);
            return;
        }
        else
        {
            FloatingTextStringOnCreature("You must have at least " + sAmount + " reputation to reach Rank 1. Your current reputation is: " + sRaw, oPC, FALSE);
            return;
        }
    }

    //Rank 1 to Rank 2
    if(nRank == 1)
    {
        //Rank into String
        string sAmount = IntToString(nRank2);

        if(nRep >= nRank2)
        {
            FloatingTextStringOnCreature("You have reached Rank 2 with the " + sFaction + " faction.", oPC, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            SQLocalsPlayer_SetInt(oPC, "PLAYER_FACTION_RANK", 2);
            nRep = nRep - nRank2;
            sReputation = IntToString(nRep);
            SetDeity(oPC, sReputation);
            SendMessageToPC(oPC, "Your current reputation is: " + sReputation);

            //Broadcast message to all players
            string sName = GetName(oPC);
            string sMessage = sName + " has reached Rank 2 with the " + sFaction + " faction!";
            BroadcastMessage(oPC, sMessage);
            return;
        }
        else
        {
            FloatingTextStringOnCreature("You must have at least " + sAmount + " reputation to reach Rank 2. Your current reputation is: " + sRaw, oPC, FALSE);
            return;
        }
    }

    //Rank 2 to Rank 3
    if(nRank == 2)
    {
        //Rank into String
        string sAmount = IntToString(nRank3);

        if(nRep >= nRank3)
        {
            FloatingTextStringOnCreature("You have reached Rank 3 with the " + sFaction + " faction.", oPC, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            SQLocalsPlayer_SetInt(oPC, "PLAYER_FACTION_RANK", 3);
            nRep = nRep - nRank3;
            sReputation = IntToString(nRep);
            SetDeity(oPC, sReputation);
            SendMessageToPC(oPC, "Your current reputation is: " + sReputation);

            //Broadcast message to all players
            string sName = GetName(oPC);
            string sMessage = sName + " has reached Rank 3 with the " + sFaction + " faction!";
            BroadcastMessage(oPC, sMessage);
            return;
        }
        else
        {
            FloatingTextStringOnCreature("You must have at least " + sAmount + " reputation to reach Rank 3. Your current reputation is: " + sRaw, oPC, FALSE);
            return;
        }
    }

    //Rank 3 to Rank 4
    if(nRank == 3)
    {
        //Rank into String
        string sAmount = IntToString(nRank4);

        if(nRep >= nRank4)
        {
            FloatingTextStringOnCreature("You have reached Rank 4 with the " + sFaction + " faction.", oPC, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            SQLocalsPlayer_SetInt(oPC, "PLAYER_FACTION_RANK", 4);
            nRep = nRep - nRank4;
            sReputation = IntToString(nRep);
            SetDeity(oPC, sReputation);
            SendMessageToPC(oPC, "Your current reputation is: " + sReputation);

            //Broadcast message to all players
            string sName = GetName(oPC);
            string sMessage = sName + " has reached Rank 4 with the " + sFaction + " faction!";
            BroadcastMessage(oPC, sMessage);
            return;
        }
        else
        {
            FloatingTextStringOnCreature("You must have at least " + sAmount + " reputation to reach Rank 4. Your current reputation is: " + sRaw, oPC, FALSE);
            return;
        }
    }

    //Rank 4 to Rank 5
    if(nRank == 4)
    {
        //Rank into String
        string sAmount = IntToString(nRank5);

        if(nRep >= nRank5)
        {
            FloatingTextStringOnCreature("You have reached Rank 5 with the " + sFaction + " faction.", oPC, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            SQLocalsPlayer_SetInt(oPC, "PLAYER_FACTION_RANK", 5);
            nRep = nRep - nRank5;
            sReputation = IntToString(nRep);
            SetDeity(oPC, sReputation);
            SendMessageToPC(oPC, "Your current reputation is: " + sReputation);

            //Broadcast message to all players
            string sName = GetName(oPC);
            string sMessage = sName + " has reached Rank 5 with the " + sFaction + " faction!";
            BroadcastMessage(oPC, sMessage);
            return;
        }
        else
        {
            FloatingTextStringOnCreature("You must have at least " + sAmount + " reputation to reach Rank 5. Your current reputation is: " + sRaw, oPC, FALSE);
            return;
        }
    }
}


//Return PC rank
int GetRank(object oPC)
{
    int nRank = SQLocalsPlayer_GetInt(oPC, "PLAYER_FACTION_RANK");
    return nRank;
}
