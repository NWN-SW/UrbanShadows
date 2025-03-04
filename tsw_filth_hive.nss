#include "pals_main"
#include "inc_loot_rolls"

void MinionBeams(object oCaller, string sTag)
{
    effect eBeam = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_CHEST);
    int nCount = 0;
    object oMinion = GetNearestObjectByTag(sTag, oCaller, nCount);
    while(oMinion != OBJECT_INVALID)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBeam, oMinion);
        nCount = nCount + 1;
        oMinion = GetNearestObjectByTag(sTag, oCaller, nCount);
    }
}

void main()
{
    //We want to give this creature a unique ID, create a variable with it, then use that to determine when its minions die.
    int nRandom = Random(100000);
    string sID = IntToString(nRandom);
    string sMinionTag = "FilthMinion_" + sID;
    string sTag = GetTag(OBJECT_SELF);
    string sSnip = GetStringLeft(sTag, 8);
    string sNewTag = sSnip + "_" + sID;
    SetTag(OBJECT_SELF, sNewTag);
    int nLoop;
    object oMinion;

    SetLocalString(OBJECT_SELF, "FILTH_MINION_TAG", sMinionTag);

    if(sSnip == "Filth_T1")
    {
        nLoop = 4;
        SetLocalInt(OBJECT_SELF, "FILTH_MINION_COUNT", nLoop);
        while(nLoop > 0)
        {
            oMinion = CreateObject(1, "filth_min_1", GetLocation(OBJECT_SELF), FALSE, sMinionTag);
            SetLocalString(oMinion, "FILTH_MASTER_TAG", sNewTag);
            nLoop = nLoop - 1;
        }
        ExecuteScript("loot_boss_t1");
    }
    else if(sSnip == "Filth_T2")
    {
        nLoop = 6;
        SetLocalInt(OBJECT_SELF, "FILTH_MINION_COUNT", nLoop);
        while(nLoop > 0)
        {
            oMinion = CreateObject(1, "filth_min_2", GetLocation(OBJECT_SELF), FALSE, sMinionTag);
            SetLocalString(oMinion, "FILTH_MASTER_TAG", sNewTag);
            nLoop = nLoop - 1;
        }
        ExecuteScript("loot_boss_t2");
    }
    else if(sSnip == "Filth_T3")
    {
        nLoop = 8;
        SetLocalInt(OBJECT_SELF, "FILTH_MINION_COUNT", nLoop);
        while(nLoop > 0)
        {
            oMinion = CreateObject(1, "filth_min_3", GetLocation(OBJECT_SELF), FALSE, sMinionTag);
            SetLocalString(oMinion, "FILTH_MASTER_TAG", sNewTag);
            nLoop = nLoop - 1;
        }
        ExecuteScript("loot_boss_t3");
    }
    else if(sSnip == "Filth_T4")
    {
        nLoop = 10;
        SetLocalInt(OBJECT_SELF, "FILTH_MINION_COUNT", nLoop);
        while(nLoop > 0)
        {
            oMinion = CreateObject(1, "filth_min_4", GetLocation(OBJECT_SELF), FALSE, sMinionTag);
            SetLocalString(oMinion, "FILTH_MASTER_TAG", sNewTag);
            nLoop = nLoop - 1;
        }
        ExecuteScript("loot_boss_t4");
    }

    DelayCommand(2.0, MinionBeams(OBJECT_SELF, sMinionTag));
    DelayCommand(120.0, MinionBeams(OBJECT_SELF, sMinionTag));
    ExecuteScript("npc_filth_names");
    ExecuteScript("tsw_filth_dark");
    ExecuteScript("tsw_scale_npcs");
}
