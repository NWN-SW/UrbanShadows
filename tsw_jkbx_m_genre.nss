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

void main()
{

    string sMGetMusicGenre= GetScriptParam("sSetMusicGenre");
    SetLocalString(OBJECT_SELF,"sSetMusicGenre", sMGetMusicGenre);
    int iMGetMusicGenre = StringToInt(sMGetMusicGenre);
    switch(iMGetMusicGenre){
       default:
       break;

       case 1:
           // 55 tracks starting at ID 520 in ambientmusic.2da for the Rock Genre. Includes Rock, punk, metal.
           SetLocalInt(OBJECT_SELF, "iPlayLength",55);
           SetLocalInt(OBJECT_SELF, "iPlayStartID",520);
           break;

           case 11:
               // 25 tracks starting at ID 520 in ambientmusic.2da for the 80's/classic Rock subgenre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",25);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",520);
               break;

           case 12:
               // 18 tracks starting at ID 545 in ambientmusic.2da for the Punk-rock subgenre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",18);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",545);
               break;

           case 13:
               // 12 tracks starting at ID 512 in ambientmusic.2da for the Metal sub-genre.
               // Includes four amateur tracks taken off of Raccmaniacc's previous heavy metal band.
               // I'm not telling you which one, you'll figure out.
               // Don't set your expectations too high!
               SetLocalInt(OBJECT_SELF, "iPlayLength",12);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",563);
               break;

       case 2:
           // 19 tracks starting at ID 592 in ambientmusic.2da for the Hip-hop genre. Includes RnB, hip-hop.
           SetLocalInt(OBJECT_SELF, "iPlayLength",19);
           SetLocalInt(OBJECT_SELF, "iPlayStartID",592);
           break;

           case 21:
               // 9 tracks starting at ID 592 in ambientmusic.2da for the Hip-hop genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",9);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",592);
               break;

           case 22:
               // 10 tracks starting at ID 601 in ambientmusic.2da for the RNB genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",10);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",601);
               break;

       case 3:
           // 97 tracks starting at ID 423 in ambientmusic.2da for the pop genre. Includes 80s,90s,00s,10s pop.
           SetLocalInt(OBJECT_SELF, "iPlayLength",97);
           SetLocalInt(OBJECT_SELF, "iPlayStartID",423);
           break;

           case 31:
               // 10 tracks starting at ID 475 in ambientmusic.2da for the 80's pop genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",10);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",475);
               break;

           case 32:
               // 24 tracks starting at ID 485 in ambientmusic.2da for the 90's/2000's pop genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",24);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",485);
               break;

           case 33:
               // 27 tracks starting at ID 423 in ambientmusic.2da for the 2010's pop genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",27);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",423);
               break;

           case 34:
               // 25 tracks starting at ID 450 in ambientmusic.2da for the 2020's pop genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",25);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",450);
               break;

           case 35:
               // 11 tracks starting at ID 509 in ambientmusic.2da for the chill pop subgenre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",11);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",509);
               break;

       case 4:
           // 29 tracks starting at ID 394 a for the Country genre. Includes old school and modern.
           SetLocalInt(OBJECT_SELF, "iPlayLength",29);
           SetLocalInt(OBJECT_SELF, "iPlayStartID",394);
           break;

           case 41:
               // 14 tracks starting at ID 409 a for the Traditional Country genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",14);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",409);
               break;

           case 42:
               // 29 tracks starting at ID 394 a for the Modern Country genre.
               SetLocalInt(OBJECT_SELF, "iPlayLength",15);
               SetLocalInt(OBJECT_SELF, "iPlayStartID",394);
               break;

       case 5:
           // 10 tracks starting at ID 582 in ambientmusic.2da for the Electro genre.
           SetLocalInt(OBJECT_SELF, "iPlayLength",10);
           SetLocalInt(OBJECT_SELF, "iPlayStartID",582);
           break;
       case 6:
            // 7 tracks starting at ID 575 in ambientmusic.2da for the Irish genre.
           SetLocalInt(OBJECT_SELF, "iPlayLength",7);
           SetLocalInt(OBJECT_SELF, "iPlayStartID",575);

           break;
       case 7:
           // 8 tracks starting at ID 386 in ambientmusic.2da for the Christmas genre.
           SetLocalInt(OBJECT_SELF, "iPlayLength",8);
           SetLocalInt(OBJECT_SELF, "iPlayStartID",386);
           break;
        }

    int iMRndTrack = Random(GetLocalInt(OBJECT_SELF,"iPlayLength")) + GetLocalInt(OBJECT_SELF,"iPlayStartID");
    string sMGetTrackRounds = Get2DAString("musicround","Round",iMRndTrack);

    SetLocalString(OBJECT_SELF,"sPlayList", IntToString(iMRndTrack));
    SetLocalInt(OBJECT_SELF,"iLoopTrack",0);

    MusicBackgroundChangeDay(GetArea(OBJECT_SELF), iMRndTrack);
    MusicBackgroundChangeNight(GetArea(OBJECT_SELF), iMRndTrack);
    MusicBackgroundPlay(GetArea(OBJECT_SELF));
    MusicBackgroundSetDelay(GetArea(OBJECT_SELF),18000);

    SetLocalInt(OBJECT_SELF, "iRoundsLeft", (StringToInt(sMGetTrackRounds)));

    MsgAllInArea("Track N°"+IntToString(iMRndTrack)+": "+Get2DAString("ambientmusic","DisplayName",iMRndTrack));

}
