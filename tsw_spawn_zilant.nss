#include "utl_i_sqlplayer"
void main()
{

    object oPC = GetLastUsedBy();
    object oZilant = GetObjectByTag("Zilant");
    effect eDragon = EffectVisualEffect(VFX_FNF_SUMMONDRAGON);
    if(SQLocalsPlayer_GetInt(oPC, "RUSSIA_PUZZLE_2") == 1 && oZilant == OBJECT_INVALID)
    {
        /*
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDragon, GetLocation(GetWaypointByTag("RU_Spawn_Zilant")));
        CreateObject(OBJECT_TYPE_CREATURE, "nav", GetLocation(GetWaypointByTag("RU_Spawn_Zilant")), TRUE);
        */
        SendMessageToPC(oPC, "This object does nothing... for now.");
    }
}
