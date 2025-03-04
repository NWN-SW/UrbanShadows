//::///////////////////////////////////////////////
//:: Aspect of the Forest by Alexander G.
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void RunImpact(object oTarget, object oCaster, int nDamage);

void main()
{
    object oTarget = GetSpellTargetObject();
    int nFinalDamage;

    //--------------------------------------------------------------------------
    // Spellcast Hook Code
    // Added 2003-06-20 by Georg
    // If you want to make changes to all spells, check x2_inc_spellhook.nss to
    // find out more
    //--------------------------------------------------------------------------
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one of that type, thats ok
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }

    //--------------------------------------------------------------------------
    // Calculate the duration
    //--------------------------------------------------------------------------
    int nDuration = 5;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    float fDuration = GetExtendSpell(RoundsToSeconds(nDuration));


    //--------------------------------------------------------------------------
    // Setup VFX
    //--------------------------------------------------------------------------
    effect eVis      = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eVis2     = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eVis3     = EffectVisualEffect(1063);
    effect eDur      = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    eDur = ExtraordinaryEffect(eDur);
     // * Dec 2003- added the reaction check back i
    if(!GetIsReactionTypeHostile(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "Single";
            object oNothing;
            int nDamage = GetSeventhLevelDamage(oNothing, nCasterLvl, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Holy";
            int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);

            //Adjust damage based on Alchemite and Saving Throw
            nFinalDamage = nDamage / 5;
        //End Custom Spell-Function Block
        effect eHeal = EffectHeal(nFinalDamage);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);

        //----------------------------------------------------------------------
        // Apply the VFX that is used to track the spells duration
        //----------------------------------------------------------------------
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis3, oTarget, fDuration);
        object oSelf = OBJECT_SELF; // because OBJECT_SELF is a function
        DelayCommand(6.0f, RunImpact(oTarget, oSelf, nFinalDamage));
    }

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, "Single", nFinalDamage, oTarget);

}


void RunImpact(object oTarget, object oCaster, int nDamage)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(GetSpellId(), oTarget, oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        effect eHeal = EffectHeal(nDamage);
        effect eVis = EffectVisualEffect(966);
        effect eVis2 = EffectVisualEffect(911);
        eHeal = EffectLinkEffects(eVis, eHeal);
        eHeal = EffectLinkEffects(eHeal, eVis2);
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eHeal, oTarget);
        DelayCommand(6.0f,RunImpact(oTarget, oCaster, nDamage));
    }
}

