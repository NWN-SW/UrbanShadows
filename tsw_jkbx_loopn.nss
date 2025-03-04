int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "iLoopTrack") ==0)
    {
        return TRUE;
    }
    return FALSE;
}
