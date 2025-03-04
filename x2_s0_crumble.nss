//::///////////////////////////////////////////////
//:: Crumble by Alexander G.
//:://////////////////////////////////////////////


#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "X2_i0_spells"
#include "spell_dmg_inc"
#include "tsw_class_func"

void DoCrumble (int nDam, object oCaster, object oTarget, int nDC);

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

    object oCaster  = OBJECT_SELF;
    object oTarget  = GetSpellTargetObject();
    int  nCasterLvl = GetCasterLevel(oCaster);
    float  fDist = GetDistanceBetween(oCaster, oTarget);
    float  fDelay = 0.25;
    effect eMissile = EffectVisualEffect(354);
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    int nLevel = GetCasterLevel(OBJECT_SELF);
    //Debuff
    effect eAC = EffectACDecrease(6, AC_NATURAL_BONUS);
    float fDuration = GetExtendSpell(30.0);

    SignalEvent(oTarget, EventSpellCastAt(oCaster, GetSpellId()));

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "Single";
        int nDamage = GetSixthLevelDamage(oTarget, nCasterLvl, sTargets);

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Soni";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    //Adjust duration based on target saves
    fDuration = GetFortDuration(oTarget, nReduction, fDuration);

    //Adjust damage based on Alchemite and Saving Throw
    int nFinalDamage = GetFortDamage(oTarget, nReduction, nDamage);

    effect eDam = EffectDamage(nFinalDamage, DAMAGE_TYPE_SONIC);

    if (nDamage > 0)
    {
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, fDuration));
    }

    //Class mechanics
    DoClassMechanic("Force", sTargets, nFinalDamage, oTarget);
    DoClassMechanic("Debuff", sTargets, nFinalDamage, oTarget);
}

