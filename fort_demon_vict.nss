#include "loot_fort_win"

void main()
{
    int iCount = 0;
    int iCheck = 0;
    int nWave = GetLocalInt(OBJECT_SELF, "INVASION_WAVE");
    int nPCount = GetLocalInt(OBJECT_SELF, "PC_COUNT");
    int nGold = nWave * 50000;
    object oOrigin = GetFirstObjectInArea(OBJECT_SELF);
    object oPC = GetFirstPC();
    object oArea = GetArea(OBJECT_SELF);
    object oPCArea = GetArea(oPC);
    object oCreature = GetNearestCreature(0, 20, oOrigin, iCount);
    string oTag = GetTag(oCreature);

    //Get VFX waypoints
    object oVFX1 = GetObjectByTag("WP_FORT_VFX_1");
    object oVFX2 = GetObjectByTag("WP_FORT_VFX_2");
    object oVFX3 = GetObjectByTag("WP_FORT_VFX_3");
    object oVFX4 = GetObjectByTag("WP_FORT_VFX_4");
    object oVFX5 = GetObjectByTag("WP_FORT_VFX_5");
    object oVFX6 = GetObjectByTag("WP_FORT_VFX_6");

    location lVFX1 = GetLocation(oVFX1);
    location lVFX2 = GetLocation(oVFX2);
    location lVFX3 = GetLocation(oVFX3);
    location lVFX4 = GetLocation(oVFX4);
    location lVFX5 = GetLocation(oVFX5);
    location lVFX6 = GetLocation(oVFX6);

    effect ePillar = EffectVisualEffect(184);

    while(oCreature != OBJECT_INVALID)
    {
        iCheck = 1;
        break;
    }

    if(iCheck == 0)
    {
        SendMessageToAllDMs("No Outsiders left. Fort Defense Complete.");
        while(oPC != OBJECT_INVALID)
        {
            if(oArea == OBJECT_SELF)
            {
                //Give Gold
                GiveGoldToCreature(oPC, nGold);
                //Give Loot
                LootFortWin(oPC, nPCount);
                SendMessageToPC(oPC, "The Beacon of Gaia fills you with the warmth of creation and pulls you away from the realm.");
            }
            oPC = GetNextPC();
            oPCArea = GetArea(oPC);
        }
        //Visual Effects
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePillar, lVFX1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePillar, lVFX2);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePillar, lVFX3);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePillar, lVFX4);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePillar, lVFX5);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePillar, lVFX6);
        SetLocalInt(OBJECT_SELF, "INVASION_WAVE", 0);
        SetEventScript(oArea, 4000, "area_fort_reset");
    }

}



