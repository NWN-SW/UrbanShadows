//////////////////////////////////////////////////
//Commander Resist aura onEnter
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
    int nAmount = 10 + GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    int nBattleBrother = GetLocalInt(oTarget, "BATTLE_BROTHER");
    if(nBattleBrother == 1)
    {
        nAmount = nAmount + (nAmount / 2);
    }
    effect eVis = EffectVisualEffect(VFX_IMP_PDK_RALLYING_CRY);
    effect eFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, nAmount);
    effect eCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, nAmount);
    effect eElec = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, nAmount);
    effect eAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, nAmount);
    effect eNega = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nAmount);
    effect eMagi = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, nAmount);
    effect eSoni = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, nAmount);
    //effect ePosi = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, nAmount);
    effect eDivi = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, nAmount);

    effect eLink = EffectLinkEffects(eFire, eCold);
    eLink = EffectLinkEffects(eLink, eElec);
    eLink = EffectLinkEffects(eLink, eAcid);
    eLink = EffectLinkEffects(eLink, eNega);
    eLink = EffectLinkEffects(eLink, eMagi);
    eLink = EffectLinkEffects(eLink, eSoni);
    //eLink = EffectLinkEffects(eLink, ePosi);
    eLink = EffectLinkEffects(eLink, eDivi);

    //Make the effect supernatural
    eLink = SupernaturalEffect(eLink);
    //Add a tag to the effect for removal later
    eLink = TagEffect(eLink, "Commander_Resist_Effect");

    //Get Stack
    int nStack = GetLocalInt(oTarget, "COMMANDER_RESIST_STACK");

    if(GetIsObjectValid(oTarget))
    {
        if(nStack == 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(60));
        }
        nStack = nStack + 1;
        SetLocalInt(oTarget, "COMMANDER_RESIST_STACK", nStack);
    }
    //Break stealth
    if(GetStealthMode(GetAreaOfEffectCreator()) == 1)
    {
        SetActionMode(GetAreaOfEffectCreator(), ACTION_MODE_STEALTH, FALSE);
    }
}

