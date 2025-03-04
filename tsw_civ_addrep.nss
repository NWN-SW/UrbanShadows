#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oSpeaker = GetPCSpeaker();
    object oPC = GetFirstFactionMember(oSpeaker, TRUE);
    object oArea = GetArea(oSpeaker);
    object oAreaParty = GetArea(oPC);
    int nTier = GetLocalInt(OBJECT_SELF, "CIVILIAN_TIER");
    int nRep;

    //Determine amount of rep based on tier
    if(nTier == 1)
    {
        nRep = 2;
    }
    else if(nTier == 2)
    {
        nRep = 4;
    }
    else if(nTier == 3)
    {
        nRep = 6;
    }
    else if(nTier == 4)
    {
        nRep = 8;
    }

    //New loop to cycle through party members.
    while(oPC != OBJECT_INVALID)
    {
        if(oArea == oAreaParty)
        {
                int nRepCheck = AddReputation(oPC, nRep);
                if(nRepCheck != 0)
                {
                    FloatingTextStringOnCreature("You have earned " + IntToString(nRep) + " faction reputation.", oPC, FALSE);
                }
            
        }
        oPC = GetNextFactionMember(oSpeaker, TRUE);
        oAreaParty = GetArea(oPC);
    }

    int nRandom = d6(1);
    if(nRandom == 1)
    {
        SpeakString("Holy heck?! I'm alive!");
    }
    else if(nRandom == 2)
    {
        SpeakString("I... I didn't think I'd make it. Thank you so much!");
    }
    else if(nRandom == 3)
    {
        SpeakString("Egh- Thanks I guess. I could've handled that on my own.");
    }
    else if(nRandom == 4)
    {
        SpeakString("T-thank you, you saved my life.");
    }
    else if(nRandom == 5)
    {
        SpeakString("You have my gratitude. I wouldn't wish that fate to my worst enemy.");
    }
    else if(nRandom == 6)
    {
        SpeakString("No time for kind words, run for your life!");
    }
    DestroyObject(OBJECT_SELF, 0.5);
}
