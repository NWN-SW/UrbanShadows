//::///////////////////////////////////////////////
//:: Talio by Alexander G.
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    float fDuration = GetExtendSpell(60.0);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    object oCaster = OBJECT_SELF;
    object oNotSelf;
    effect eShield;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        nDamage = GetFifthLevelDamage(oNotSelf, nCasterLvl, sTargets);
        nDamage = nDamage / 4;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Fire";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(oCaster, nDamage, sElement);

    //End Custom Spell-Function Block

    eShield = EffectDamageShield(nDamage, d6(1), DAMAGE_TYPE_FIRE);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oCaster, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //  *GZ: No longer stack this spell
    if(GetHasSpellEffect(GetSpellId(),oCaster))
    {
         RemoveSpellEffects(GetSpellId(), OBJECT_SELF, oCaster);
    }

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCaster, fDuration);

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, sTargets, nDamage, oCaster);
    DoClassMechanic("Force", sTargets, nDamage, oCaster);
}

