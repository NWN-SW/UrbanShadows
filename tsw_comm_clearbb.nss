void ClearBattleBrother(object oSelf)
{
    object oBattleBrother = GetLocalObject(oSelf, "BATTLE_BROTHER_CURRENT");
    if(oBattleBrother != OBJECT_INVALID)
    {
        //Remove existing battle bro buff
        effect eEffect = GetFirstEffect(oBattleBrother);
        while(GetIsEffectValid(eEffect))
        {
            if(GetEffectTag(eEffect) == "BATTLE_BROTHER_EFFECT")
            {
                RemoveEffect(oBattleBrother, eEffect);
                DeleteLocalInt(oBattleBrother, "BATTLE_BROTHER");
                DeleteLocalObject(oSelf, "BATTLE_BROTHER_CURRENT");
                break;
            }
            eEffect = GetNextEffect(oBattleBrother);
        }
    }
}
