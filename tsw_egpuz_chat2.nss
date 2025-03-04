#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetPCSpeaker();
    if(!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
    {
        return;
    }
    SQLocalsPlayer_SetInt(oPC, "EGYPT_PUZZLE_2", 1);
    AddJournalQuestEntry("EGYPT_PUZZLE", 2, oPC, FALSE);
    effect eFire = EffectVisualEffect(54);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oPC);

}
