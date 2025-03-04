void main()
{
    //Declare major variables
    //How many waves?
    int nWaves = GetLocalInt(OBJECT_SELF, "WAVES");
    int nWavesCounter = GetLocalInt(OBJECT_SELF, "WAVES_COUNTER");
    //Creature resrefs and their amount.
    string sType1 = GetLocalString(OBJECT_SELF, "TYPE_1");
    int nCount1 = GetLocalInt(OBJECT_SELF, "TYPE_1_COUNT");
    string sType2 = GetLocalString(OBJECT_SELF, "TYPE_2");
    int nCount2 = GetLocalInt(OBJECT_SELF, "TYPE_2_COUNT");
    string sType3 = GetLocalString(OBJECT_SELF, "TYPE_3");
    int nCount3 = GetLocalInt(OBJECT_SELF, "TYPE_3_COUNT");
    string sType4 = GetLocalString(OBJECT_SELF, "TYPE_4");
    int nCount4 = GetLocalInt(OBJECT_SELF, "TYPE_4_COUNT");
    string sType5 = GetLocalString(OBJECT_SELF, "TYPE_5");
    int nCount5 = GetLocalInt(OBJECT_SELF, "TYPE_5_COUNT");
    string sType6 = GetLocalString(OBJECT_SELF, "TYPE_6");
    int nCount6 = GetLocalInt(OBJECT_SELF, "TYPE_6_COUNT");
    string sType7 = GetLocalString(OBJECT_SELF, "TYPE_7");
    int nCount7 = GetLocalInt(OBJECT_SELF, "TYPE_7_COUNT");
    string sType8 = GetLocalString(OBJECT_SELF, "TYPE_8");
    int nCount8 = GetLocalInt(OBJECT_SELF, "TYPE_8_COUNT");
    //Get spawn VFX
    int nVFX = GetLocalInt(OBJECT_SELF, "SPAWN_VFX");
    effect eVis = EffectVisualEffect(nVFX);
    //Respawn timer
    int nTimer = GetLocalInt(OBJECT_SELF, "TIMER");
    //Delay between waves
    int nDelay = GetLocalInt(OBJECT_SELF, "DELAY");
    int nDelayCounter = GetLocalInt(OBJECT_SELF, "DELAY_COUNTER");
    //Get the prefix of the tag of this trigger.
    string nTag = GetTag(OBJECT_SELF);
    nTag = GetStringLeft(nTag, 4);
    //Spawn looper
    int nLoop = 0;

    //There can be any number of spawn waypoints.
    //We want to count how many there are so we can choose at which one to spawn creatures.
    //We'll count the waypoints and store it for later.
    object oSpawn = GetObjectByTag(nTag, 0);
    int nWPCount = 0;

    while(oSpawn != OBJECT_INVALID)
    {
        nWPCount = nWPCount + 1;
        oSpawn = GetObjectByTag(nTag, nWPCount);
    }
    int nRandSpawn = Random(nWPCount);
    location lSpawn;

    //Spawning
    if(nDelayCounter == 0)
    {
        if(nWavesCounter < nWaves)
        {
            //Get a spawn location.
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
            //Spawn Type 1
            if(sType1 != "")
            {
                while(nLoop < nCount1)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType1, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Reset spawn location and count.
            nLoop = 0;
            nRandSpawn = Random(nWPCount);
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);

            //Spawn Type 2
            if(sType2 != "")
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
                while(nLoop < nCount2)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType2, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Reset spawn location and count.
            nLoop = 0;
            nRandSpawn = Random(nWPCount);
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);

            //Spawn Type 3
            if(sType3 != "")
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
                while(nLoop < nCount3)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType3, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Reset spawn location and count.
            nLoop = 0;
            nRandSpawn = Random(nWPCount);
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);

            //Spawn Type 4
            if(sType4 != "")
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
                while(nLoop < nCount4)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType4, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Reset spawn location and count.
            nLoop = 0;
            nRandSpawn = Random(nWPCount);
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);

            //Spawn Type 5
            if(sType5 != "")
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
                while(nLoop < nCount5)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType5, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Reset spawn location and count.
            nLoop = 0;
            nRandSpawn = Random(nWPCount);
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);

            //Spawn Type 6
            if(sType6 != "")
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
                while(nLoop < nCount6)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType6, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Reset spawn location and count.
            nLoop = 0;
            nRandSpawn = Random(nWPCount);
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);

            //Spawn Type 7
            if(sType7 != "")
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
                while(nLoop < nCount7)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType7, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Reset spawn location and count.
            nLoop = 0;
            nRandSpawn = Random(nWPCount);
            oSpawn = GetObjectByTag(nTag, nRandSpawn);
            lSpawn = GetLocation(oSpawn);

            //Spawn Type 8
            if(sType8 != "")
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lSpawn);
                while(nLoop < nCount8)
                {
                    CreateObject(OBJECT_TYPE_CREATURE, sType8, lSpawn, FALSE);
                    nLoop = nLoop + 1;
                }
            }
            //Increment wave counter.
            nWavesCounter = nWavesCounter + 1;
            SetLocalInt(OBJECT_SELF, "WAVES_COUNTER", nWavesCounter);
            SetLocalInt(OBJECT_SELF, "DELAY_COUNTER", 1);
        }
        else if(nWavesCounter == nWaves)
        {
            SetLocalInt(OBJECT_SELF, "WAVES_COUNTER", 0);
            SetLocalInt(OBJECT_SELF, "DELAY_COUNTER", 0);
            SetEventScript(OBJECT_SELF, 7000, "npc_spawn_cd");
        }

    }
    else
    {
        nDelayCounter = nDelayCounter + 1;
        SetLocalInt(OBJECT_SELF, "DELAY_COUNTER", nDelayCounter);
    }

    if(nDelayCounter == nDelay)
    {
        SetLocalInt(OBJECT_SELF, "DELAY_COUNTER", 0);
    }
}
