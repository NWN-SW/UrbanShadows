#include "utl_i_sqlplayer"
#include "gen_inc_color"

void main()
{
    object oPC = GetPCSpeaker();
    int nDone = SQLocalsPlayer_GetInt(oPC, "AM_HARDCORE");
    if(nDone != 1)
    {
        SQLocalsPlayer_SetInt(oPC, "AM_HARDCORE", 1);

        effect eBanshee = EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBanshee, oPC);

        object oReceiver = GetFirstPC();
        string sName = GetName(oPC);
        string sMessage = sName + " become a Hardcore character! All the best to you, " + sName + ".";
        while(oReceiver != OBJECT_INVALID)
        {
            SendMessageToPC(oReceiver, sMessage);
            oReceiver = GetNextPC();
        }

        SendMessageToPC(oPC, "You may now use the /hardcore emote to demonstrate your bravery.");
        AddJournalQuestEntry("Hardcore_Journal", 1, oPC, FALSE);
    }
    else
    {
        SendMessageToPC(oPC, "You are already a hardcore character.");
    }
}
