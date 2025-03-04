void main()
{
    // When attacking the jukebox, if no song is being played then do nothing
    int iGetRoundsLeft = GetLocalInt(OBJECT_SELF, "iRoundsLeft");

    if (iGetRoundsLeft == -1)
    {
        return;
    }
    // If a song is being played, skip it
    //... Unless you time it perfectly so that iRoundsLeft was at 0 when attacked, putting it back to 1
    else {
    SetLocalInt(OBJECT_SELF,"iRoundsLeft",0);

    }
}
