//////////////////////////////////////////////////
//Commander slow aura onExit
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
    int nStack = GetLocalInt(oTarget, "COMMANDER_SLOW_STACK");
    nStack = nStack - 1;
    SetLocalInt(oTarget, "COMMANDER_SLOW_STACK", nStack);

    int nBrotherStack = GetLocalInt(oTarget, "COMMANDER_SLOW_BROTHER");
    nBrotherStack = nBrotherStack - 1;
    SetLocalInt(oTarget, "COMMANDER_SLOW_BROTHER", nBrotherStack);

    //Remove all existing aura effects
    effect eEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eEffect))
    {
        if((GetEffectTag(eEffect) == "Commander_Slow_Effect" || GetEffectTag(eEffect) == "Commander_Slow_Brother") && nStack <= 0)
        {
            RemoveEffect(oTarget, eEffect);
        }
        eEffect = GetNextEffect(oTarget);
    }
}

