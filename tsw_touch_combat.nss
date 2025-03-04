void main()
{
    //Remove existing touch effect
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectTag(eEffect) == "TOUCH_TOGGLE")
        {
            RemoveEffect(OBJECT_SELF, eEffect);
            DeleteLocalInt(OBJECT_SELF, "TOUCH_TOGGLE");
            SendMessageToPC(OBJECT_SELF, "Your collision has been turned on.");
            SetEventScript(OBJECT_SELF, EVENT_SCRIPT_CREATURE_ON_DAMAGED, "");
            return;
        }
        eEffect = GetNextEffect(OBJECT_SELF);
    }
}
