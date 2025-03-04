//Werehawk Heal by Alexander G.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"
#include "x2_inc_shifter"

void main()
{

    /*
      Spellcast Hook Code
      Added 2003-06-20 by Georg
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook

    //--------------------------------------------------------------------------
    // Enforce artifical use limit on that ability
    //--------------------------------------------------------------------------
    if (ShifterDecrementGWildShapeSpellUsesLeft() <1 )
    {
        FloatingTextStrRefOnCreature(83576, OBJECT_SELF);
        return;
    }

    //Declare major variables
    object oTarget;
    object oHeal;
    int nCasterLvl = GetLevelByClass(35);
    int nDamagen, nModify, nHP;
    int nMetaMagic = GetMetaMagicFeat();
    effect eKill;
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eImpact = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
    float fDelay;

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    //Get first target in shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        // * May 2003: Heal Neutrals as well
        if(!GetIsReactionTypeHostile(oTarget) || GetFactionEqual(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE, FALSE));
            //Roll damage for each target
            nCasterLvl = nCasterLvl * 2;
            int nHP = nCasterLvl * GetAbilityModifier(4);

            //Set healing effect
            eHeal = EffectHeal(nHP);
            //Apply heal effect and VFX impact
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
        }
        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}
