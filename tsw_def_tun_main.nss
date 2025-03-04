#include "inc_timer"
#include "tsw_respawn_func"
#include "tsw_faction_func"

location GetTunnelSpawn()
{
    object oWP1 = GetWaypointByTag("TUNNEL_SPAWNER_1");
    object oWP2 = GetWaypointByTag("TUNNEL_SPAWNER_2");
    location lLoc;

    int nRoll = d2(1);
    if(nRoll == 1)
    {
        lLoc = GetLocation(oWP1);
    }
    else if(nRoll == 2)
    {
        lLoc = GetLocation(oWP2);
    }

    return lLoc;
}

location GetZamboSpawn()
{
    object oWP1 = GetWaypointByTag("TUN_DEF_P1");
    object oWP2 = GetWaypointByTag("TUN_DEF_P2");
    location lLoc;

    int nRoll = d2(1);
    if(nRoll == 1)
    {
        lLoc = GetLocation(oWP1);
    }
    else if(nRoll == 2)
    {
        lLoc = GetLocation(oWP2);
    }

    return lLoc;
}

void SpawnSilentZombies(int nPCount, int nMod = 0)
{
    int nAmount = nPCount * 2 + nMod;
    if(nAmount < 1)
    {
        nAmount = 1;
    }
    int nCount;
    while(nCount < nAmount)
    {
        location lLoc = GetZamboSpawn();
        CreateObject(OBJECT_TYPE_CREATURE, "def_tun_1", lLoc);
        nCount = nCount + 1;
    }
}

void SpawnSilentWarriors(int nPCount, int nMod = 0)
{
    int nAmount = nPCount + nMod;
    if(nAmount < 1)
    {
        nAmount = 1;
    }
    int nCount;
    while(nCount < nAmount)
    {
        location lLoc = GetTunnelSpawn();
        CreateObject(OBJECT_TYPE_CREATURE, "def_tun_2", lLoc);
        nCount = nCount + 1;
    }
}

void SpawnSilentHunters(int nPCount, int nMod = 0)
{
    int nAmount = nPCount + nMod;
    if(nAmount < 1)
    {
        nAmount = 1;
    }
    int nCount;
    while(nCount < nAmount)
    {
        location lLoc = GetTunnelSpawn();
        CreateObject(OBJECT_TYPE_CREATURE, "def_tun_3", lLoc);
        nCount = nCount + 1;
    }
}

void SpawnSilentSpecters(int nPCount, int nMod = 0)
{
    int nAmount = nPCount + nMod;
    if(nAmount < 1)
    {
        nAmount = 1;
    }
    int nCount;
    while(nCount < nAmount)
    {
        location lLoc = GetTunnelSpawn();
        CreateObject(OBJECT_TYPE_CREATURE, "def_tun_4", lLoc);
        nCount = nCount + 1;
    }
}

void SpawnSilentShapers(int nPCount, int nMod = 0)
{
    int nAmount = nPCount - 1 + nMod;
    if(nAmount < 1)
    {
        nAmount = 1;
    }
    int nCount;
    while(nCount < nAmount)
    {
        location lLoc = GetTunnelSpawn();
        CreateObject(OBJECT_TYPE_CREATURE, "def_tun_5", lLoc);
        nCount = nCount + 1;
    }
}

void SpawnSilentDevourers(int nPCount, int nMod = 0)
{
    int nAmount = nPCount - 2 + nMod;
    if(nAmount < 1)
    {
        nAmount = 1;
    }
    int nCount;
    while(nCount < nAmount)
    {
        location lLoc = GetTunnelSpawn();
        CreateObject(OBJECT_TYPE_CREATURE, "def_tun_6", lLoc);
        nCount = nCount + 1;
    }
}

void SpawnSilentGoliath(int nPCount, int nMod = 0)
{
    int nAmount = nPCount - 3 + nMod;
    if(nAmount < 1)
    {
        nAmount = 1;
    }
    int nCount;
    while(nCount < nAmount)
    {
        location lLoc = GetTunnelSpawn();
        CreateObject(OBJECT_TYPE_CREATURE, "def_tun_7", lLoc);
        nCount = nCount + 1;
    }
}

void DoTunnelVictory(int nWave)
{
    int nMoney = (nWave) + 1 * 5500;
    object oWP = GetWaypointByTag("tp_recall");
    object oPC = GetFirstPC();
    while(oPC != OBJECT_INVALID)
    {
        if(GetArea(oPC) == OBJECT_SELF)
        {
            SendMessageToPC(oPC, "You have successfully defended this region! You are rewarded " + IntToString(nMoney) + " for your efforts in thinning the horde. The Council of Venice offers you bonus items in thanks.");

            //Give items
            CreateItemOnObject("shoptokent4", oPC);
            CreateItemOnObject("shoptokent4", oPC);
            AddReputation(oPC, 50);

            if(GetIsDead(oPC))
            {
                DoPCRespawn(oPC);
            }

            //Teleport
            AssignCommand(oPC, ClearAllActions(TRUE));
            DelayCommand(0.5, AssignCommand(oPC, ActionJumpToObject(oWP)));
        }
        oPC = GetNextPC();
    }
    DelayCommand(4.0, ExecuteScript("tsw_destroy_area", OBJECT_SELF));
}

void main()
{
    int nToggle = GetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_TOGGLE");
    int nWave = GetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT");
    int nPCount = 0;
    int nPCTotal = 0;
    int nCount = 0;
    int nAmount;
    location lLoc;

    if(nToggle != 1)
    {
        //SendMessageToPC(GetFirstPC(), "We off.");
        return;
    }

    //Do alive check for all players
    object oPC = GetFirstPC();
    while(oPC != OBJECT_INVALID)
    {
        if(GetArea(oPC) == OBJECT_SELF)
        {
            nPCTotal = nPCTotal + 1;
            if(!GetIsDead(oPC))
            {
                nPCount = nPCount + 1;
            }
        }
        oPC = GetNextPC();
    }

    if(nPCount == 0)
    {
        //Do losing condition for all players
        int nMoney = (nWave - 1) * 5500;
        object oPC = GetFirstPC();
        effect eVis = EffectVisualEffect(VFX_FNF_HORRID_WILTING);
        while(oPC != OBJECT_INVALID)
        {
            if(GetArea(oPC) == OBJECT_SELF)
            {
                SendMessageToPC(oPC, "The area is overrun. However, you are awarded " + IntToString(nMoney) + " for your efforts in thinning the horde.");

                //Give items
                if(nWave > 4 && nWave < 8)
                {
                    CreateItemOnObject("shoptokent3", oPC);
                    CreateItemOnObject("shoptokent3", oPC);
                }

                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC));

                if(GetIsDead(oPC))
                {
                    DelayCommand(2.0, DoPCRespawn(oPC));
                }
            }
            oPC = GetNextPC();
        }
        DelayCommand(4.0, ExecuteScript("tsw_destroy_area", OBJECT_SELF));
    }

    //WAVE ONE
    if(nWave == 0)
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Increment Wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 60);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE TWO
    if(nWave == 1 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 60);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE THREE
    if(nWave == 2 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal);

        //Hunters
        SpawnSilentHunters(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 90);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE FOUR
    if(nWave == 3 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal);

        //Hunters
        SpawnSilentHunters(nPCTotal);

        //Specters
        SpawnSilentSpecters(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 90);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE FIVE
    if(nWave == 4 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal);

        //Hunters
        SpawnSilentHunters(nPCTotal);

        //Specters
        SpawnSilentSpecters(nPCTotal);

        //Shapers
        SpawnSilentShapers(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 180);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE SIX
    if(nWave == 5 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal);

        //Hunters
        SpawnSilentHunters(nPCTotal);

        //Specters
        SpawnSilentSpecters(nPCTotal);

        //Shapers
        SpawnSilentShapers(nPCTotal);

        //Devourers
        SpawnSilentDevourers(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 180);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE SEVEN
    if(nWave == 6 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal);

        //Hunters
        SpawnSilentHunters(nPCTotal);

        //Specters
        SpawnSilentSpecters(nPCTotal);

        //Shapers
        SpawnSilentShapers(nPCTotal);

        //Devourers
        SpawnSilentDevourers(nPCTotal);

        //Goliaths
        SpawnSilentGoliath(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 300);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE EIGHT
    if(nWave == 7 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal, 1);

        //Hunters
        SpawnSilentHunters(nPCTotal, 1);

        //Specters
        SpawnSilentSpecters(nPCTotal, 1);

        //Shapers
        SpawnSilentShapers(nPCTotal);

        //Devourers
        SpawnSilentDevourers(nPCTotal);

        //Goliaths
        SpawnSilentGoliath(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 300);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE NINE
    if(nWave == 8 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal, 2);

        //Hunters
        SpawnSilentHunters(nPCTotal, 2);

        //Specters
        SpawnSilentSpecters(nPCTotal, 2);

        //Shapers
        SpawnSilentShapers(nPCTotal, 1);

        //Devourers
        SpawnSilentDevourers(nPCTotal);

        //Goliaths
        SpawnSilentGoliath(nPCTotal);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 300);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //WAVE TEN
    if(nWave == 9 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        //Spawn enemies of type based on number of players.
        //Zambos
        SpawnSilentZombies(nPCTotal);

        //Skellies
        SpawnSilentWarriors(nPCTotal, 3);

        //Hunters
        SpawnSilentHunters(nPCTotal, 2);

        //Specters
        SpawnSilentSpecters(nPCTotal, 3);

        //Shapers
        SpawnSilentShapers(nPCTotal, 2);

        //Devourers
        SpawnSilentDevourers(nPCTotal, 1);

        //Goliaths
        SpawnSilentGoliath(nPCTotal, 1);

        //Increment wave
        nWave = nWave + 1;
        SetLocalInt(OBJECT_SELF, "WAVE_DEFENSE_COUNT", nWave);

        //Set two-minute timer
        SetTimer("TUNNEL_DEF_WAV_TIMER", 300);

        //Do VFX
        object oWP1 = GetWaypointByTag("TUN_DEF_P1");
        object oWP2 = GetWaypointByTag("TUN_DEF_P2");
        location lLoc1 = GetLocation(oWP1);
        location lLoc2 = GetLocation(oWP2);
        effect eVis = EffectVisualEffect(241);
        effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lLoc2);
    }

    //Victory!
    if(nWave == 10 && GetTimerEnded("TUNNEL_DEF_WAV_TIMER"))
    {
        object oWP = GetWaypointByTag("WP_Tunnel_Center");
        location lLoc = GetLocation(oWP);
        int nCheck;

        object oEnemy = GetFirstObjectInShape(SHAPE_SPHERE, 500.0, lLoc);
        while(oEnemy != OBJECT_INVALID)
        {
            if(!GetIsPC(oEnemy) && !GetIsPC(GetMaster(oEnemy)))
            {
                nCheck = 1;
                break;
            }
            oEnemy = GetNextObjectInShape(SHAPE_SPHERE, 500.0, lLoc);
        }

        if(nCheck != 1)
        {
            DoTunnelVictory(nWave);
        }
    }
}
