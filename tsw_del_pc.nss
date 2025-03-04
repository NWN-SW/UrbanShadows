#include "nwnx_admin"
#include "utl_i_sqlplayer"

void main()
{
    object oPC = GetLastSpeaker();

    if (SQLocalsPlayer_GetInt(oPC,"iMarkedForDeath") ==1 )
    {
		FloatingTextStringOnCreature("# Character deletion in progress, please wait. #",oPC,FALSE);
        DelayCommand(6.0f,NWNX_Administration_DeletePlayerCharacter(oPC,FALSE,"Character deleted - You may reconnect."));
    }

}
