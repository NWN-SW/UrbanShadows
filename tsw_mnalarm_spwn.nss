void main()
{
    int iIntNoExploit = GetLocalInt(GetArea(OBJECT_SELF),"iIntNoExploit");

    if ( iIntNoExploit == 0)
    {
        location lWP1 = GetLocation(GetObjectByTag("MN_AlarmSpawn_1"));
        location lWP2 = GetLocation(GetObjectByTag("MN_AlarmSpawn_2"));
        location lWP3 = GetLocation(GetObjectByTag("MN_AlarmSpawn_3"));
        location lWP4 = GetLocation(GetObjectByTag("MN_AlarmSpawn_4"));
        CreateObject(1, "hive_t3a", lWP1);
        CreateObject(1, "hive_t3a", lWP1);

        CreateObject(1, "hive_t3", lWP2);
        CreateObject(1, "hive_t3", lWP2);

        CreateObject(1, "hive_t1a", lWP3);
        CreateObject(1, "hive_t1a", lWP3);

        CreateObject(1, "hive_t4", lWP4);
        CreateObject(1, "hive_t4", lWP4);

        SetLocalInt(GetArea(OBJECT_SELF),"iIntNoExploit",4);
    }

}
