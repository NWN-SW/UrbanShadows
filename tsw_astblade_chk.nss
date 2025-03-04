#include "nw_i0_tool"
#include "utl_i_sqlplayer"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nCheck1 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_6");
    int nCheck2 = SQLocalsPlayer_GetInt(oPC, "ASTORIA_PUZZLE_4");
    if(HasItem(GetPCSpeaker(), "ObsidianHandle") && !HasItem(GetPCSpeaker(), "ObsidianBlade") && nCheck1 != 1 && nCheck2 != 1)
    {
        return TRUE;
    }

    return FALSE;
}
