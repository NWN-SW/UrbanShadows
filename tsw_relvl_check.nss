#include "utl_i_sqlplayer"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nCheck = SQLocalsPlayer_GetInt(oPC, "Prologue_Quest");
    if(nCheck >= 7)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
