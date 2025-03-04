int StartingConditional()
{
    if (!(GetLocalInt(OBJECT_SELF, "iRoundsLeft") == -1))
    {
     return TRUE;
    }

    return FALSE;
}
