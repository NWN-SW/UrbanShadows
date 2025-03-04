#include "utl_i_sqlplayer"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nFirstQuest = SQLocalsPlayer_GetInt(oPC, "MINNESOTA_PUZZLE_6");

    if (nFirstQuest == 0)
    {
        return TRUE;
    }

    else
        return FALSE;
}
