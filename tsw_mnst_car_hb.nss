void main()
{
    int iIntNoExploit = GetLocalInt(GetArea(OBJECT_SELF),"iIntNoExploit");

    if (iIntNoExploit > 0)
    {
        SetLocalInt(GetArea(OBJECT_SELF), "iIntNoExploit", iIntNoExploit-1);
    }

}
