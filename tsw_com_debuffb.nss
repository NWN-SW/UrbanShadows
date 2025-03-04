//////////////////////////////////////////////////
//Commander debuff aura onExit
///////////////////////////////////////////////////


void main()
{
    //Declare major variables
    object oTarget = GetExitingObject();

    if(!GetIsReactionTypeHostile(oTarget, GetAreaOfEffectCreator()))
    {
        return;
    }

    //Remove stacks
    int nStack = GetLocalInt(oTarget, "COMMANDER_DEBUFF_STACK");
    nStack = nStack - 1;
    SetLocalInt(oTarget, "COMMANDER_DEBUFF_STACK", nStack);

    int nBrotherStack = GetLocalInt(oTarget, "COMMANDER_DEBUFF_BROTHER");
    nBrotherStack = nBrotherStack - 1;
    SetLocalInt(oTarget, "COMMANDER_DEBUFF_BROTHER", nBrotherStack);

    //Remove all existing aura effects
    effect eEffect = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eEffect))
    {
        if((GetEffectTag(eEffect) == "Commander_Debuff_Effect" || GetEffectTag(eEffect) == "Commander_Debuff_Brother") && nStack <= 0)
        {
            RemoveEffect(oTarget, eEffect);
        }
        eEffect = GetNextEffect(oTarget);
    }
}

