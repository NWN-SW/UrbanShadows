void main()
{
    int nCheck = GetLocalInt(OBJECT_SELF, "I_AM_DONE");
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    if(nCheck != 1)
    {
        AssignCommand(OBJECT_SELF, DelayCommand(2.0, PlaySound("found_thing_3")));
        DelayCommand(3.0, SpeakString("...[The radio turns on, a single snatch of staticy music jolting you upright.]..."));
        DelayCommand(6.0, SpeakString("Music plays, 'Wake up, you sleepyhead. Rub your eyes, get out of bed.'"));
        DelayCommand(9.0, SpeakString("...[The channel flips, then comes to rest on the voice of a news anchor before jumping to other voices in rapid succession].."));
        DelayCommand(15.0, SpeakString("'It's been three days--'"));
        DelayCommand(17.0, SpeakString("'--And now you have to--'"));
        DelayCommand(19.0, SpeakString("'--Wake up! With Monster--'"));
        DelayCommand(21.0, SpeakString("'--Clawing at--'"));
        DelayCommand(23.0, SpeakString("'--Your door. If you want--'"));
        DelayCommand(25.0, SpeakString("'--To live, there is only--'"));
        DelayCommand(27.0, SpeakString("The radio tunes to a song, '--run, running all the time, running for the future--'"));
        DelayCommand(32.0, SpeakString("...[The radio falls silent in the middle of Gwen Stefani's plea]..."));
        DelayCommand(35.0, SpeakString("...[Suddenly a voice thrums inside of you. You don't so much hear it as feel it.]..."));
        DelayCommand(40.0, SpeakString("TRANSMIT - initiate anima signal - RECEIVE - initiate the Enochian frequency - WITNESS - initiate the Merovingian syntax"));
        DelayCommand(44.0, SpeakString("FIAP DE OIAD - crawling roots, heavy with sizzling sap, stab your skull - DOWNLOAD - holy communion - NO PURCHASE NECESSARY - your eyes and ears hemorrhage boiling joy"));
        DelayCommand(48.0, SpeakString("MAY BE TOO INTENSE FOR SOME VIEWERS - ecstatic agony, your molecules come undone - SOME ASSEMBLY REQUIRED - offer expires at the heat death of the universe"));
        DelayCommand(52.0, SpeakString("FOR A LIMITED TIME ONLY - the dark days cometh, absolute zero, maximum entropy - ACT NOW! - initiate Agartha broadcast - TRANSMIT - open the 49 gates! - WITNESS! - The Buzzing."));
        DelayCommand(60.0, SpeakString("...[You're left gasping, confused. What was that?! By the sound of it all though, it's time to go.]..."));
        SetLocalInt(OBJECT_SELF, "I_AM_DONE", 1);
    }
}
