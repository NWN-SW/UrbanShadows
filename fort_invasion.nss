#include "fort_demon_army"
//
//Function to return a random waypoint from the fort area.
object RandomSpawn(int nValue)
{
    object oSpawn1 = GetObjectByTag("Fort_Spawn_South");
    object oSpawn2 = GetObjectByTag("Fort_Spawn_West");
    object oSpawn3 = GetObjectByTag("Fort_Spawn_East");

    //Get Location of one of the three waypoints to determine spawn location.
    switch(nValue)
    {
        case 0:
            return oSpawn1;
            break;
        case 1:
            return oSpawn2;
            break;
        case 2:
            return oSpawn3;
            break;
    }
    return oSpawn1;
}

//Main script
void main()
{
    string sVarCount = "PC_COUNT";
    string sVarDelay = "SPAWN_DELAY";
    string sVarWave = "INVASION_WAVE";
    object oSpawnMain;
    //object oFortLord = GetObjectByTag("FortLord_WZ");
    location lWP;
    int nPCount = GetLocalInt(OBJECT_SELF, sVarCount);
    int nDelay = GetLocalInt(OBJECT_SELF, sVarDelay);
    int nWave = GetLocalInt(OBJECT_SELF, sVarWave);
    int nLoop = 0;
    int nSpawn;

    //Enemy count variables.
    int nT0;
    int nT1;
    int nT2;
    int nT3;
    int nT4;
    int nT5;
    int nT6;

    //Ensure a minimum force is created.
    if(nPCount < 3)
    {
        nPCount = 3;
    }
    else if(nPCount > 8)
    {
        nPCount = 8;
    }

    //Decrease delay varaible by one, unless zero. If zero, spawn enemies.
    if(nDelay > 0)
    {
        nDelay = nDelay - 1;
        SetLocalInt(OBJECT_SELF, sVarDelay, nDelay);
    }
    else if(nDelay == 0 && nWave < 10)
    {
        //Check for players
        object oArea = GetObjectByTag("TheEnd_WZ");
        object oPC = GetFirstPC();
        object oPCArea = GetArea(oPC);
        object oLord = GetObjectByTag("GaiasBeacon");
        int nFlag = 0;
        effect eKill = EffectDeath();

        while(oPC != OBJECT_INVALID)
        {
            if(oPCArea == oArea)
            {
                nFlag = 1;
            }
            oPC = GetNextPC();
            oPCArea = GetArea(oPC);
        }

        //Reset the Fort Lord if no players are present.
        if(nFlag == 0)
        {
            SetLocalInt(OBJECT_SELF, sVarDelay, 0);
            ExecuteScript("fort_lord_death", oLord);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oLord);
            return;
        }

        //TIER 0 ENEMIES
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        //Spawn enemies
        nT0 = FortDemonArmy(nWave, 0, nPCount);
        while(nLoop < nT0)
        {
            CreateObject(1, "fortattackt2", lWP);
            nLoop = nLoop + 1;
        }
        nLoop = 0;
        //TIER 1 ENEMIES
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        //Spawn enemies
        nT1 = FortDemonArmy(nWave, 1, nPCount);
        while(nLoop < nT1)
        {
            CreateObject(1, "fortattackt3", lWP);
            nLoop = nLoop + 1;
        }
        nLoop = 0;
        //TIER 2 ENEMIES
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        //Spawn enemies
        nT2 = FortDemonArmy(nWave, 2, nPCount);
        while(nLoop < nT2)
        {
            CreateObject(1, "fortattackt5", lWP);
            nLoop = nLoop + 1;
        }
        nLoop = 0;
        //TIER 3 ENEMIES
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        //Spawn enemies
        nT3 = FortDemonArmy(nWave, 3, nPCount);
        while(nLoop < nT3)
        {
            CreateObject(1, "fortattackt4", lWP);
            nLoop = nLoop + 1;
        }
        nLoop = 0;
        //TIER 4 ENEMIES
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        //Spawn enemies
        nT4 = FortDemonArmy(nWave, 4, nPCount);
        while(nLoop < nT4)
        {
            CreateObject(1, "fortattackt6", lWP);
            nLoop = nLoop + 1;
        }
        nLoop = 0;
       //TIER 5 ENEMIES
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        //Spawn enemies
        nT5 = FortDemonArmy(nWave, 5, nPCount);
        while(nLoop < nT5)
        {
            CreateObject(1, "fortattackt7", lWP);
            nLoop = nLoop + 1;
        }
        nLoop = 0;
       //TIER 6 ENEMIES
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        //Spawn enemies
        nT6 = FortDemonArmy(nWave, 6, nPCount);
        while(nLoop < nT6)
        {
            CreateObject(1, "fortattackt8", lWP);
            nLoop = nLoop + 1;
        }
        nLoop = 0;
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, sVarDelay, 20);
        SetLocalInt(OBJECT_SELF, sVarWave, nWave);
    }
    else if(nDelay == 0 && nWave > 9)
    {
        object oPC = GetFirstPC();
        object oArea = GetArea(oPC);
        string sMessage = "Gaia's reinforcements have arrived to save you! Victory is near! Slay the remaining filth!";
        while(oPC != OBJECT_INVALID)
        {
            if(oArea == OBJECT_SELF)
            {
                SendMessageToPC(oPC, sMessage);
                FloatingTextStringOnCreature(sMessage, oPC, FALSE);
            }
            oPC = GetNextPC();
            oArea = GetArea(oPC);
        }
        //Get random spawn location
        nSpawn = Random(3);
        oSpawnMain = RandomSpawn(nSpawn);
        lWP = GetLocation(oSpawnMain);
        nLoop = 0;
        while(nLoop < 6)
        {
            CreateObject(1, "fortmyrelite", lWP);
            nLoop = nLoop + 1;
        }
        SetLocalInt(OBJECT_SELF, sVarDelay, 0);
        SetEventScript(OBJECT_SELF, 4000, "fort_demon_vict");
    }
}
