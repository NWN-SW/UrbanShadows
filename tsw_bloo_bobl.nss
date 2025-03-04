//::///////////////////////////////////////////////
//:: Boil Blood by Alexander G.
//::///////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void RunImpact(object oTarget, object oCaster, int nDamage);

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
    float fDuration = 18.0;
    fDuration = GetExtendSpell(fDuration);

    //--------------------------------------------------------------------------
    // Beam VFX
    //--------------------------------------------------------------------------
    effect eRay = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
    effect eDur = EffectVisualEffect(530);
    effect eVisMain = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);

    //----------------------------------------------------------------------
    // Apply death effect
    //----------------------------------------------------------------------
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRay, oTarget);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetSixthLevelDamage(oTarget, 0, sTargets);
        if(GetCurrentAction(oTarget) == ACTION_MOVETOPOINT)
        {
            nDamage = nDamage + (nDamage / 5);
        }

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Nega";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    //Adjust damage based on Alchemite and Saving Throw
    int nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);
    nFinalDamage = nFinalDamage / 2;

    effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_PIERCING);

    //----------------------------------------------------------------------
    // Apply the VFX that is used to track the spells duration
    //----------------------------------------------------------------------
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisMain, oTarget));
    //DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    object oSelf = OBJECT_SELF; // because OBJECT_SELF is a function
    DelayCommand(fDelay+0.1f, RunImpact(oTarget, oSelf, nFinalDamage));

    //Class mechanics
    DoClassMechanic("Occult", sTargets, nFinalDamage, oTarget);
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
        int nCasterLvl = GetCasterLevel(oCaster);

        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING);

        effect eVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
        eDam = EffectLinkEffects(eVis, eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDam, oTarget);
        DelayCommand(6.0f, RunImpact(oTarget, oCaster, nDamage));
    }
}

