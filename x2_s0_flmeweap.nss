//Custom Flame Weapon by Alexander G.

#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "tsw_class_func"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oTarget = GetSpellTargetObject();
    int nDuration = 6;
    float fDuration = RoundsToSeconds(nDuration);
    fDuration = GetExtendSpell(fDuration);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Set and apply AOE object
    effect eAOE = EffectAreaOfEffect(AOE_MOB_FIRE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAOE, oTarget, fDuration);

    //Start Custom Spell-Function Block
        //Get damage
        string sTargets = "AOE";
        int nDamage = GetSecondLevelDamage(oTarget, GetCasterLevel(OBJECT_SELF), sTargets);
        nDamage = nDamage / 3;

        //Buff damage by Amplification elvel
        nDamage = GetAmp(nDamage);

        //Get the Alchemite resistance reduction
        string sElement = "Fire";
        int nReduction = GetFocusReduction(OBJECT_SELF, sElement);

        //Buff damage bonus on Alchemite
        nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
    //End Custom Spell-Function Block

    //Class mechanics
    string sSpellType = "Fire";
    DoClassMechanic(sSpellType, sTargets, nDamage, oTarget);

}
