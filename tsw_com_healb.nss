//////////////////////////////////////////////////
//Commander Heal Aura enter effect
///////////////////////////////////////////////////


void main()
{
    //Declare major variables
    effect eVis = EffectVisualEffect(1081);

    //Get the entering object
    object oTarget = GetEnteringObject();
    if(GetIsObjectValid(oTarget) && !GetIsReactionTypeHostile(oTarget, GetAreaOfEffectCreator()))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}

