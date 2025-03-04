//::///////////////////////////////////////////////
//:: Thorncoat by Alexander G
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
    effect eVis = EffectVisualEffect(448);
    float fDuration = GetExtendSpell(120.0);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oNotSelf;
    effect eShield;
    effect eAC = EffectACIncrease(5, AC_NATURAL_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        nDamage = GetSecondLevelDamage(oNotSelf, nCasterLvl, sTargets);
        nDamage = nDamage / 4;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Acid";
        int nReduction = GetFocusReduction(oCaster, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(oCaster, nDamage, sElement);

    //End Custom Spell-Function Block

    eShield = EffectDamageShield(nDamage, d6(1), DAMAGE_TYPE_ACID);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eAC);

    //Fire cast spell at event for the specified target
    SignalEvent(oCaster, EventSpellCastAt(oTarget, GetSpellId(), FALSE));

    //  *GZ: No longer stack this spell
    if (GetHasSpellEffect(GetSpellId(),oCaster))
    {
         RemoveSpellEffects(GetSpellId(), oTarget, oCaster);
    }

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, fDuration);

    //Class mechanics
    string sSpellType = "Buff";
    DoClassMechanic(sSpellType, sTargets, nDamage, oCaster);
}

