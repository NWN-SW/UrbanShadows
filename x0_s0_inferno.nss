//::///////////////////////////////////////////////
//:: Inferno by Alexander G.
//::///////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void RunImpact(object oTarget, object oCaster);

void main()
{
    object oTarget = GetSpellTargetObject();

    if(!GetIsReactionTypeHostile(oTarget))
    {
        return;
    }

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
    if (GetHasSpellEffect(GetSpellId(),oTarget) || GetHasSpellEffect(SPELL_COMBUST,oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }

    //--------------------------------------------------------------------------
    // Calculate the duration
    //--------------------------------------------------------------------------
    float fDuration = RoundsToSeconds(3);
    fDuration = GetExtendSpell(fDuration);

    //--------------------------------------------------------------------------
    // Flamethrower VFX
    //--------------------------------------------------------------------------
    effect eRay = EffectBeam(444,OBJECT_SELF,BODY_NODE_CHEST);
    effect eDur = EffectVisualEffect(498);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

    float fDelay = GetDistanceBetween(oTarget, OBJECT_SELF)/13;

    //----------------------------------------------------------------------
    // Engulf the target in flame
    //----------------------------------------------------------------------
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 3.0f);


    //----------------------------------------------------------------------
    // Apply the VFX that is used to track the spells duration
    //----------------------------------------------------------------------
    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration));
    object oSelf = OBJECT_SELF; // because OBJECT_SELF is a function
    DelayCommand(fDelay+0.1f,RunImpact(oTarget, oSelf));

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetFifthLevelDamage(oTarget, 10, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Fire";
        int nReduction = GetFocusReduction(oSelf, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(oSelf, nDamage, sElement);
    //End Custom Spell-Function Block

    //Adjust damage based on Alchemite and Saving Throw
    int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

    //Class mechanics
    string sSpellType = "Fire";
    DoClassMechanic(sSpellType, sTargets, nFinalDamage, oTarget);
}


void RunImpact(object oTarget, object oCaster)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(446,oTarget,oCaster))
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
            int nDamage = GetFifthLevelDamage(oTarget, 10, sTargets);

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Fire";
            int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);
        int nDOTDamage = nFinalDamage / 2;

        effect eDam = EffectDamage(nDOTDamage, DAMAGE_TYPE_FIRE);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        eDam = EffectLinkEffects(eVis,eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f, RunImpact(oTarget, oCaster));
    }
}

