#include "utl_i_sqlplayer"

void main()
{
    //Declare major variables
    object oPC = GetPCChatSpeaker();
    if(!GetIsPC(oPC))
    {   return;   }

    //Get last chat message and convert it to lower case.
    string sCommand = GetStringLowerCase(GetPCChatMessage());

    if(sCommand == "/shifter_feral")
    {
        SQLocalsPlayer_SetInt(oPC, "SHAPESHIFT_TOTEM", 1);
        SendMessageToPC(oPC, "Your shapeshifting will now assume humanoid beast forms.");
        SetPCChatVolume(TALKVOLUME_SILENT_TALK);
    }

    if(sCommand == "/shifter_normal")
    {
        SQLocalsPlayer_SetInt(oPC, "SHAPESHIFT_TOTEM", 0);
        SendMessageToPC(oPC, "Your shapeshifting will now assume normal beast forms.");
        SetPCChatVolume(TALKVOLUME_SILENT_TALK);
    }
}
