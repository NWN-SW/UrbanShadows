int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "iLoopTrack") ==1)
    {
        return TRUE;
    }
    return FALSE;
}
