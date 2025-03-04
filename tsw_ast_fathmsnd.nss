void main()
{
    int nHP = GetCurrentHitPoints(OBJECT_SELF);
    int nMax = GetMaxHitPoints(OBJECT_SELF);
    int nCheck = nMax / 4;
    nMax = nMax - nCheck;
    int nRandom = Random(3);
    if(nHP < nMax)
    {
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DAMAGED, "x2_def_ondamage");
        switch(nRandom)
        {
            case 0:
                PlaySound("cthulhu_1");
                return;
            case 1:
                PlaySound("cthulhu_2");
                return;
            case 2:
                PlaySound("cthulhu_3");
                return;
        }
    }
}
