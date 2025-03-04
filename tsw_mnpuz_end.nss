#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    effect eBoom = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eFire = EffectVisualEffect(VFX_FNF_FIRESTORM);
    effect eGoo = EffectVisualEffect(VFX_COM_CHUNK_GREEN_MEDIUM);
    effect eGore = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

    //Clean old bugged entries
    int nCheck1 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_6");
    int nCheck2 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_4");
    if(nCheck1 == 1 && nCheck2 != 1)
    {
        RemoveJournalQuestEntry("Astoria_Puzzle", oPC, FALSE);
        SQLocalsPlayer_SetInt(oPC, "ASTORIA_PUZZLE_6", 0);
        SQLocalsPlayer_SetInt(oPC, "MINNESOTA_PUZZLE_6", 1);
        AddJournalQuestEntry("Minnesota_Puzzle", 6, oPC, FALSE);
    }
    else
    {
        //Give Item
        CreateItemOnObject("shoptokent3", oPC);
        SQLocalsPlayer_SetInt(oPC, "MINNESOTA_PUZZLE_6", 1);
        AddJournalQuestEntry("Minnesota_Puzzle", 6, oPC, FALSE);
    }

    //Remove quest item
    object oCellphone = GetItemPossessedBy(oPC, "BadlyDamagedCellphone");
    DestroyObject(oCellphone);
    AddReputation(oPC, 10);


    //Explosions and fire
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, GetLocation(oPC));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFire, GetLocation(oPC));

    location lWP1 = GetLocation(GetWaypointByTag("MN_PUZ_VFX_1"));
    location lWP2 = GetLocation(GetWaypointByTag("MN_PUZ_VFX_2"));
    location lWP3 = GetLocation(GetWaypointByTag("MN_PUZ_VFX_3"));
    location lWP4 = GetLocation(GetWaypointByTag("MN_PUZ_VFX_4"));
    location lWP5 = GetLocation(GetWaypointByTag("MN_PUZ_VFX_5"));
    location lWP6 = GetLocation(GetWaypointByTag("MN_PUZ_VFX_6"));

    DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lWP1));
    DelayCommand(1.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGoo, lWP1));
    DelayCommand(1.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGore, lWP1));

    DelayCommand(1.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lWP2));
    DelayCommand(1.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGoo, lWP2));
    DelayCommand(1.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGore, lWP2));

    DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lWP3));
    DelayCommand(2.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGoo, lWP3));
    DelayCommand(2.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGore, lWP3));

    DelayCommand(2.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lWP4));
    DelayCommand(2.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGoo, lWP4));
    DelayCommand(2.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGore, lWP4));

    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lWP5));
    DelayCommand(3.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGoo, lWP5));
    DelayCommand(3.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGore, lWP5));

    DelayCommand(3.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lWP6));
    DelayCommand(3.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGoo, lWP6));
    DelayCommand(3.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGore, lWP6));

}
