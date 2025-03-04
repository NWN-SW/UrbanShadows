void main()
{
    //Make sure the item being used is the summoning catalyst
    object oItem = GetItemActivated();

    if(GetTag(oItem) != "SummoningCatalyst")
    {
        return;
    }

    //Get the person using the object
    object oPC = GetItemActivator();
    //Get summon
    object oSum = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    //Get target or location
    object oTarget = GetItemActivatedTarget();
    location lLoc = GetItemActivatedTargetLocation();

    //If there is no target creature or object, move to location
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
        AssignCommand(oSum, ClearAllActions());
        AssignCommand(oSum, ActionMoveToLocation(lLoc, TRUE));
    }
    else
    {
        AssignCommand(oSum, ClearAllActions());
        AssignCommand(oSum, ActionAttack(oTarget));
    }
}
