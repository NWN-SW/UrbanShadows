#include "utl_i_sqlplayer"

void RunEgyptPuzzleThree(object oPC)
{
    int nLocation = GetLocalInt(oPC, "E_P_3_IN");
    int nPuz1 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_1");
    int nPuz2 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_2");
    int nPuz3 = SQLocalsPlayer_GetInt(oPC, "EGYPT_PUZZLE_3");

    if(nPuz3 == 1)
    {
        DelayCommand(1.0, SendMessageToPC(oPC, "Voices echo from your surroundings, 'You already have our approval.'"));
        return;
    }
    else
    {
        effect eFire = EffectVisualEffect(54);
        object oItemToTake;

        if(nLocation == 1 && nPuz3 != 1)
        {
            if(nPuz1 == 1 && nPuz2 == 1)
            {
                SQLocalsPlayer_SetInt(oPC, "EGYPT_PUZZLE_3", 1);
                AddJournalQuestEntry("EGYPT_PUZZLE", 3, oPC, FALSE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oPC);
                DelayCommand(1.0, SendMessageToPC(oPC, "A mass of deep voices echo around you, 'Thank you for remembering us. Go with our Blessing of Empathy.'"));
            }
            else
            {
                SendMessageToPC(oPC, "Voices echo sadly from your surroundings, 'We do not sense the Blessing of Ash and the Blessing of Fire upon you.'");
            }
        }
    }
}
