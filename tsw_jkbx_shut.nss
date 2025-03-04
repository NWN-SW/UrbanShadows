void main()
{

    SetLocalInt(OBJECT_SELF,"iRoundsLeft", -1);
    SetLocalString(OBJECT_SELF,"sSetMusicGenre", "");
    SetLocalString(OBJECT_SELF,"sPlayList", "");
    MusicBackgroundChangeDay(GetArea(OBJECT_SELF),999);
    MusicBackgroundChangeNight(GetArea(OBJECT_SELF),999);
    MusicBackgroundStop(GetArea(OBJECT_SELF));
}
