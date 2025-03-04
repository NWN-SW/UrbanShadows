#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oKiller = GetLastKiller();
    object oPC = GetFirstFactionMember(oKiller, TRUE);
    object oArea = GetArea(oKiller);
    object oAreaParty = GetArea(oPC);
    string sTier = GetStringLeft(GetTag(OBJECT_SELF), 8);
    int nRep = 1;

    //Determine amount of rep based on tier
    if(sTier == "Filth_T1")
    {
        nRep = 6;
    }
    else if(sTier == "Filth_T2")
    {
        nRep = 9;
    }
    else if(sTier == "Filth_T3")
    {
        nRep = 12;
    }
    else if(sTier == "Filth_T4")
    {
        nRep = 15;
    }

    if(GetIsPC(oKiller))
    {
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
  
            oPC = GetNextFactionMember(oKiller, TRUE);
            oAreaParty = GetArea(oPC);
        }
    }
    else
    {
        oPC = GetFirstObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        while(oPC != OBJECT_INVALID)
        {
            if(GetIsPC(oPC))
            {
                    int nRepCheck = AddReputation(oPC, nRep);
                    if(nRepCheck != 0)
                    {
                        FloatingTextStringOnCreature("You have earned " + IntToString(nRep) + " faction reputation.", oPC, FALSE);
                    }   
            }
            oPC = GetNextObjectInShape(SHAPE_SPHERE, 30.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
        }
    }
}
