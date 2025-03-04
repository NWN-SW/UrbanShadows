//////////////////////////////////////////////////
//Totem of Fury onEnter
///////////////////////////////////////////////////


void main()
{
    //Declare major variables
    object oPC = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    if(GetIsReactionTypeHostile(oTarget, oPC))
    {
        return;
    }
    int nAmount = 2;

    effect eVis = EffectVisualEffect(1076);
    effect eAC = EffectACIncrease(nAmount);
    effect eDam = EffectDamageIncrease(nAmount);
    effect eAtk = EffectAttackIncrease(nAmount);

    effect eLink = EffectLinkEffects(eAC, eDam);
    eLink = EffectLinkEffects(eLink, eAtk);

    //Make the effect supernatural
    eLink = SupernaturalEffect(eLink);
    //Add a tag to the effect for removal later
    eLink = TagEffect(eLink, "SHAMAN_FURY_TOTEM");

    //Get Stack
    int nStack = GetLocalInt(oTarget, "SHAMAN_FURY_STACK");

    if(GetIsObjectValid(oTarget))
    {
        if(nStack == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(60));
        }
        nStack = nStack + 1;
        SetLocalInt(oTarget, "SHAMAN_FURY_STACK", nStack);
    }
}

