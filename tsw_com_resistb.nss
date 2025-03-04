//////////////////////////////////////////////////
//Commander Resist aura onExit
///////////////////////////////////////////////////


void main()
{
    //Declare major variables
    object oTarget = GetExitingObject();

    //Remove all existing aura effects
    effect eEffect = GetFirstEffect(oTarget);

    //Remove stacks
    int nStack = GetLocalInt(oTarget, "COMMANDER_RESIST_STACK");
    nStack = nStack - 1;
    SetLocalInt(oTarget, "COMMANDER_RESIST_STACK", nStack);

    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectTag(eEffect) == "Commander_Resist_Effect" && nStack <= 0)
        {
            RemoveEffect(oTarget, eEffect);
        }
        eEffect = GetNextEffect(oTarget);
    }
}

