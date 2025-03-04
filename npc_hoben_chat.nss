#include "utl_i_sqlplayer"

void main()
{
    //Check if quest is in progress
    object oPC = GetLastSpeaker();
    int nRandom;
    int nCheck = SQLocalsPlayer_GetInt(oPC, "GNOME_QUEST");

    if(nCheck == 0 || nCheck == 11)
    {
        ClearAllActions();
        AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "", TRUE));
    }
    else if(nCheck >= 50)
    {
        nRandom = d10(1);
        if(nRandom == 1)
        {
            SpeakString("'Hi, friend!'");
        }
        else if(nRandom == 2)
        {
            SpeakString("'So many bugs!'");
        }
        else if(nRandom == 3)
        {
            SpeakString("'Scary gnomes gone!'");
        }
        else if(nRandom == 4)
        {
            SpeakString("'Meats smells yums!'");
        }
        else if(nRandom == 5)
        {
            SpeakString("'Dad flowers is pretty!'");
        }
        else if(nRandom == 6)
        {
            SpeakString("'Hoben found worm!'");
        }
        else if(nRandom == 7)
        {
            SpeakString("'The inner machinations of Hoben's mind are an enigma.'");
        }
        else if(nRandom == 8)
        {
            SpeakString("'Hoben making dirt house!'");
        }
        else if(nRandom == 9)
        {
            SpeakString("'Mean gnomes all gone!'");
        }
        else if(nRandom == 10)
        {
            SpeakString("'Thanks for save Hoben from gnomes!'");
        }
    }
    else
    {
        nRandom = d10(1);
        if(nRandom == 1)
        {
            SpeakString("'Hi!'");
        }
        else if(nRandom == 2)
        {
            SpeakString("'So many bugs!'");
        }
        else if(nRandom == 3)
        {
            SpeakString("'Leafs has colours!'");
        }
        else if(nRandom == 4)
        {
            SpeakString("'Meats smells yums!'");
        }
        else if(nRandom == 5)
        {
            SpeakString("'Dad flowers is pretty!'");
        }
        else if(nRandom == 6)
        {
            SpeakString("'Hoben found worm!'");
        }
        else if(nRandom == 7)
        {
            SpeakString("'The inner machinations of Hoben's mind are an enigma.'");
        }
        else if(nRandom == 8)
        {
            SpeakString("'Hoben making dirt house!'");
        }
        else if(nRandom == 9)
        {
            SpeakString("'Hoben making dad stick hat!'");
        }
        else if(nRandom == 10)
        {
            SpeakString("'Scary gnomes speak to Hoben!'");
        }
    }
}
