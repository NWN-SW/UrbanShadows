//::///////////////////////////////////////////////
//Theurgist Magic domain time stop by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

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

    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime;
    object oTarget;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    float fDuration = GetExtendSpell(12.0);
    float fSize = GetSpellArea(200.0);
    int nReduction = GetFocusReduction(OBJECT_SELF, "Magi");

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);

    eTime = EffectLinkEffects(EffectCutsceneParalyze(), EffectVisualEffect(VFX_DUR_BLUR));
    eTime = ExtraordinaryEffect(EffectLinkEffects(eTime, EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION)));

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && !GetIsDM(oTarget))
        {
            //float fFinalDuration = GetWillDuration(oTarget, nReduction, fDuration);
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, oTarget, fDuration));

            //Reset HP for players
            if(GetIsPC(oTarget))
            {
                int nCurrent = GetCurrentHitPoints(oTarget);
                DelayCommand(4.0, SetCurrentHitPoints(oTarget, nCurrent));
                DelayCommand(8.0, SetCurrentHitPoints(oTarget, nCurrent));
                DelayCommand(fDuration, SetCurrentHitPoints(oTarget, nCurrent));
            }
        }
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Control";
    DoClassMechanic(sSpellType, "AOE", 0, oTarget);
}

