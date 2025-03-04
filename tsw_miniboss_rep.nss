#include "tsw_faction_func"

void MinibossReputation(object oKiller)
{
    //Give reputation
    int nReputation = GetLocalInt(OBJECT_SELF, "GIVE_DEATH_REP");
    int nRep;
    object oPC = GetFirstFactionMember(oKiller, TRUE);
    object oArea = GetArea(oKiller);
    object oAreaParty = GetArea(oPC);

    //Leave if no Reputation variable
    if(nReputation == 0)
    {
        return;
    }

    //Determine amount of rep based on tier
    nRep = nReputation * 2;

    //New loop to cycle through party members.
    while(oPC != OBJECT_INVALID)
    {
        if(oArea == oAreaParty)
        {

                int nRepCheck = AddReputation(oPC, nRep);
                if(nRepCheck != 0)
                {
                    FloatingTextStringOnCreature("You have earned " + IntToString(nRep) + "  reputation.", oPC, FALSE);
                }

        }
        oPC = GetNextFactionMember(oKiller, TRUE);
        oAreaParty = GetArea(oPC);
    }
}

