int GetAverageDPS(int nMin, int nMax, int nBotRange, int nCritMult)
{
    int nRoll =  nMin + Random(nMax + 1);
    if(nRoll > nMax)
    {
        nRoll = nMax;
    }

    int nCritRoll = 1 + Random(20);
    if(nCritRoll >= nBotRange)
    {
        nRoll = nRoll * nCritMult;
    }
    return nRoll;

}

void main()
{
    //Delcare major variables
    object oPC = GetLastUsedBy();
    int nWeapon;
    int nRoll;
    int nSum;
    int nAverage;
    int nCount = 0;

    //Roll 100 times and return the average damage for the spoken weapon.
    //Longsword
    while(nCount < 1000)
    {
        nRoll = GetAverageDPS(2, 16, 19, 2);
        nSum = nSum + nRoll;
        nCount = nCount + 1;
    }
    nAverage = nSum / 1000;
    SendMessageToPC(oPC, "Average longsword damage is: " + IntToString(nAverage));

    //Dagger
    nCount = 0;
    nSum = 0;
    nAverage = 0;
    while(nCount < 1000)
    {
        nRoll = GetAverageDPS(2, 8, 19, 3);
        nSum = nSum + nRoll;
        nCount = nCount + 1;
    }
    nAverage = nSum / 1000;
    SendMessageToPC(oPC, "Average dagger damage is: " + IntToString(nAverage));

    //Kukri
    nCount = 0;
    nSum = 0;
    nAverage = 0;
    while(nCount < 1000)
    {
        nRoll = GetAverageDPS(2, 8, 18, 4);
        nSum = nSum + nRoll;
        nCount = nCount + 1;
    }
    nAverage = nSum / 1000;
    SendMessageToPC(oPC, "Average kukri damage is: " + IntToString(nAverage));
}

