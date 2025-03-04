void main()
{
    object oAttacker = GetLastSpellCaster();
    int nRep = GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oAttacker);
    effect eVis = EffectVisualEffect(VFX_IMP_HARM);
    effect eHeal = EffectHeal(500);
    if(!GetIsPC(oAttacker) && nRep >= 12)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oAttacker));
        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, OBJECT_SELF));
        DestroyObject(oAttacker);
    }
    ExecuteScript("j_ai_onspellcast");
}
