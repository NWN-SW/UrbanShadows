#include "utl_i_sqlplayer"
#include "tsw_faction_func"

void main()
{
    object oAltar = GetObjectByTag("AltarOfTrueFlame");
    object oSummoner = GetLocalObject(oAltar, "PUZZLE_SUMMONER");
    object oArea;
    object oAreaCompare;
    object oPC;
    effect eBoom = EffectVisualEffect(VFX_FNF_FIRESTORM);
    effect eGross = EffectVisualEffect(VFX_IMP_DESTRUCTION);
    effect eBeam =  EffectVisualEffect(VFX_FNF_SUNBEAM);
    effect eFire =  EffectVisualEffect(VFX_IMP_HEAD_FIRE);
    int nPuz1;
    int nPuz2;
    int nPuz3;
    int nPuz4;

    //Get targets
    oArea = GetArea(oAltar);
    oPC = GetFirstFactionMember(oSummoner);
    nPuz1 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_1");
    nPuz2 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_2");
    nPuz3 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_3");
    nPuz4 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_4");

    //Return event for altar
    SetEventScript(oAltar, 9012, "tsw_egpuz_4");

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eGross, OBJECT_SELF);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oPC))
    {
        oAreaCompare = GetArea(oPC);
        if(nPuz1 == 1 && nPuz2 == 1 && nPuz3 == 1 && nPuz4 != 1 && oArea == oAreaCompare)
        {
            //VFX
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBeam, oPC);
            //Give Item
            CreateItemOnObject("shoptokent4", oPC);
            SQLocalsPlayer_SetInt(oPC, "EGYPT_PUZZLE_4", 1);
            AddJournalQuestEntry("EGYPT_PUZZLE", 4, oPC, FALSE);
            AddReputation(oPC, 12);
        }
        oPC = GetNextFactionMember(oSummoner);
        nPuz1 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_1");
        nPuz2 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_2");
        nPuz3 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_3");
        nPuz4 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_4");
    }
}
