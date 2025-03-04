void main()
{
    int nRandom = Random(20) + 16778096;
    ClearAllActions();
    PlaySoundByStrRef(nRandom, FALSE);
    SpeakString("((" + GetName(OBJECT_SELF) + " played a gnome insult.))");
}
