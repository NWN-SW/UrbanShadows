#include "inc_timer"

void TouchToggle(object oPC)
{
    int nCheck = GetLocalInt(oPC, "TOUCH_TOGGLE");
    if(nCheck == 0)
    {
        if(GetTimerEnded("TOUCH_TOGGLE_TIMER", oPC))
        {
            effect nTouch = EffectCutsceneGhost();
            nTouch = SupernaturalEffect(nTouch);
            nTouch = TagEffect(nTouch, "TOUCH_TOGGLE");
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, nTouch, oPC);
            SendMessageToPC(oPC, "Your collision has been turned off.");
            SetLocalInt(oPC, "TOUCH_TOGGLE", 1);
            SetEventScript(oPC, EVENT_SCRIPT_CREATURE_ON_DAMAGED, "tsw_touch_combat");
            SetTimer("TOUCH_TOGGLE_TIMER", 10, oPC);
        }
        else
        {
            SendMessageToPC(oPC, "You must wait 10 seconds before enabling this option again.");
        }
    }
    else if(nCheck == 1)
    {
        //Remove existing touch effect
        effect eEffect = GetFirstEffect(oPC);
        while(GetIsEffectValid(eEffect))
        {
            if(GetEffectTag(eEffect) == "TOUCH_TOGGLE")
            {
                RemoveEffect(oPC, eEffect);
                DeleteLocalInt(oPC, "TOUCH_TOGGLE");
                SendMessageToPC(oPC, "Your collision has been turned on.");
                return;
            }
            eEffect = GetNextEffect(oPC);
        }
    }
}
