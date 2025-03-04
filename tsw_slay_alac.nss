//::///////////////////////////////////////////////
//:: Alacrity by Alxander G.
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
    effect eVisA = EffectVisualEffect(191);
    effect eVisB = EffectVisualEffect(192);
    effect eVisC = EffectVisualEffect(193);
    effect eImpact = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
    effect eAura = EffectVisualEffect(VFX_DUR_GHOST_SMOKE);
    effect eTime;
    float fSize = GetSpellArea(200.0);
    object oTarget;
    float fDuration = GetExtendSpell(12.0);
    int nTh;

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisA, OBJECT_SELF);
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisB, OBJECT_SELF));
    DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisC, OBJECT_SELF));
    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisC, OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, OBJECT_SELF, fDuration);

    eTime = EffectCutsceneParalyze();
    eTime = ExtraordinaryEffect(eTime);

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if(oTarget != OBJECT_SELF && !GetIsDM(oTarget))
        {
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, oTarget, fDuration));
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImpact, oTarget, fDuration));

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
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    DoMartialMechanic("Tactic", "AOE", 0, OBJECT_SELF);
}

