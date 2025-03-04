//::///////////////////////////////////////////////
//:: [Slay Living]
//:: [NW_S0_SlayLive.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Caster makes a touch attack and if the target
//:: fails a Fortitude save they die.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: January 22nd / 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 25, 2001

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_dmg_inc"

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
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLAY_LIVING));
        //Make SR check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            string sElement = "Nega";
            int nDC = GetSpellSaveDC();
            int nBonusDC = GetFocusDC(OBJECT_SELF, sElement);
            nDC = nDC + nBonusDC;

            //Roll damage for each target
            nDamage = GetFifthLevelDamage(oTarget, nCasterLevel, nMetaMagic, "Single");

            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = GetFocusDmg(OBJECT_SELF, nDamage, sElement);
            nDamage = GetFortDamage(oTarget, nDC, nDamage);
            //Apply the death effect and VFX impact
            //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);

        }
    }
}
