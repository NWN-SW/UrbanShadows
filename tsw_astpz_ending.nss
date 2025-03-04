#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oPC = GetPCSpeaker();
    effect eWeird = EffectVisualEffect(VFX_FNF_WEIRD);
    effect eHowl = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

    //Give Items
    CreateItemOnObject("shoptokent4", oPC);
    CreateItemOnObject("shoptokent4", oPC);
    //Set quest done
    SQLocalsPlayer_SetInt(oPC, "ASTORIA_PUZZLE_6", 1);
    AddJournalQuestEntry("Astoria_Puzzle", 6, oPC, FALSE);
    //effects
    object oScream = GetObjectByTag("Ast_Scream");
    SoundObjectPlay(oScream);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eShake, GetLocation(oPC));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWeird, GetLocation(oPC));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eHowl, GetLocation(oPC));

    //Remove quest item
    object oBlade = GetItemPossessedBy(oPC, "ObsidianSword");
    DestroyObject(oBlade);
    AddReputation(oPC, 20);
}
