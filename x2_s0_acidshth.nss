//::///////////////////////////////////////////////
//:: Corrosive Sheath by Alexander G.
//::///////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "spell_dmg_inc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
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
    effect eVis = EffectVisualEffect(448);
    float fDuration = GetExtendSpell(120.0);
    int nDamage;
    int nFinalDamage;
    string sTargets;
    string sElement;
    int nReduction;

    object oTarget = OBJECT_SELF;
    effect eShield;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Roll damage for each target
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    //Start Custom Spell-Function Block
        //Get damage
        sTargets = "AOE";
        nDamage = GetFifthLevelDamage(oTarget, nCasterLvl, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        sElement = "Acid";
        nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    //Adjust damage based on Alchemite and Saving Throw
    nFinalDamage = GetReflexDamage(oTarget, nReduction, nDamage);

    // 2003-07-07: Stacking Spell Pass, Georg
    RemoveEffectsFromSpell(oTarget, GetSpellId());

    //Apply the VFX impact and effects
    eShield = EffectDamageShield(nFinalDamage, DAMAGE_BONUS_1d6, DAMAGE_TYPE_ACID);
    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);

    //Class mechanics
    DoClassMechanic("Buff", sTargets, nFinalDamage, OBJECT_SELF);
    //DoClassMechanic("Earth", sTargets, nFinalDamage, OBJECT_SELF);
}

