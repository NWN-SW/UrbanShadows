//::///////////////////////////////////////////////
//:: Time Stop
//:: NW_S0_TimeStop.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons in the Area are frozen in time
    except the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

    /*
    //Declare major variables
    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime = EffectTimeStop();
    int nRoll = 1 + d4();

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    //Apply the VFX impact and effects
    DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, OBJECT_SELF, 6.0));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
    */
    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime;
    object oTarget;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    float fDuration = IntToFloat(nDuration);
    fDuration = fDuration / 3;
    int nTh;

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);

    eTime = EffectLinkEffects(EffectCutsceneParalyze(), EffectVisualEffect(VFX_DUR_BLUR));
    eTime = ExtraordinaryEffect(EffectLinkEffects(eTime, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION)));

    oTarget = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nTh);
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && !GetIsDM(oTarget))
        {
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, oTarget, fDuration));
        }
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));
        oTarget = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, ++nTh);
    }
}

