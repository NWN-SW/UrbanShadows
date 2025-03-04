//////////////////////////////////////////////////
//Totem of Dread onEnter
///////////////////////////////////////////////////


void main()
{
    //Declare major variables
    object oPC = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();
    if(!GetIsReactionTypeHostile(oTarget, oPC))
    {
        return;
    }
    int nAmount = 2;

    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eAC = EffectACDecrease(nAmount);
    effect eDam = EffectDamageDecrease(nAmount);
    effect eAtk = EffectAttackDecrease(nAmount);
    effect eSlow = EffectMovementSpeedDecrease(75);

    effect eLink = EffectLinkEffects(eAC, eDam);
    eLink = EffectLinkEffects(eLink, eAtk);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eSlow);

    //Make the effect supernatural
    eLink = SupernaturalEffect(eLink);
    //Add a tag to the effect for removal later
    eLink = TagEffect(eLink, "SHAMAN_DREAD_TOTEM");

    //Get Stack
    int nStack = GetLocalInt(oTarget, "SHAMAN_DREAD_STACK");

    if(GetIsObjectValid(oTarget))
    {
        if(nStack == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(60));
        }
        nStack = nStack + 1;
        SetLocalInt(oTarget, "SHAMAN_DREAD_STACK", nStack);
    }
}

