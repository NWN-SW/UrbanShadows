#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

const int SPELL_VOLTAIC_CAGE = 880;

void RunImpact(object oTarget, object oCaster);

void main()
{
    object oTarget = GetSpellTargetObject();

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
    int nDuration = 6;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    //--------------------------------------------------------------------------
    // Setup VFX
    //--------------------------------------------------------------------------
    effect eVis      = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eDur      = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eArrow = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eParalyze = EffectParalyze();
    effect ePulse = EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE);
    effect eBeam = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF, BODY_NODE_CHEST);

    //Random variables
    int nFinalDamage;

    eDur = ExtraordinaryEffect(eDur);
     // * Dec 2003- added the reaction check back i
    if (GetIsReactionTypeFriendly(oTarget) == FALSE)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        float fDist = GetDistanceToObject(oTarget);
        float fDelay = (fDist/25.0);//(3.0 * log(fDist) + 2.0);

        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "Single";
            int nDamage = GetEighthLevelDamage(oTarget, nCasterLvl, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Elec";
            int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
        nFinalDamage = nFinalDamage / 3;

        effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);

        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, RoundsToSeconds(nDuration)));
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePulse, oTarget, RoundsToSeconds(nDuration)));
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, RoundsToSeconds(nDuration)));

        //Paralyze for duration
        float fDuration = GetExtendSpell(6.0);
        fDuration = GetFortDuration(oTarget, nReduction, fDuration);
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eParalyze ,oTarget , fDuration));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, fDuration));
        object oSelf = OBJECT_SELF; // because OBJECT_SELF is a function

        DelayCommand(6.0f, RunImpact(oTarget, oSelf));
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);

    //Class mechanics
    string sSpellType = "Electric";
    DoClassMechanic(sSpellType, "Single", nFinalDamage, oTarget);
}


void RunImpact(object oTarget, object oCaster)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(SPELL_VOLTAIC_CAGE, oTarget, oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        int nCasterLvl = GetCasterLevel(oCaster);
        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "Single";
            int nDamage = GetEighthLevelDamage(oTarget, nCasterLvl, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Elec";
            int nReduction = GetFocusReduction(oCaster, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
        nFinalDamage = nFinalDamage / 3;
        effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_ELECTRICAL);
        effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eVis,oTarget);
        DelayCommand(6.0f, RunImpact(oTarget, oCaster));
    }
}
