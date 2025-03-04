#include "utl_i_sqlplayer"

void CreateTyrant(object oWP)
{
    location lWP = GetLocation(oWP);
    CreateObject(1, "tyranttrueflame", lWP, TRUE);
}

void main()
{
    object oPC = GetLastUsedBy();
    int nPuz1 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_1");
    int nPuz2 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_2");
    int nPuz3 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_3");
    int nPuz4 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_4");
    object oWP = GetObjectByTag("WP_TYRANT_SUMMON");
    location lLoc = GetLocation(oWP);

    //VFX
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eBoom = EffectVisualEffect(VFX_IMP_PULSE_FIRE);


    if(nPuz1 == 1 && nPuz2 == 1 && nPuz3 == 1 && nPuz4 != 1)
    {
        SetEventScript(OBJECT_SELF, 9012, "");
        SetLocalObject(OBJECT_SELF, "PUZZLE_SUMMONER", oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, OBJECT_SELF);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lLoc);
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lLoc));
        DelayCommand(1.5f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lLoc));
        DelayCommand(2.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lLoc));
        DelayCommand(2.5f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBoom, lLoc));
        DelayCommand(3.0f, CreateTyrant(oWP));
        DelayCommand(30.0f, ExecuteScript("tsw_egpuz_clnup"));
    }
    else
    {
        SendMessageToPC(oPC, "This altar does nothing when you touch it.");
    }
}
