void main()
{
    if(GetTag(GetItemActivated()) == "DMKillWand")
    {
        effect eDeath = EffectDeath();
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetItemActivatedTarget());
    }
}
