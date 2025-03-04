#include "utl_i_sqlplayer"

void main()
{
    //Declare major variables
    object oPC = GetPCChatSpeaker();
    object oTrigger = GetObjectByTag("Egypt_Puzzle_1");
    object oAlchemite;
    string sTag;
    int nLoopCheck = 0;
    int nInArea = GetLocalInt(oPC,"E_P_1_IN");
    int nComplete = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_1");
    effect eFire = EffectVisualEffect(54);

    //Return if we don't like what we find
    if(!GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
    {
        return;
    }
    else if(nInArea != 1)
    {
        return;
    }

    //Get last chat message and convert it to lower case.
    string sCommand = GetStringLowerCase(GetPCChatMessage());

    if(sCommand == "from ashes i will learn" || sCommand == "from ashes i will learn." || sCommand == "from ashes, i will learn" || sCommand == "i will learn." || sCommand == "i will learn")
    {
        if(nComplete == 1)
        {
            DelayCommand(1.0, SendMessageToPC(oPC, "The voices speak, 'You already have our approval.'"));
            return;
        }

        SQLocalsPlayer_SetInt(oPC, "EGYPT_PUZZLE_1", 1);
        DelayCommand(1.0, SendMessageToPC(oPC, "The voices speak proudly, 'May your gaze see the warmth of all life.'"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oPC);
        AddJournalQuestEntry("EGYPT_PUZZLE", 1, oPC, FALSE);
    }
}
