void main()
{
    int nMax = 10;
    int nCounter = GetLocalInt(OBJECT_SELF, "CIVILIAN_TIMER");

    if(nCounter >= nMax)
    {
        SetImmortal(OBJECT_SELF, FALSE);
    }
    else
    {
        nCounter = nCounter + 1;
        SetLocalInt(OBJECT_SELF, "CIVILIAN_TIMER", nCounter);
    }

    //Help messages
    int nRandom = d10(1);
    if(GetIsInCombat(OBJECT_SELF))
    {
        if(nRandom == 2)
        {
            SpeakString("Please help me!");
        }
        else if(nRandom == 4)
        {
            SpeakString("Someone help!");
        }
        else if(nRandom == 6)
        {
            SpeakString("I don't want to die!");
        }
        else if(nRandom == 8)
        {
            SpeakString("Help!");
        }
        else if(nRandom == 10)
        {
            SpeakString("Save me!");
        }
    }
}
