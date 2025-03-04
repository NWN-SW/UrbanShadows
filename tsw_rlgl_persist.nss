void main()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 500.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsPC(oTarget))
        {
            ActionAttack(oTarget);
            break;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 500.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    }
    ExecuteScript("j_ai_onheartbeat", OBJECT_SELF);
}
