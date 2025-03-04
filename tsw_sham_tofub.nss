//////////////////////////////////////////////////
//Totem of Fury onExit
///////////////////////////////////////////////////


void main()
{
    //Declare major variables
    object oTarget = GetExitingObject();

    //Remove all existing aura effects
    effect eEffect = GetFirstEffect(oTarget);

    //Remove stacks
    int nStack = GetLocalInt(oTarget, "SHAMAN_FURY_STACK");
    nStack = nStack - 1;
    SetLocalInt(oTarget, "SHAMAN_FURY_STACK", nStack);

    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectTag(eEffect) == "SHAMAN_FURY_TOTEM" && nStack <= 0)
        {
            RemoveEffect(oTarget, eEffect);
        }
        eEffect = GetNextEffect(oTarget);
    }
}

