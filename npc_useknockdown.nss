void main()
{
    if(GetCurrentAction(OBJECT_SELF) == ACTION_ATTACKOBJECT)
    {
        ActionUseFeat(FEAT_IMPROVED_KNOCKDOWN, GetAttackTarget());
    }
}
