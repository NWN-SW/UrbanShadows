void main()
{
    object oMaster = GetMaster();
    if (GetIsObjectValid(oMaster))
    {
        int nCheck = GetLocalInt(oMaster, "HAS_CATALYST");
        if(nCheck == 1)
        {
            return;
        }
        object oCatalyst = GetFirstItemInInventory(oMaster);
        string sTag = GetTag(oCatalyst);
        int nHasalyst;
        while(oCatalyst != OBJECT_INVALID)
        {
            if(sTag == "SummoningCatalyst")
            {
                nHasalyst = 1;
                SetLocalInt(oMaster, "HAS_CATALYST", 1);
                break;
            }
            oCatalyst = GetNextItemInInventory(oMaster);
            sTag = GetTag(oCatalyst);
        }

        int nAmount = GetMaxHitPoints(oMaster) / 15;
        int nEpicCheck = GetLocalInt(OBJECT_SELF, "EPICSUMMON");
        nAmount = nAmount + nEpicCheck;
        effect eDamage = EffectDamage(nAmount, DAMAGE_TYPE_MAGICAL);
        effect eVis = EffectVisualEffect(645);

        if(nHasalyst != 1)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMaster);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oMaster);
        }
    }
}
