int FortDemonArmy(int nWave, int nTier, int nPCount)
{
    //Number of creatures to spawn.
    int nT0; //Flesh Fiend
    int nT1; //Mutilator
    int nT2; //Vile Mother
    int nT3; //Plague Bringer
    int nT4; //Stygian Fury
    int nT5; //Pit Lord
    int nT6; //Tainted

    //On what wave are we?
    if(nWave == 0)
    {
        //Wave 1
        //1 to 4 Flesh Fiends
        //1 to 4 Mutilators
        if(nTier == 0)
        {
            nT0 = nPCount;
            if(nT0 > 4)
            {
                nT0 = 4;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount;
            if(nT1 > 4)
            {
                nT1 = 4;
            }
            return nT1;
        }
    }
    else if(nWave == 1)
    {
        //Wave 2
        //1 to 4 Flesh Fiends
        //1 to 4 Mutilators
        //1 to 2 Vile Mothers
        if(nTier == 0)
        {
            nT0 = nPCount;
            if(nT0 > 4)
            {
                nT0 = 4;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount;
            if(nT1 > 4)
            {
                nT1 = 4;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount;
            if(nT2 > 2)
            {
                nT2 = 2;
            }
            return nT2;
        }
    }
    else if(nWave == 2)
    {
        //Wave 3
        //1 to 4 Flesh Fiends
        //1 to 4 Mutilators
        //1 to 2 Vile Mothers
        //1 to 2 Plague Bringers
        if(nTier == 0)
        {
            nT0 = nPCount;
            if(nT0 > 4)
            {
                nT0 = 4;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount;
            if(nT1 > 4)
            {
                nT1 = 4;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount;
            if(nT2 > 2)
            {
                nT2 = 2;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount;
            if(nT2 > 2)
            {
                nT3 = 2;
            }
            return nT3;
        }
    }
    else if(nWave == 3)
    {
        //Wave 4
        //1 to 4 Flesh Fiends
        //1 to 2 Mutilators
        //1 to 2 Vile Mothers
        //1 to 2 Plague Bringers
        //1 to 2 Stygian Furies
        if(nTier == 0)
        {
            nT0 = nPCount;
            if(nT0 > 4)
            {
                nT0 = 4;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount;
            if(nT1 > 4)
            {
                nT1 = 4;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount;
            if(nT2 > 2)
            {
                nT2 = 2;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount;
            if(nT3 > 2)
            {
                nT3 = 2;
            }
            return nT3;
        }
        else if(nTier == 4)
        {
            nT4 = nPCount;
            if(nT4 > 2)
            {
                nT4 = 2;
            }
            return nT4;
        }
    }
    else if(nWave == 4)
    {
        //Wave 5
        //1 to 4 Flesh Fiends
        //1 to 4 Mutilators
        //1 to 2 Vile Mothers
        //1 to 2 Plague Bringers
        //1 to 2 Stygian Furies
        //1 to 2 Pit Lords
        if(nTier == 0)
        {
            nT0 = nPCount;
            if(nT0 > 4)
            {
                nT0 = 4;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount;
            if(nT1 > 4)
            {
                nT1 = 4;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount;
            if(nT2 > 2)
            {
                nT2 = 2;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount;
            if(nT3 > 2)
            {
                nT3 = 2;
            }
            return nT3;
        }
        else if(nTier == 4)
        {
            nT4 = nPCount;
            if(nT4 > 2)
            {
                nT4 = 2;
            }
            return nT4;
        }
        else if(nTier == 5)
        {
            nT5 = nPCount - 1;
            if(nT5 > 2)
            {
                nT5 = 2;
            }
            return nT5;
        }
    }
    else if(nWave == 5)
    {
        //Wave 6
        //1 to 4 Flesh Fiends
        //1 to 4 Mutilators
        //1 to 2 Vile Mothers
        //1 to 2 Plague Bringers
        //1 to 2 Stygian Furies
        //1 to 2 Pit Lords
        //0 to 1 Tainted
        if(nTier == 0)
        {
            nT0 = nPCount;
            if(nT0 > 4)
            {
                nT0 = 4;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount;
            if(nT1 > 4)
            {
                nT1 = 4;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount;
            if(nT2 > 2)
            {
                nT2 = 2;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount;
            if(nT3 > 2)
            {
                nT3 = 2;
            }
            return nT3;
        }
        else if(nTier == 4)
        {
            nT4 = nPCount;
            if(nT4 > 2)
            {
                nT4 = 2;
            }
            return nT4;
        }
        else if(nTier == 5)
        {
            nT5 = nPCount - 1;
            if(nT5 > 2)
            {
                nT5 = 2;
            }
            return nT5;
        }
        else if(nTier == 6)
        {
            nT5 = nPCount - 1;
            if(nT5 > 1)
            {
                nT5 = 1;
            }
            return nT5;
        }
    }
    else if(nWave == 6)
    {
        //Wave 7
        //2 to 5 Flesh Fiends
        //2 to 5 Mutilators
        //1 to 3 Vile Mothers
        //1 to 2 Plague Bringers
        //1 to 2 Stygian Furies
        //1 to 2 Pit Lords
        //0 to 2 Tainted
        if(nTier == 0)
        {
            nT0 = nPCount * 2;
            if(nT0 > 5)
            {
                nT0 = 5;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount * 2;
            if(nT1 > 5)
            {
                nT1 = 5;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount;
            if(nT2 > 3)
            {
                nT2 = 3;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount;
            if(nT3 > 2)
            {
                nT3 = 2;
            }
            return nT3;
        }
        else if(nTier == 4)
        {
            nT4 = nPCount;
            if(nT4 > 2)
            {
                nT4 = 2;
            }
            return nT4;
        }
        else if(nTier == 5)
        {
            nT5 = nPCount - 1;
            if(nT5 > 2)
            {
                nT5 = 2;
            }
            return nT5;
        }
        else if(nTier == 6)
        {
            nT5 = nPCount - 2;
            if(nT5 > 2)
            {
                nT5 = 2;
            }
            return nT5;
        }
    }
    else if(nWave == 7)
    {
        //Wave 8
        //2 to 5 Flesh Fiends
        //2 to 5 Mutilators
        //2 to 3 Vile Mothers
        //1 to 3 Plague Bringers
        //1 to 3 Stygian Furies
        //1 to 3 Pit Lords
        //1 to 2 Tainted
        if(nTier == 0)
        {
            nT0 = nPCount * 2;
            if(nT0 > 5)
            {
                nT0 = 5;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount * 2;
            if(nT1 > 5)
            {
                nT1 = 5;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount + 1;
            if(nT2 > 3)
            {
                nT2 = 3;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount;
            if(nT3 > 3)
            {
                nT3 = 3;
            }
            return nT3;
        }
        else if(nTier == 4)
        {
            nT4 = nPCount;
            if(nT4 > 3)
            {
                nT4 = 3;
            }
            return nT4;
        }
        else if(nTier == 5)
        {
            nT5 = nPCount - 1;
            if(nT5 > 3)
            {
                nT5 = 3;
            }
            return nT5;
        }
        else if(nTier == 6)
        {
            nT5 = nPCount - 1;
            if(nT5 > 3)
            {
                nT5 = 3;
            }
            return nT5;
        }
    }
    else if(nWave == 8)
    {
        //Wave 9
        //2 to 5 Flesh Fiends
        //2 to 5 Mutilators
        //2 to 3 Vile Mothers
        //2 to 3 Plague Bringers
        //2 to 3 Stygian Furies
        //1 to 3 Pit Lords
        //0 to 2 Tainted
        if(nTier == 0)
        {
            nT0 = nPCount * 2;
            if(nT0 > 5)
            {
                nT0 = 5;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount * 2;
            if(nT1 > 5)
            {
                nT1 = 5;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount + 1;
            if(nT2 > 3)
            {
                nT2 = 3;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount + 1;
            if(nT3 > 3)
            {
                nT3 = 3;
            }
            return nT3;
        }
        else if(nTier == 4)
        {
            nT4 = nPCount + 1;
            if(nT4 > 4)
            {
                nT4 = 4;
            }
            return nT4;
        }
        else if(nTier == 5)
        {
            nT5 = nPCount - 1;
            if(nT5 > 3)
            {
                nT5 = 3;
            }
            return nT5;
        }
        else if(nTier == 6)
        {
            nT5 = nPCount - 1;
            if(nT5 > 2)
            {
                nT5 = 2;
            }
            return nT5;
        }
    }
    else if(nWave == 9)
    {
        //Wave 10
        //2 to 6 Flesh Fiends
        //2 to 6 Mutilators
        //2 to 5 Vile Mothers
        //2 to 3 Plague Bringers
        //2 to 3 Stygian Furies
        //1 to 3 Pit Lords
        //0 to 3 Tainted
        if(nTier == 0)
        {
            nT0 = nPCount * 2;
            if(nT0 > 6)
            {
                nT0 = 6;
            }
            return nT0;
        }
        else if(nTier == 1)
        {
            nT1 = nPCount * 2;
            if(nT1 > 6)
            {
                nT1 = 6;
            }
            return nT1;
        }
        else if(nTier == 2)
        {
            nT2 = nPCount + 1;
            if(nT2 > 5)
            {
                nT2 = 5;
            }
            return nT2;
        }
        else if(nTier == 3)
        {
            nT3 = nPCount + 1;
            if(nT3 > 4)
            {
                nT3 = 4;
            }
            return nT3;
        }
        else if(nTier == 4)
        {
            nT4 = nPCount + 1;
            if(nT4 > 3)
            {
                nT4 = 3;
            }
            return nT4;
        }
        else if(nTier == 5)
        {
            nT5 = nPCount - 1;
            if(nT5 > 3)
            {
                nT5 = 3;
            }
            return nT5;
        }
        else if(nTier == 6)
        {
            nT5 = nPCount - 1;
            if(nT5 > 3)
            {
                nT5 = 3;
            }
            return nT5;
        }
    }
    return 0;
}
