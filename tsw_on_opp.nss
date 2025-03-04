#include "nwnx_events"
#include "utl_i_sqlplayer"

void main()
{
    if (SQLocalsPlayer_GetInt(OBJECT_SELF, "NO_OPP_SETTING") ==1)
	{
		NWNX_Events_SkipEvent();
	}
}
