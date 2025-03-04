//::///////////////////////////////////////////////
//:: Combust
//:: X2_S0_Combust
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
   The initial eruption of flame causes  2d6 fire damage +1
   point per caster level(maximum +10)
   with no saving throw.

   Further, the creature must make
   a Reflex save or catch fire taking a further 1d6 points
   of damage. This will continue until the Reflex save is
   made.

   There is an undocumented artificial limit of
   10 + casterlevel rounds on this spell to prevent
   it from running indefinitly when used against
   fire resistant creatures with bad saving throws

*/
//:://////////////////////////////////////////////
// Created: 2003/09/05 Georg Zoeller
//:://////////////////////////////////////////////

#include "x2_I0_SPELLS"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void RunCombustImpact(object oTarget, object oCaster, int nLevel);

void main()
{

    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;

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
    // Calculate the damage
    //--------------------------------------------------------------------------
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetSecondLevelDamage(oTarget, nCasterLvl, sTargets);
        nDamage = nDamage / 3;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Fire";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(oCaster, nDamage, sElement);
    //End Custom Spell-Function Block

    //Adjust damage based on Alchemite and Saving Throw
    int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

    //--------------------------------------------------------------------------
    // Calculate the duration (we need a duration or bad things would happen
    // if someone is immune to fire but fails his safe all the time)
    //--------------------------------------------------------------------------
    int nDuration = nCasterLvl / 2;
    float fDuration = RoundsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);

    //--------------------------------------------------------------------------
    // Setup Effects
    //--------------------------------------------------------------------------
    effect eDam      = EffectDamage(nFinalDamage, DAMAGE_TYPE_FIRE);
    effect eDur      = EffectVisualEffect(498);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

       //-------------------------------------------------------------------
       // Apply VFX
       //-------------------------------------------------------------------
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        TLVFXPillar(VFX_IMP_FLAME_M, GetLocation(oTarget), 5, 0.1f,0.0f, 2.0f);

        //------------------------------------------------------------------
        // This spell no longer stacks. If there is one of that type,
        // that's enough
        //------------------------------------------------------------------
        if (GetHasSpellEffect(GetSpellId(),oTarget) || GetHasSpellEffect(SPELL_INFERNO,oTarget)  )
        {
            FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
            return;
        }

        //------------------------------------------------------------------
        // Apply the VFX that is used to track the spells duration
        //------------------------------------------------------------------
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDuration);

        //------------------------------------------------------------------
        // Tick damage after 6 seconds again
        //------------------------------------------------------------------
        DelayCommand(6.0, RunCombustImpact(oTarget, oCaster, nCasterLvl));

        //Class mechanics
        string sSpellType = "Fire";
        DoClassMechanic(sSpellType, sTargets, nDamage, oTarget);
    }
}

void RunCombustImpact(object oTarget, object oCaster, int nLevel)
{
     //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(SPELL_COMBUST,oTarget,oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //Run damage again
        int nCasterLvl = GetCasterLevel(OBJECT_SELF);

        //Start Custom Spell-Function Block
            //Get damage
            string sTargets = "Single";
            int nDamage = GetSecondLevelDamage(oTarget, nCasterLvl, sTargets);
            nDamage = nDamage / 3;

            //Buff damage by Amplification elvel
            nDamage = GetAmp(nDamage);

            //Get the Alchemite resistance reduction
            string sElement = "Fire";
            int nReduction = GetFocusReduction(oCaster, sElement);

            //Buff damage bonus on Alchemite
            nDamage = GetFocusDmg(oCaster, nDamage, sElement);
        //End Custom Spell-Function Block

        //Adjust damage based on Alchemite and Saving Throw
        int nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

        effect eDmg = EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
        effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);

        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);

        //------------------------------------------------------------------
        // After six seconds (1 round), check damage again
        //------------------------------------------------------------------
        DelayCommand(6.0f,RunCombustImpact(oTarget, oCaster, nLevel));
   }

}





