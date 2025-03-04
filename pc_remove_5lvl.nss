//:://////////////////////////////////////////////
//:: Created By: Alexander Gates
//:: Created On: 9/2/2020
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    int nCurrentLevel = GetHitDice(oPC);
    nCurrentLevel = nCurrentLevel - 5;
    //Level Formula: (level * (level - 1) / 2) * 1000
    int iXP = (nCurrentLevel * (nCurrentLevel - 1) / 2) * 1000;
    if (oPC != OBJECT_INVALID)
    {
        SetXP(oPC, iXP);
    }
}


