/*
    Kill NPC on spawning in and leave a lootable corpse
*/

void main()
{
    object oSelf = OBJECT_SELF;
    // Set to Undestroyable, unraiseable, selectable, lootable
    SetIsDestroyable(FALSE, FALSE, TRUE);
    SetLootable(OBJECT_SELF,1);
    // Apply a death effect as so they die
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oSelf);
}

