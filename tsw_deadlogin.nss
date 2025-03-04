#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetEnteringObject();
    effect eKill = EffectDamage(9999);
    int nCheck = SQLocalsPlayer_GetInt(oPC, "CURRENTLY_DEAD");
    if(nCheck >= 1)
    {
        DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oPC));
        //SQLocalsPlayer_DeleteInt(oPC, "CURRENTLY_DEAD");
    }
}
