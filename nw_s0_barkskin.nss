//::///////////////////////////////////////////////
//:: Thorncoat by Alexander G
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
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
    object oTarget = GetSpellTargetObject();
    object oDud;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nBonus = 2;
    float fDuration = GetExtendSpell(120.);
    //Glowing Eyes
    int nRace = GetRacialType(oTarget);
    int nGender = GetGender(oTarget);
    effect eVis = EffectVisualEffect(1016);

    effect eHead = EffectVisualEffect(132);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAC;
    //Signal spell cast at event
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BARKSKIN, FALSE));

    //Damage Shield
    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        int nDamage = GetThirdLevelDamage(oDud, nCasterLevel, sTargets);
        nDamage = nDamage / 3;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Acid";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    effect eShield = EffectDamageShield(nDamage, d4(1), DAMAGE_TYPE_PIERCING);

    //Make sure the Armor Bonus is of type Natural
    eAC = EffectACIncrease(nBonus);
    //eAC = EffectDamageReduction(10, DAMAGE_POWER_PLUS_FIVE, nBonus);
    effect eLink = EffectLinkEffects(eVis, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eShield);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHead, oTarget);
}
