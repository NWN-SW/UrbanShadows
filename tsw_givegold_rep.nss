#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    int nGold = GetGold(oPC);
    int nAmount = 10000;

    if(nGold >= 10000)
    {
        TakeGoldFromCreature(nAmount, oPC, TRUE);
        AddReputation(oPC, 1);
    }
    else
    {
        SendMessageToPC(oPC, "You do not have enough currency to donate at this time. Each donation costs 100,000.");
    }
}
