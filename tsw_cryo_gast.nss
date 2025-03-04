//::///////////////////////////////////////////////
//:: Glacial Stride by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void RunImpact(object oTarget, object oCaster, int nHeal);

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


    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nHeal;
    float fDelay;
    int nTargetCheck;
    object oMainTarget;
    float fSize = GetSpellArea(10.0);
    float fDuration = GetExtendSpell(18.0);
    effect eExplode = EffectVisualEffect(VFX_IMP_PULSE_COLD); //USE THE ICESTORM FNF
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_COLD);
    effect eHeal;
    effect eParal = EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    effect eEntangle = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
    effect eSlow = EffectImmunity(IMMUNITY_TYPE_SLOW);
    effect eMove = EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_ICESKIN);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Link effects
    effect eLink = EffectLinkEffects(eParal, eEntangle);
    eLink = EffectLinkEffects(eLink, eSlow);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eMove);

    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Apply the ice storm VFX at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (!GetIsReactionTypeHostile(oTarget))
        {
            fDelay = GetRandomDelay(0.5, 1.0);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

            //Search for and remove the above negative effects
            effect eLook = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eLook))
            {
                if(GetEffectType(eLook) == EFFECT_TYPE_PARALYZE ||
                    GetEffectType(eLook) == EFFECT_TYPE_ENTANGLE ||
                    GetEffectType(eLook) == EFFECT_TYPE_SLOW ||
                    GetEffectType(eLook) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
                {
                    RemoveEffect(oTarget, eLook);
                }
                eLook = GetNextEffect(oTarget);
            }

            //Start Custom Spell-Function Block
                //Get damage
                string sTargets = "AOE";
                object oNothing;
                int nHeal = GetFifthLevelDamage(oNothing, 5, sTargets);
                nHeal = nHeal / 5;

                //Buff damage by Amplification elvel
                nHeal = GetAmp(nHeal);

                //Get the Alchemite resistance reduction
                string sElement = "Cold";
                int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

                //Buff damage bonus on Alchemite
                nHeal = GetFocusDmg(OBJECT_SELF, nHeal, sElement);
            //End Custom Spell-Function Block

            //Store main target and set check
            if(nTargetCheck == 0)
            {
                oMainTarget = oTarget;
                nTargetCheck = 1;
            }

            //Set the damage effect
            eHeal = EffectHeal(nHeal);
            // Apply effects to the currently selected target.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the impact that erupts on the target not on the ground.
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, fDuration));

            //Call HoT effect
            object oSelf = OBJECT_SELF;
            DelayCommand(6.0f, RunImpact(oTarget, oSelf, nHeal));
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, "AOE", nHeal, oMainTarget);
}

void RunImpact(object oTarget, object oCaster, int nHeal)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(GetSpellId(),oTarget,oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        effect eHeal = EffectHeal(nHeal);
        effect eVis = EffectVisualEffect(VFX_IMP_HEALING_L);
        eHeal = EffectLinkEffects(eVis, eHeal);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eHeal, oTarget);
        DelayCommand(6.0f,RunImpact(oTarget, oCaster, nHeal));
    }
}

