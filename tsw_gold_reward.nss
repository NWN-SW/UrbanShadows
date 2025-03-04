#include "utl_i_sqlplayer"

int SplitGold(int nPartyCount, int nTier)
{
    int nT1Amount = 25;
    int nT2Amount = 50;
    int nT3Amount = 100;
    int nT4Amount = 200;
    int nT5Amount = 400;
    int nT6Amount = 800;
    int nT7Amount = 1600;
    int nTotalAmount;

    if(nTier == 1)
    {
        nTotalAmount = nT1Amount / nPartyCount;
    }
    else if(nTier == 2)
    {
        nTotalAmount = nT2Amount / nPartyCount;
    }
    else if(nTier == 3)
    {
        nTotalAmount = nT3Amount / nPartyCount;
    }
    else if(nTier == 4)
    {
        nTotalAmount = nT4Amount / nPartyCount;
    }
    else if(nTier == 5)
    {
        nTotalAmount = nT5Amount / nPartyCount;
    }
    else if(nTier == 6)
    {
        nTotalAmount = nT6Amount / nPartyCount;
    }
    else if(nTier == 7)
    {
        nTotalAmount = nT7Amount / nPartyCount;
    }
    return nTotalAmount;
}

void GivePartyGold(object oCreature, object oKiller)
{
    int nTier = GetLocalInt(oCreature, "CREATURE_DEF_TIER");
    int nAmount;
    int nCounter = 0;

    //Get first party member of the person who killed the enemy
    object oParty = GetFirstFactionMember(oKiller, TRUE);

    //In order to prevent party members in other zones getting free loot, we'll do an area comparison.
    object oArea = GetArea(oKiller);
    object oAreaParty = GetArea(oParty);

    //New loop to cycle through party members.
    while(oParty != OBJECT_INVALID)
    {
        if(oArea == oAreaParty)
        {
            nCounter = nCounter + 1;
        }
        oParty = GetNextFactionMember(oKiller, TRUE);
    }

    //Cycle through party and give gold based on monster tier.
    //Divide gold reward by number of party members.
    oParty = GetFirstFactionMember(oKiller, TRUE);
    while(oParty != OBJECT_INVALID)
    {
        if(oArea == oAreaParty)
        {
            nAmount = SplitGold(nCounter, nTier);
            //Give x5 if hardcore
            int nHardcore = SQLocalsPlayer_GetInt(oParty, "AM_HARDCORE");
            if(nHardcore == 1)
            {
                nAmount = nAmount * 5;
            }
            GiveGoldToCreature(oParty, nAmount);
        }
        oParty = GetNextFactionMember(oKiller, TRUE);
    }
}
