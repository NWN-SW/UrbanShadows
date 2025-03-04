// This script will make the receiver of a "NW_ATTACK_MY_TARGET" shout come and
// investigate, even if he doesn't see an enemy. Once he approaches the shouter,
// if he sees an enemy his OnPerception script will activate and he will attack.
// An interesting modification to this script would be to have the out-of-sight
// receiver of the shout issue a second shout which would carry the original shout
// further... this would, however, require a new shout and new pattern definition.
void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == 1004) // OnDialog event
    {
        // This sees if the shout matches the pattern set by the
        // "SetListeningPatterns" in OnSpawn
        int nMatch = GetListenPatternNumber();
        object oShouter = GetLastSpeaker();
        object oIntruder;

        // If I recognize the shout and the shouter is a valid, friendly NPC
        if(nMatch != -1 && GetIsObjectValid(oShouter) && !GetIsPC(oShouter) && GetIsFriend(oShouter))
        {
            // And the shout is "NW_ATTACK_MY_TARGET"
            if (nMatch == 5)
            {
                // Attempt to define the shouter's enemy
                oIntruder = GetLastHostileActor(oShouter);

                if (!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetAttemptedAttackTarget();

                    if (!GetIsObjectValid(oIntruder))
                    {
                        oIntruder = GetAttemptedSpellTarget();

                        if(!GetIsObjectValid(oIntruder))
                        {
                            oIntruder = OBJECT_INVALID;
                        }
                    }
                }

                // If I can see neither the shouter nor the enemy
                if (GetIsObjectValid(oShouter) && !GetObjectSeen(oIntruder) && !GetObjectSeen(oShouter))
                {

                    if(!GetIsInCombat())
                    {
                        // Define the location of the shouter
                        location lShouter = GetLocation(oShouter);

                        // ...stop what I am doing
                        ClearAllActions();

                        // ...and move to that location
                        ActionMoveToLocation (lShouter, TRUE);
                    }
                }

                // Otherwise, if I can see the shouter but not the enemy
                else if (GetIsObjectValid(oShouter) && !GetObjectSeen(oIntruder) && GetObjectSeen(oShouter))
                {

                    if(!GetIsInCombat())
                    {
                        // Stop what I am doing
                        ClearAllActions();

                        // ...and move towards the shouter
                        ActionMoveToObject(oShouter, TRUE);
                    }
                }
            }
        }
    }
}
