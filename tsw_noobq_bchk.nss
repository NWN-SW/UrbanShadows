#include "utl_i_sqlplayer"

int StartingConditional()
{

    // Check if new player.
    if(SQLocalsPlayer_GetInt(GetPCSpeaker(), "NOOBIE_QUEST") == 2)
    {
        return TRUE;
    }

        return FALSE;
}
