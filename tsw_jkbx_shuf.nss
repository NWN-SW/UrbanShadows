//Tiny function to message all players in the same Areas as whatever object calls it.
//Here it messages all people that are in the jukebox's area
void MsgAllInArea (string psMsgToAllInArea) {

    object oPC = GetFirstPC();
    object oHere = GetArea(OBJECT_SELF);

    while (oPC != OBJECT_INVALID) {
    if ( GetArea(oPC) == oHere )
    {
        SendMessageToPC(oPC, psMsgToAllInArea);
    }

        oPC = GetNextPC();
    }
}


//Very similar to MsgAllInArea
//If nobody is in the same area as the Jukebox, shut it down.
void CheckPCsInArea () {

    object oPC = GetFirstPC();
    object oHere = GetArea(OBJECT_SELF);

    while (oPC != OBJECT_INVALID) {
    if ( GetArea(oPC) == oHere )
    {
        return;
    }

        oPC = GetNextPC();
    }

    SetLocalInt(OBJECT_SELF, "iRoundsLeft", -1);
    MusicBackgroundStop(GetArea(OBJECT_SELF));

}


void main()
{

    // Check how many rounds(6seconds) are left for the current song. If it's -1, means the Jukebox is not working
    int iMRoundsLeft = GetLocalInt(OBJECT_SELF,"iRoundsLeft");

    // Immediatly exit, -1 means the jukebox is not in use. No need to check
    if ( iMRoundsLeft == -1)
    {

        return;
    }

   // If it's 0, the song should have ended. We do a bunch of stuff such as :
   if ( iMRoundsLeft == 0)
   {

        // Find a new track to play with a bit of Random, get the result both as Integers and as a String
        int iMRndTrack = Random(GetLocalInt(OBJECT_SELF,"iPlayLength")) + GetLocalInt(OBJECT_SELF,"iPlayStartID");
        int iMNoChanges = 0;
        string sMRndTrack = IntToString(iMRndTrack);

        // As long as this new track ID is already part of the songs that have already been played, try to random a new one.
        while ( FindSubString( GetLocalString(OBJECT_SELF,"sPlayList"), sMRndTrack, 0) != -1)
        {
            iMNoChanges +=1;
            iMRndTrack = Random(GetLocalInt(OBJECT_SELF,"iPlayLength")) + GetLocalInt(OBJECT_SELF,"iPlayStartID");
            sMRndTrack = IntToString(iMRndTrack);

            // If after x(the total length of the playlist) attempts at a new random songs fail, shut the thing down.
            if (iMNoChanges >=  GetLocalInt(OBJECT_SELF,"iPlayLength"))
            {
              SetLocalInt(OBJECT_SELF, "iRoundsLeft", -1);
              MusicBackgroundStop(GetArea(OBJECT_SELF));
              return;
            }
        }


        //If we manage to get a song that has not been played already, reset the counter reaching x to 0(see comment just above)
        //And get the duration in rounds if the new song
        string sMGetTrackRounds = Get2DAString("musicround","Round",iMRndTrack);

        // Add the song to the list of already played tracks.
        SetLocalString(OBJECT_SELF,"sPlayList", GetLocalString(OBJECT_SELF,"sPlayList")+","+IntToString(iMRndTrack));
        // Change the track for day and night to the new, randomly selected song,
        // prevent if from looping (hopefully?) if it ends before the counter of rounds left (see ELSE IF below) reaches 0
        MusicBackgroundChangeDay(GetArea(OBJECT_SELF), iMRndTrack);
        MusicBackgroundChangeNight(GetArea(OBJECT_SELF), iMRndTrack);
        MusicBackgroundPlay(GetArea(OBJECT_SELF));
        MusicBackgroundSetDelay(GetArea(OBJECT_SELF),18000);

        SetLocalInt(OBJECT_SELF, "iRoundsLeft", (StringToInt(sMGetTrackRounds)));

        // Advertise the song played with its id and name from the 2da to all players in the area
        MsgAllInArea("Track n°"+sMRndTrack+": "+ Get2DAString("ambientmusic","DisplayName",iMRndTrack));
       }

    // If the counter of rounds remaining before the end of the song is not yet 0, meaning the song should have ended,
    // Decrease counter by one. Easy right?

    else if ( iMRoundsLeft > 0)

    {
         if (GetLocalInt(OBJECT_SELF, "iLoopTrack") == 0 )
         {
         SetLocalInt(OBJECT_SELF, "iRoundsLeft", iMRoundsLeft-1);
         }
         //MsgAllInArea(IntToString(GetLocalInt(OBJECT_SELF,"iRoundsLeft")));
        if (iMRoundsLeft == 10)
        {

           CheckPCsInArea();

        }

    }
}



