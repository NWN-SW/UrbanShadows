//::///////////////////////////////////////////////
//:: Continual Flame
//:: x0_s0_clight.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 Permanent Light spell

    XP2
    If cast on an item, item will get permanently
    get the property "light".
    Previously existing permanent light properties
    will be removed!

*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: July 18, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:
//:: Added XP2 cast on item code: Georg Z, 2003-06-05
//:://////////////////////////////////////////////

//#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run
    // this spell.
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDuration;
    int nMetaMagic;

    object oTarget = GetSpellTargetObject();

    //Declare major variables
    effect eVis = (EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20));
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = ExtraordinaryEffect(EffectLinkEffects(eVis, eDur));

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 419, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
}



